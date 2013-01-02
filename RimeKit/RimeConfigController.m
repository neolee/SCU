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

- (void)setUseUSKeyboardLayout:(BOOL)value {
    if (_useUSKeyboardLayout != value) {
        _useUSKeyboardLayout = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithBool:_useUSKeyboardLayout] forKeyPath:@"patch.us_keyboard_layout" error:&error];
    }
}

- (void)setShowNotificationWhen:(NSUInteger)value {
    // Input value: 0-always 1-appropriate=growl_is_running 2-never
    NSArray *values = [NSArray arrayWithObjects:@"always", @"growl_is_running", @"never", nil];
    
    _enableNotifications = (value != 2);
    _enableBuiltinNotifications = (value == 0);
    
    RimeConfigError *error;
    [_squirrelConfig patchValue:[values objectAtIndex:value] forKeyPath:@"patch.show_notifications_when" error:&error];
}

#pragma mark - Class helpers

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
