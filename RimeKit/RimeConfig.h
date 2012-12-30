//
//  RimeConfig.h
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeConfig : NSObject {
    NSString *_configName;
    NSString *_configPath;
    NSString *_customConfigName;
    NSString *_customConfigPath;
    
    NSDictionary *_config;
    NSMutableDictionary *_customConfig;
}

- (void)reload;
- (BOOL)patchValue:(id)value forKeyPath:(NSString *)keyPath;

- (RimeConfig *)initWithConfigName:(NSString *)name;
- (RimeConfig *)initWithSchemaName:(NSString *)name;
+ (RimeConfig *)defaultConfig;
+ (RimeConfig *)squirrelConfig;

- (NSString *)description;
@end
