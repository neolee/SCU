//
//  RimeConfigController.h
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RimeConfig.h"

@interface RimeConfigController : NSObject {
    RimeConfig *_defaultConfig;
    RimeConfig *_squirrelConfig;

    NSArray *_schemaIds;
    NSMutableSet *_enabledSchemaIds;
}

@property NSMutableArray *schemata;

// Category: General
@property (nonatomic) BOOL useUSKeyboardLayout;
@property (nonatomic) NSUInteger showNotificationWhen;
@property (nonatomic) BOOL showNotificationViaNotificationCenter;

// Category: Style
@property (nonatomic) BOOL isHorizontal;
@property (nonatomic) NSInteger lineSpacing;
@property (nonatomic) NSInteger numberOfCandidates;
@property (nonatomic) NSString *fontFace;
@property (nonatomic) NSInteger fontPoint;
@property (nonatomic) NSInteger cornerRadius;
@property (nonatomic) NSInteger borderHeight;
@property (nonatomic) NSInteger borderWidth;
@property (nonatomic) float alpha;
@property (readonly) NSArray *colorThemes;
@property (nonatomic) NSString *colorTheme;

// Category: Apps
@property (nonatomic) NSMutableArray *appOptions;

- (id)init:(RimeConfigError **)error;

// Override property setters to do patching
- (void)setUseUSKeyboardLayout:(BOOL)value;
- (void)setShowNotificationWhen:(NSUInteger)value;
- (void)setShowNotificationViaNotificationCenter:(BOOL)value;

- (void)setIsHorizontal:(BOOL)value;
- (void)setLineSpacing:(NSInteger)value;
- (void)setNumberOfCandidates:(NSInteger)value;
- (void)setFontFace:(NSString *)value;
- (void)setFontPoint:(NSInteger)value;
- (void)setCornerRadius:(NSInteger)value;
- (void)setBorderHeight:(NSInteger)value;
- (void)setBorderWidth:(NSInteger)value;
- (void)setAlpha:(float)value;
- (void)setColorTheme:(NSString *)value;

- (void)setAppOptionFor:(NSString *)appId asciiMode:(BOOL)ascii;
- (void)setAppOptionFor:(NSString *)appId softCursor:(BOOL)cursor;

// Class helpers
+ (NSString *)rimeFolder;
+ (BOOL)checkRimeFolder;
@end
