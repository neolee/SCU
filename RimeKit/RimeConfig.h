//
//  RimeConfig.h
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RimeConfigError.h"

@interface RimeConfig : NSObject {
    NSString *_configName;
    NSString *_configPath;
    NSString *_customConfigName;
    NSString *_customConfigPath;
    
    // _config contains all key-value pairs from the config file
    // _customConfig contains all patch key-value pairs from the custom config file WITHOUT the "patch" root key (which will be added when writing to disk)
    NSDictionary *_config;
    NSMutableDictionary *_customConfig;
}

- (BOOL)reload:(RimeConfigError **)error;
- (RimeConfig *)initWithConfigName:(NSString *)name error:(RimeConfigError **)error;
- (RimeConfig *)initWithSchemaName:(NSString *)name error:(RimeConfigError **)error;
- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath error:(RimeConfigError **)error;
- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath toDisk:(BOOL)writeToDisk error:(RimeConfigError **)error;

+ (RimeConfig *)defaultConfig:(RimeConfigError **)error;
+ (RimeConfig *)squirrelConfig:(RimeConfigError **)error;

+ (NSString *)rimeFolder;
+ (BOOL)checkRimeFolder;

- (NSString *)description;
@end
