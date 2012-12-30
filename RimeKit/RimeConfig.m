//
//  RimeConfig.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfig.h"

#import <YACYAML/YACYAML.h>
#import "SHKit.h"

#import "RimeConstants.h"

@implementation RimeConfig

- (RimeConfig *)initWithConfigName:(NSString *)name {
    NSString *folder = [RIME_CONFIG_FOLDER stringByExpandingTildeInPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folder]) {
        [SHKit alertWithMessage:@"Rime configuration folder does not exist"
                           info:[NSString stringWithFormat:@"Path: %@\n\nYou should run the Deploy command from Squirrel IME menu before any customization.", folder]
                   cancelButton:@"OK"];
        
        return nil;
    }
    
    _configName = [name stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _customConfigName = [[name stringByAppendingString:RIME_CUSTOM_EXT] stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _configPath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _configName, nil]];
    _customConfigPath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _customConfigName, nil]];
    
    [self reload];
    
    return self;
}

- (RimeConfig *)initWithSchemaName:(NSString *)name {
    return [self initWithConfigName:[name stringByAppendingString:RIME_SCHEMA_EXT]];
}

+ (RimeConfig *)defaultConfig {
    RimeConfig *config = [[RimeConfig alloc] initWithConfigName:RIME_DEFAULT_CONFIG_NAME];
    return config;
}

+ (RimeConfig *)squirrelConfig {
    RimeConfig *config = [[RimeConfig alloc] initWithConfigName:RIME_SQUIRREL_CONFIG_NAME];
    return config;
}

- (void)reload {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_configPath]) {
        NSLog(@"WARNING: Requested config file does not exist: %@", _configPath);
        return;
    }
    
    _config = [[NSString stringWithContentsOfFile:_configPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_customConfigPath]) {
        NSLog(@"INFO: Requested custom config file does not exist: %@. Will create new one while patching value.", _customConfigPath);
        _customConfig = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"patch", nil];
        return;
    }
    
    _customConfig = [[NSString stringWithContentsOfFile:_customConfigPath encoding:NSUTF8StringEncoding error:nil] YACYAMLDecode];
}

- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath {
    
    
    return YES;
}

- (NSString *)description {
    NSString *format = @"RimeConfig[%@]:\n%@\nRimeConfig[%@]:\n%@";
    NSString *desc = [NSString stringWithFormat:format, _configPath, _config, _customConfigPath, _customConfig];
    
    return desc;
}

@end
