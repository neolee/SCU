//
//  RimeKey.h
//  SCU
//
//  Created by Neo on 2/10/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeKey : NSObject

@property (readonly) unichar character;
@property (readonly) int keyCode;
@property (readonly) int modifiersFlag;

@property (readonly) int rimeKeyCode;
@property (readonly) int rimeModifiersFlag;
@property (readonly) NSString *rimeKeyName;
@property (readonly) NSString *rimeModifiersString;

@property (readonly) NSString *rimeKeyString;

// Init with Mac OS X (ShortRecorder) char, key code and modifiers flag
- (RimeKey *)initWithCharacter:(unichar)character key:(int)keyCode modifiers:(int)modifiersFlag;

// Init with a ditionary returned from SRShortcutRecorder control
- (RimeKey *)initWithSRDictionary:(NSDictionary *)dict;
+ (RimeKey *)keyWithSRDictionary:(NSDictionary *)dict;

// Init with a string loaded from Rime config
- (RimeKey *)initWithRimeConfig:(NSString *)keyString;
+ (RimeKey *)keyWithRimeConfig:(NSString *)keyString;
@end
