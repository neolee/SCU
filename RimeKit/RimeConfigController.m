//
//  RimeConfigController.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfigController.h"
#import "RimeConstants.h"

@implementation RimeConfigController

- (id)init:(RimeConfigError **)error {
    // Configuration defaults
    _useUSKeyboardLayout = YES;
    _enableNotifications = NO;
    _enableBuiltinNotifications = NO;

    // Load configuration from disk
    _defaultConfig = [RimeConfig defaultConfig:error];
    if (!_defaultConfig) return nil;
    NSLog(@"Default config loaded.\n%@", _defaultConfig);
    
    _squirrelConfig = [RimeConfig squirrelConfig:error];
    if (!_squirrelConfig) return nil;
    NSLog(@"Squirrel config loaded.\n%@", _squirrelConfig);
    
    
    

    return self;
}

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
