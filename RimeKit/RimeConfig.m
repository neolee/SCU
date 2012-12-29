//
//  RimeConfig.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfig.h"
#import "RimeConstants.h"
#import <YACYAML/YACYAML.h>

@implementation RimeConfig

- (RimeConfig *)initWithConfigName:(NSString *)name {
    NSString *folder = [RIME_CONFIG_FOLDER stringByExpandingTildeInPath];
    _fileName = [name stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _customPatchName = [[name stringByAppendingString:RIME_CUSTOM_EXT] stringByAppendingString:RIME_CONFIG_FILE_EXT];
    _filePath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _fileName, nil]];
    _customPatchPath = [NSString pathWithComponents:[NSArray arrayWithObjects:folder, _customPatchName, nil]];
    
    
    
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

@end
