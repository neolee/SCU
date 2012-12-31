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
    _enableNotifications = YES;
    _enableBuiltinNotifications = NO;

    // Load configuration from disk
    _defaultConfig = [RimeConfig defaultConfig:error];
    if (!_defaultConfig) return nil;    
    _squirrelConfig = [RimeConfig squirrelConfig:error];
    if (!_squirrelConfig) return nil;
    NSLog(@"Squirrel Config\n%@", _squirrelConfig);
    
    // Set patched configuration properties
    _useUSKeyboardLayout = [_squirrelConfig boolForKey:@"us_keyboard_layout"];
    NSString *showNotificationWhen = [_squirrelConfig stringForKey:@"show_notifications_when"];
    _enableNotifications = ![showNotificationWhen isEqualToString:@"never"];
    _enableBuiltinNotifications = [showNotificationWhen isEqualToString:@"always"];

    return self;
}

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
