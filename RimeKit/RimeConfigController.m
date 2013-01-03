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

    // Fix some default value
    if (_fontPoint == 0) _fontPoint = 13;
    if (_alpha == 0.0) _alpha = 1.0;

    return self;
}

#pragma mark - Setter overrides

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

- (void)setIsHorizontal:(BOOL)value {
    if (_isHorizontal != value) {
        _isHorizontal = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithBool:_isHorizontal] forKeyPath:@"patch.style.horizontal" error:&error];
    }
}

- (void)setNumberOfCandidates:(NSInteger)value {
    if (_numberOfCandidates != value) {
        _numberOfCandidates = value;
        
        RimeConfigError *error;
        [_defaultConfig patchValue:[NSNumber numberWithInteger:_numberOfCandidates] forKeyPath:@"patch.menu.page_size" error:&error];
    }
}

- (void)setFontFace:(NSString *)value {
    if (_fontFace != value) {
        _fontFace = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:_fontFace forKeyPath:@"patch.style.font_face" error:&error];
    }
}

- (void)setFontPoint:(NSInteger)value {
    if (_fontPoint != value) {
        _fontPoint = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_fontPoint] forKeyPath:@"patch.style.font_point" error:&error];
    }
}

- (void)setCornerRadius:(NSInteger)value {
    if (_cornerRadius != value) {
        _cornerRadius = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_cornerRadius] forKeyPath:@"patch.style.corner_radius" error:&error];
    }
}

- (void)setBorderHeight:(NSInteger)value {
    if (_borderHeight != value) {
        _borderHeight = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_borderHeight] forKeyPath:@"patch.style.border_height" error:&error];
    }
}

- (void)setBorderWidth:(NSInteger)value {
    if (_borderWidth != value) {
        _borderWidth = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_borderWidth] forKeyPath:@"patch.style.border_width" error:&error];
    }
}

- (void)setAlpha:(float)value {
    if (_alpha != value) {
        _alpha = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithFloat:_alpha] forKeyPath:@"patch.style.alpha" error:&error];
    }
}

- (void)setColorTheme:(NSString *)value {
    if (_colorTheme != value) {
        _colorTheme = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:_colorTheme forKeyPath:@"patch.style.color_scheme" error:&error];
    }
}

#pragma mark - Class helpers

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
