//
//  RimeKey.m
//  SCU
//
//  Created by Neo on 2/10/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "RimeKey.h"
#import "RimeKeyCodeTransformer.h"
#import "RimeModifierFlagTransformer.h"

@implementation RimeKey

// Init with Mac OS X (ShortRecorder) char, key code and modifiers flag
- (RimeKey *)initWithCharacter:(unichar)character key:(int)keyCode modifiers:(int)modifiersFlag {
    _character = character;
    _keyCode = keyCode;
    _modifiersFlag = modifiersFlag;
    
    // Rime key code and name
    RimeKeyCodeTransformer *kcTransformer = [RimeKeyCodeTransformer sharedTransformer];
    _rimeKeyCode = [[kcTransformer reverseTransformedValue:@(_keyCode)] intValue];
    _rimeKeyName = [kcTransformer keyCodeToName:_rimeKeyCode];
    if (!_rimeKeyName) {
        _rimeKeyName = [NSString stringWithFormat:@"%c", _character];
    }
    
    RimeModifierFlagTransformer *mfTransformer = [RimeModifierFlagTransformer sharedTransformer];
    _rimeModifiersFlag = [[mfTransformer reverseTransformedValue:@(_modifiersFlag)] intValue];
    _rimeModifiersString = [mfTransformer modifiersFlagToString:_rimeModifiersFlag];
    _rimeKeyString = _rimeKeyName;
    if (![_rimeModifiersString isEqualToString:@""]) {
        _rimeKeyString = [_rimeModifiersString stringByAppendingFormat:@"+%@", _rimeKeyName];
    }
    
    return self;
}

// Init with a ditionary returned from SRShortcutRecorder control
- (RimeKey *)initWithSRDictionary:(NSDictionary *)dict {
    unichar character = [[dict objectForKey:@"characters"] characterAtIndex:0];
    int keyCode = [[dict objectForKey:@"keyCode"] intValue];
    int modifiersFlag = [[dict objectForKey:@"modifierFlags"] intValue];
    
    return [self initWithCharacter:character key:keyCode modifiers:modifiersFlag];
}

+ (RimeKey *)keyWithSRDictionary:(NSDictionary *)dict {
    return [[RimeKey alloc] initWithSRDictionary:dict];
}

// Init with a string loaded from Rime config
- (RimeKey *)initWithRimeConfig:(NSString *)keyString {
    _rimeKeyString = keyString;
    _rimeModifiersString = @"";
    
    NSArray *components = [_rimeKeyString componentsSeparatedByString:@"+"];
    
    if ([components count] > 1) {
        // We have modifier(s) here
        _rimeModifiersString = [[components subarrayWithRange:NSMakeRange(0, [components count]-1)]
                                componentsJoinedByString:@"+"];
        RimeModifierFlagTransformer *rmTransformer = [RimeModifierFlagTransformer sharedTransformer];
        _rimeModifiersFlag = [rmTransformer modifiersStringToFlag:_rimeModifiersString];
        _modifiersFlag = [[rmTransformer transformedValue:@(_rimeModifiersFlag)] intValue];
    }
    
    RimeKeyCodeTransformer *kcTransformer = [RimeKeyCodeTransformer sharedTransformer];
    _rimeKeyName = [components lastObject];
    _rimeKeyCode = [kcTransformer keyNameToCode:_rimeKeyName];
    _keyCode = [[kcTransformer transformedValue:@(_rimeKeyCode)] intValue];
    
    return self;
}

+ (RimeKey *)keyWithRimeConfig:(NSString *)keyString {
    return [[RimeKey alloc] initWithRimeConfig:keyString];
}


@end
