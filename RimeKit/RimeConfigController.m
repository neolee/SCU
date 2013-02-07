//
//  RimeConfigController.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfigController.h"
#import "RimeConstants.h"
#import "RimeConfigAppOption.h"

@implementation RimeConfigController

#define SHOW_NOTIFICATION_WHEN_VALUES @[@"always", @"growl_is_running", @"never"]

- (id)init:(RimeConfigError **)error {
    // Load configuration from disk
    _defaultConfig = [RimeConfig defaultConfig:error];
    if (!_defaultConfig) return nil;    
    _squirrelConfig = [RimeConfig squirrelConfig:error];
    if (!_squirrelConfig) return nil;
    
//    NSLog(@"squirrelConfig:\n%@", _squirrelConfig);
    
    // Load properties from configurations
    _useUSKeyboardLayout = [_squirrelConfig boolForKey:@"us_keyboard_layout"];
    NSString *stringShowNotificationWhen = [_squirrelConfig stringForKey:@"show_notifications_when"];
    _showNotificationWhen = [SHOW_NOTIFICATION_WHEN_VALUES indexOfObject:stringShowNotificationWhen];

    _showNotificationViaNotificationCenter = [_squirrelConfig boolForKey:@"show_notifications_via_notification_center"];
    
    _isHorizontal = [_squirrelConfig boolForKeyPath:@"style.horizontal"];
    _lineSpacing = [_squirrelConfig integerForKeyPath:@"style.line_spacing"];
    _numberOfCandidates = [_defaultConfig integerForKeyPath:@"menu.page_size"];
    _fontFace = [_squirrelConfig stringForKeyPath:@"style.font_face"];
    _fontPoint = [_squirrelConfig integerForKeyPath:@"style.font_point"];
    _cornerRadius = [_squirrelConfig integerForKeyPath:@"style.corner_radius"];
    _borderHeight = [_squirrelConfig integerForKeyPath:@"style.border_height"];
    _borderWidth = [_squirrelConfig integerForKeyPath:@"style.border_width"];
    _alpha = [_squirrelConfig floatForKeyPath:@"style.alpha"];
    _colorTheme = [_squirrelConfig stringForKeyPath:@"style.color_scheme"];
    
    [self loadColorThemes];
    [self loadAppOptions];

    // Fix default value if needed
    if (_fontPoint == 0) _fontPoint = 13;
    if (_alpha == 0.0) _alpha = 1.0;

    return self;
}

- (void)loadColorThemes {
    NSDictionary *dict = [_squirrelConfig valueForKey:@"preset_color_schemes"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [array addObject:@{@"name" : [obj objectForKey:@"name"], @"value" : key}];
    }];
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *key1 = [(NSDictionary *)obj1 objectForKey:@"value"];
        NSString *key2 = [(NSDictionary *)obj2 objectForKey:@"value"];
        return [key1 compare:key2];
        /* The method below may be more meaningful but not now
        NSString *name1 = [(NSDictionary *)obj1 objectForKey:@"name"];
        NSString *name2 = [(NSDictionary *)obj2 objectForKey:@"name"];
        return [name1 localizedStandardCompare:name2];
         */
    }];
    [array insertObject:@{@"name": @"系统／Native", @"value": @"native"} atIndex:0];

    _colorThemes = [NSArray arrayWithArray:array];
}

- (void)loadAppOptions {
    NSDictionary *dict = [_squirrelConfig valueForKey:@"app_options"];
    _appOptions = [[NSMutableArray alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        RimeConfigAppOption *option = [[RimeConfigAppOption alloc] init];
        NSDictionary *dictAppOption = (NSDictionary *)obj;
        [option setAppId:key];
        [option setAsciiMode:[dictAppOption valueForKey:@"ascii_mode"]];
        [option setSoftCursor:[dictAppOption valueForKey:@"soft_cursor"]];
        [_appOptions addObject:option];
    }];
}

#pragma mark - Setter overrides

- (void)setUseUSKeyboardLayout:(BOOL)value {
    if (_useUSKeyboardLayout != value) {
        _useUSKeyboardLayout = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithBool:_useUSKeyboardLayout] forKeyPath:@"us_keyboard_layout" error:&error];
    }
}

- (void)setShowNotificationWhen:(NSUInteger)value {
    if (_showNotificationWhen != value) {
        _showNotificationWhen = value;        
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[SHOW_NOTIFICATION_WHEN_VALUES objectAtIndex:_showNotificationWhen] forKeyPath:@"show_notifications_when" error:&error];
    }
}

- (void)setShowNotificationViaNotificationCenter:(BOOL)value {
    if (_showNotificationViaNotificationCenter != value) {
        _showNotificationViaNotificationCenter = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithBool:_showNotificationViaNotificationCenter] forKeyPath:@"show_notifications_via_notification_center" error:&error];
    }
}

- (void)setIsHorizontal:(BOOL)value {
    if (_isHorizontal != value) {
        _isHorizontal = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithBool:_isHorizontal] forKeyPath:@"style.horizontal" error:&error];
    }
}

- (void)setLineSpacing:(NSInteger)value {
    if (_lineSpacing != value) {
        _lineSpacing = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_lineSpacing] forKeyPath:@"style.line_spacing" error:&error];
    }
}

- (void)setNumberOfCandidates:(NSInteger)value {
    if (_numberOfCandidates != value) {
        _numberOfCandidates = value;
        
        RimeConfigError *error;
        [_defaultConfig patchValue:[NSNumber numberWithInteger:_numberOfCandidates] forKeyPath:@"menu.page_size" error:&error];
    }
}

- (void)setFontFace:(NSString *)value {
    if (_fontFace != value) {
        _fontFace = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:_fontFace forKeyPath:@"style.font_face" error:&error];
    }
}

- (void)setFontPoint:(NSInteger)value {
    if (_fontPoint != value) {
        _fontPoint = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_fontPoint] forKeyPath:@"style.font_point" error:&error];
    }
}

- (void)setCornerRadius:(NSInteger)value {
    if (_cornerRadius != value) {
        _cornerRadius = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_cornerRadius] forKeyPath:@"style.corner_radius" error:&error];
    }
}

- (void)setBorderHeight:(NSInteger)value {
    if (_borderHeight != value) {
        _borderHeight = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_borderHeight] forKeyPath:@"style.border_height" error:&error];
    }
}

- (void)setBorderWidth:(NSInteger)value {
    if (_borderWidth != value) {
        _borderWidth = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithInteger:_borderWidth] forKeyPath:@"style.border_width" error:&error];
    }
}

- (void)setAlpha:(float)value {
    if (_alpha != value) {
        _alpha = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:[NSNumber numberWithFloat:_alpha] forKeyPath:@"style.alpha" error:&error];
    }
}

- (void)setColorTheme:(NSString *)value {
    if (_colorTheme != value) {
        _colorTheme = value;
        
        RimeConfigError *error;
        [_squirrelConfig patchValue:_colorTheme forKeyPath:@"style.color_scheme" error:&error];
    }
}

- (void)setAppOptionFor:(NSString *)appId asciiMode:(BOOL)ascii {
    RimeConfigError *error;
    [_squirrelConfig patchValue:[NSNumber numberWithBool:ascii]
                forKeyPathArray:@[@"app_options", appId, @"ascii_mode"] error:&error];
}

- (void)setAppOptionFor:(NSString *)appId softCursor:(BOOL)cursor {
    RimeConfigError *error;
    [_squirrelConfig patchValue:[NSNumber numberWithBool:cursor]
                forKeyPathArray:@[@"app_options", appId, @"soft_cursor"] error:&error];
}

#pragma mark - Class helpers

+ (NSString *)rimeFolder {
    return [RimeConfig rimeFolder];
}

+ (BOOL)checkRimeFolder {
    return [RimeConfig checkRimeFolder];
}

@end
