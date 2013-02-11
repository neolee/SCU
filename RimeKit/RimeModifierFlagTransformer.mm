//
//  RimeModifierFlagTransformer.m
//  SCU
//
//  Created by Neo on 2/11/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "RimeModifierFlagTransformer.h"
#include "key_table.h"

@implementation RimeModifierFlagTransformer

+ (NSDictionary *)keyMapping {
    static dispatch_once_t onceToken;
    static NSDictionary *mapping = nil;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @(kShiftMask): @(OSX_ShiftKeyMask),
                    @(kControlMask): @(OSX_ControlKeyMask),
                    @(kAltMask): @(OSX_AlternateKeyMask),
                    @(kSuperMask): @(OSX_CommandKeyMask)
                    };
    });

    return mapping;
}

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSNumber class];
}

// Transform a Rime modifier flag to Mac OS X key code
- (NSNumber *)transformedValue:(NSNumber *)value {
    int input = [value intValue];
    int __block output = 0;
    
    [[RimeModifierFlagTransformer keyMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (input & [key intValue]) {
            output |= [obj intValue];
        }
    }];
    
    return [NSNumber numberWithInt:output];
}

// Transform a Mac OS X modifier flag to Rime key code
- (NSNumber *)reverseTransformedValue:(NSNumber *)value {
    int input = [value intValue];
    int __block output = 0;
    
    [[RimeModifierFlagTransformer keyMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (input & [obj intValue]) {
            output |= [key intValue];
        }
    }];
    
    return [NSNumber numberWithInt:output];
}

#pragma mark - Custom converters

// Convert a Rime modifier flag to human readable string (can be used in config files), and vice versa
- (NSString *)modifiersFlagToString:(int)flag {
    NSMutableArray __block *output = [[NSMutableArray alloc] init];
    
    [[RimeModifierFlagTransformer keyMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (flag & [key intValue]) {
            [output addObject:[NSString stringWithCString:RimeGetModifierName([key intValue])
                                                 encoding:NSASCIIStringEncoding]];
        }
    }];
    
    return [output componentsJoinedByString:@"+"];
}

- (int)modifiersStringToFlag:(NSString *)string {
    NSArray *modifiers = [string componentsSeparatedByString:@"+"];
    
    int keyCode = 0;
    for (NSString *modifier in modifiers) {
        keyCode |= RimeGetModifierByName([modifier cStringUsingEncoding:NSASCIIStringEncoding]);
    }
    
    return keyCode;
}

#pragma mark - Shared instance initialization

+ ()sharedTransformer {
    static dispatch_once_t onceToken;
    static RimeModifierFlagTransformer *transformer = nil;
    dispatch_once(&onceToken, ^{
        transformer = [[self alloc] init];
    });
    return transformer;
}

@end
