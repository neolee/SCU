//
//  RimeConfig.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfig.h"

#import <YACYAML/YACYAML.h>

#import "RimeConstants.h"

@implementation RimeConfig

- (RimeConfig *)initWithSchemaName:(NSString *)name error:(RimeConfigError **)error {
    return [self initWithConfigName:[name stringByAppendingString:RIME_SCHEMA_EXT] error:error];
}

// initWithConfigName return nil when Rime configuration folder not exists OR
// requested config file not exists. Caller should prompt user to run Deploy
// command from Squirrel IME menu before any customization.
- (RimeConfig *)initWithConfigName:(NSString *)name error:(RimeConfigError **)error {
    NSString *folder = [RimeConfig rimeFolder];
    
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
    
    if (![self reload:error]) {
        return nil;
    };
    
    return self;
}

- (BOOL)reload:(RimeConfigError **)error {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_configPath]) {
        NSLog(@"WARNING: Requested config file does not exist: %@", _configPath);
        if (error) {
            *error = [[RimeConfigError alloc] init];
            [*error setErrorType:RimeConfigFileNotExistsError];
            [*error setConfigFile:_configPath];
        }        
        return NO;
    }
    _config = [[NSString stringWithContentsOfFile:_configPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_customConfigPath]) {
        NSLog(@"INFO: Requested custom config file does not exist: %@. Will create new while patching value.", _customConfigPath);
        _customConfig = [[NSMutableDictionary alloc] init];
    }
    else {
        _customConfig = [[NSString stringWithContentsOfFile:_customConfigPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode];
    }
    
    return YES;
}

- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath error:(RimeConfigError **)error {
    return [self patchValue:value forKeyPath:keyPath toDisk:YES error:error];
}

- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath toDisk:(BOOL)writeToDisk error:(RimeConfigError **)error {
    assert(_customConfig);

    
    
    
    return YES;
}

+ (NSString *)rimeFolder {
    return [RIME_CONFIG_FOLDER stringByExpandingTildeInPath];
}

+ (BOOL)checkRimeFolder {
    NSString *folder = [RimeConfig rimeFolder];
    
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
