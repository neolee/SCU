//
//  RimeConfig.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfig.h"

#import <YACYAML/YACYAML.h>

#import "NSObject+DeepMutableCopy.h"
#import "NSDictionary+KeyPath.h"

#import "RimeConstants.h"

@implementation RimeConfig

- (RimeConfig *)initWithBundledSchemaName:(NSString *)name error:(RimeConfigError **)error {
    _fromBundle = YES;
    return [self initWithConfigName:[name stringByAppendingString:RIME_SCHEMA_EXT] root:[RimeConfig sharedSupportFolder] error:error];
}

- (RimeConfig *)initWithSchemaName:(NSString *)name error:(RimeConfigError **)error {
    return [self initWithConfigName:[name stringByAppendingString:RIME_SCHEMA_EXT] error:error];
}

- (RimeConfig *)initWithConfigName:(NSString *)name error:(RimeConfigError **)error {
    return [self initWithConfigName:name root:[RimeConfig rimeFolder] error:error];
}

// initWithConfigName return nil when root configuration folder not exists OR
// requested config file not exists. Caller should prompt user to run Deploy
// command from Squirrel IME menu before any customization.
- (RimeConfig *)initWithConfigName:(NSString *)name root:(NSString *)folder error:(RimeConfigError **)error {
    if (![[NSFileManager defaultManager] fileExistsAtPath:folder]) {
        if (error) {
            *error = [[RimeConfigError alloc] init];
            [*error setErrorType:RimeConfigFolderNotExistsError];
            [*error setConfigFolder:folder];
        }
        
        return nil;
    }
    
    _configName = [name stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _customConfigName = [[name stringByAppendingString:RIME_CUSTOM_EXT] stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _configPath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _configName, nil]];
    _customConfigPath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _customConfigName, nil]];
    _customConfigExists = NO;
    
    if (![self reload:error]) {
        return nil;
    };
    
    return self;
}

- (BOOL)reload:(RimeConfigError **)error {
    // Key assumption about loading configuration:
    // 1. M-RimeConfig, C-RimeConfigController and V-PreferencesViewController.
    // 2. Every time Squirrel run its Deploy procedure all patch values in *.custom.yaml will be merge into
    //    the actual configuration file *.yaml. Values in _config are all that matter.
    // 3. If we write something to the *.custom.yaml by calling patchValue then reload configurations without
    //    running Squirrel's Deploy command, data in _config and _customConfig will be different.
    // 4. To keep logical consistency RimeConfig should simulate Squirrel's merge procedure when populate
    //    values (see valueForKey and valueForKeyPath method). i.e. When RimeConfigController requests value
    //    for a key(path) RimeConfig always gives out merged value.
        
    if (![[NSFileManager defaultManager] fileExistsAtPath:_configPath]) {
        NSLog(@"WARNING: Config file does not exist: %@", _configPath);
        if (error) {
            *error = [[RimeConfigError alloc] init];
            [*error setErrorType:RimeConfigFileNotExistsError];
            [*error setConfigFile:_configPath];
        }        
        return NO;
    }
    _config = [[NSString stringWithContentsOfFile:_configPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode];
    
    if (_fromBundle) return YES;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_customConfigPath]) {
        NSLog(@"INFO: Custom config file does not exist: %@. Will create new one while patching values.", _customConfigPath);
    }
    else {
        _customConfig = [[[NSString stringWithContentsOfFile:_customConfigPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode] deepMutableCopy];
        _customConfigExists = YES;
    }
    
    return YES;
}

#pragma mark - Write model patch value

- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath error:(RimeConfigError **)error {
    return [self patchValue:value forKeyPath:keyPath toDisk:YES error:error];
}

- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath toDisk:(BOOL)writeToDisk error:(RimeConfigError **)error {
    NSArray *keyPathArray = [keyPath componentsSeparatedByString:@"."];
    return [self patchValue:value forKeyPathArray:keyPathArray toDisk:writeToDisk error:error];
}

- (BOOL)patchValue:(id)value forKeyPathArray:(NSArray *)keyPathArray error:(RimeConfigError **)error {
    return [self patchValue:value forKeyPathArray:keyPathArray toDisk:YES error:error];
}

- (BOOL)patchValue:(id)value forKeyPathArray:(NSArray *)keyPathArray toDisk:(BOOL)writeToDisk error:(RimeConfigError **)error {
    // Key assumption about patching value:
    // 1. M-RimeConfig, C-RimeConfigController and V-PreferencesViewController.
    // 2. One RimeConfig object represents a *.custom.yaml file. Any modification on the object should be
    //    sync-ed to the file immediately.
    // 3. If the file has been changed by other apps SCU may override the changes from other apps.
    // 4. If RimeConfigController orders RimeConfig to patch a value RimeConfig will save it in _customConfig
    //    and try to sync to the disk file. If syncing to file fails, _customConfig will NOT rollback. All
    //    changes will be re-tried next time patchValue being called.
    
    if (!_customConfigExists) {
        _customConfig = [[NSMutableDictionary alloc] init];
    }
    assert(_customConfig);
    
    [_customConfig setObject:value forKeyPathArray:[self patchKeyPathArray:keyPathArray]];
    if (!_customConfigExists) _customConfigExists = YES;
    
    if (writeToDisk) {
        return [[_customConfig YACYAMLEncodedString] writeToFile:_customConfigPath
                                                      atomically:NO
                                                        encoding:NSUTF8StringEncoding
                                                           error:error];
    }
    
    return YES;
    
}

#pragma mark - Read model attribute

- (NSString *)patchKeyPath:(NSString *)keyPath {
    return [[RIME_CUSTOM_ROOT_KEY stringByAppendingString:@"."] stringByAppendingString:keyPath];
}

- (NSArray *)patchKeyPathArray:(NSArray *)keyPathArray {
    return [@[RIME_CUSTOM_ROOT_KEY] arrayByAddingObjectsFromArray:keyPathArray];
}

- (id)valueForKey:(NSString *)key {
    // See comment in method reload
    if (_customConfigExists && [_customConfig valueForKeyPath:[self patchKeyPath:key]]) {
        return [_customConfig valueForKeyPath:[self patchKeyPath:key]];
    }
    else {
        return [_config valueForKey:key];
    }
}

- (id)valueForKeyPath:(NSString *)keyPath {
    // See comment in method reload
    if (_customConfigExists && [_customConfig valueForKeyPath:[self patchKeyPath:keyPath]]) {
        return [_customConfig valueForKeyPath:[self patchKeyPath:keyPath]];
    }
    else {
        return [_config valueForKeyPath:keyPath];
    }
}

- (NSArray *)arrayForKey:(NSString *)key {
    return (NSArray *)[self valueForKey:key];
}

- (NSArray *)arrayForKeyPath:(NSString *)keyPath {
    return (NSArray *)[self valueForKeyPath:keyPath];
}

- (BOOL)boolForKey:(NSString *)key {
    return (BOOL)[self integerForKey:key];
}

- (BOOL)boolForKeyPath:(NSString *)keyPath {
    return (BOOL)[self integerForKeyPath:keyPath];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return (NSDictionary *)[self valueForKey:key];    
}

- (NSDictionary *)dictionaryForKeyPath:(NSString *)keyPath {
    return (NSDictionary *)[self valueForKeyPath:keyPath];
}

- (float)floatForKey:(NSString *)key {
    return [[self stringForKey:key] floatValue];
}

- (float)floatForKeyPath:(NSString *)keyPath {
    return [[self stringForKeyPath:keyPath] floatValue];
}

- (NSInteger)integerForKey:(NSString *)key{
    return [[self stringForKey:key] integerValue];
}

- (NSInteger)integerForKeyPath:(NSString *)keyPath {
    return [[self stringForKeyPath:keyPath] integerValue];
}

- (NSString *)stringForKey:(NSString *)key {
    return (NSString *)[self valueForKey:key];
}

- (NSString *)stringForKeyPath:(NSString *)keyPath {
    return (NSString *)[self valueForKeyPath:keyPath];
}

#pragma mark - Class helpers

+ (NSString *)rimeFolder {
    return [RIME_CONFIG_FOLDER stringByExpandingTildeInPath];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkFolder:[RimeConfig rimeFolder]];
}

+ (NSString *)sharedSupportFolder {
    return [RIME_SHARED_SUPPORT_FOLDER stringByExpandingTildeInPath];
}

+ (BOOL)checkSharedSupportFolder {
    return [RimeConfig checkFolder:[RimeConfig sharedSupportFolder]];
}

+ (BOOL)checkFolder:(NSString *)folder {
    if (![[NSFileManager defaultManager] fileExistsAtPath:folder]) {
        NSLog(@"WARNING: Rime config folder does not exist: %@", folder);
        return NO;
    }
    
    return YES;
}

+ (RimeConfig *)defaultConfig:(RimeConfigError **)error {
    RimeConfig *config = [[RimeConfig alloc] initWithConfigName:RIME_DEFAULT_CONFIG_NAME error:error];
    return config;
}

+ (RimeConfig *)squirrelConfig:(RimeConfigError **)error {
    RimeConfig *config = [[RimeConfig alloc] initWithConfigName:RIME_SQUIRREL_CONFIG_NAME error:error];
    return config;
}

- (NSString *)description {
    NSString *format = @"RimeConfig[%@]:\n%@\nRimeConfig[%@]:\n%@";
    NSString *desc = [NSString stringWithFormat:format, _configPath, _config, _customConfigPath, _customConfig];
    
    return desc;
}

@end
