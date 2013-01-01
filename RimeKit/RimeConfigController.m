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
    
    // Set patched configuration properties
    _useUSKeyboardLayout = [_squirrelConfig boolForKey:@"us_keyboard_layout"];
    NSString *showNotificationWhen = [_squirrelConfig stringForKey:@"show_notifications_when"];
    _enableNotifications = ![showNotificationWhen isEqualToString:@"never"];
    _enableBuiltinNotifications = [showNotificationWhen isEqualToString:@"always"];
    
    _isHorizontal = [_squirrelConfig boolForKeyPath:@"style.horizontal"];
    _numberOfCandidates = [_defaultConfig integerForKeyPath:@"menu.page_size"];
    _fontFace = [_squirrelConfig stringForKeyPath:@"style.font_face"];
    _fontPoint = [_squirrelConfig integerForKeyPath:@"style.font_point"];
    _cornerRadius = [_squirrelConfig integerForKeyPath:@"style.corner_radius"];
    _borderHeight = [_squirrelConfig integerForKeyPath:@"style.border_height"];
    _borderWidth = [_squirrelConfig integerForKeyPath:@"style.border_width"];
    _alpha = [_squirrelConfig floatForKeyPath:@"style.alpha"];
    _colorTheme = [_squirrelConfig stringForKeyPath:@"style.color_scheme"];

    return self;
}

#pragma mark - Class helpers

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
