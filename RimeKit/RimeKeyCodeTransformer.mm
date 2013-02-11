//
//  RimeKeyCodeTransformer.m
//  SCU
//
//  Created by Neo on 2/11/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "RimeKeyCodeTransformer.h"
#import "key_table.h"

@implementation RimeKeyCodeTransformer

+ (NSDictionary *)keyMapping {
    static dispatch_once_t onceToken;
    static NSDictionary *mapping = nil;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @(XK_Alt_L): @(OSX_VK_Option),
                    @(XK_BackSpace): @(OSX_VK_Delete),
                    @(XK_Control_L): @(OSX_VK_Control),
                    @(XK_Control_R): @(OSX_VK_RightControl),
                    @(XK_Delete): @(OSX_VK_ForwardDelete),
                    @(XK_Down): @(OSX_VK_DownArrow),
                    @(XK_End): @(OSX_VK_End),
                    @(XK_Escape): @(OSX_VK_Escape),
                    @(XK_Home): @(OSX_VK_Home),
                    @(XK_Left): @(OSX_VK_LeftArrow),
                    @(XK_Next): @(OSX_VK_PageDown),
                    @(XK_Prior): @(OSX_VK_PageUp),
                    @(XK_Return): @(OSX_VK_Return),
                    @(XK_Right): @(OSX_VK_RightArrow),
                    @(XK_Shift_L): @(OSX_VK_Shift),
                    @(XK_Shift_R): @(OSX_VK_RightShift),
                    @(XK_space): @(OSX_VK_Space),
                    @(XK_Tab): @(OSX_VK_Tab),
                    @(XK_Up): @(OSX_VK_UpArrow),
                    @(XK_F1): @(OSX_VK_F1),
                    @(XK_F2): @(OSX_VK_F2),
                    @(XK_F3): @(OSX_VK_F3),
                    @(XK_F4): @(OSX_VK_F4),
                    @(XK_F5): @(OSX_VK_F5),
                    @(XK_F6): @(OSX_VK_F6),
                    @(XK_F7): @(OSX_VK_F7),
                    @(XK_F8): @(OSX_VK_F8),
                    @(XK_F9): @(OSX_VK_F9),
                    @(XK_F10): @(OSX_VK_F10),
                    @(XK_F11): @(OSX_VK_F11),
                    @(XK_F12): @(OSX_VK_F12)
                    };
    });
    
    return mapping;
}

+ (NSDictionary *)reverseKeyMapping {
    NSMutableDictionary __block *mapping = [[NSMutableDictionary alloc] init];

    [[RimeKeyCodeTransformer keyMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mapping setObject:key forKey:obj];
    }];
    
    return mapping;
}

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSNumber class];
}

// Transform a Rime key code to Mac OS X key code
- (int)characterToKeyCode:(unichar)character {
    switch (character) {
        case 'a': return 0;
        case 's': return 1;
        case 'd': return 2;
        case 'f': return 3;
        case 'h': return 4;
        case 'g': return 5;
        case 'z': return 6;
        case 'x': return 7;
        case 'c': return 8;
        case 'v': return 9;
        // What is 10?
        case 'b': return 11;
        case 'q': return 12;
        case 'w': return 13;
        case 'e': return 14;
        case 'r': return 15;
        case 'y': return 16;
        case 't': return 17;
        case '1': return 18;
        case '2': return 19;
        case '3': return 20;
        case '4': return 21;
        case '6': return 22;
        case '5': return 23;
        case '=': return 24;
        case '9': return 25;
        case '7': return 26;
        case '-': return 27;
        case '8': return 28;
        case '0': return 29;
        case ']': return 30;
        case 'o': return 31;
        case 'u': return 32;
        case '[': return 33;
        case 'i': return 34;
        case 'p': return 35;
        case 'l': return 37;
        case 'j': return 38;
        case '\'': return 39;
        case 'k': return 40;
        case ';': return 41;
        case '\\': return 42;
        case ',': return 43;
        case '/': return 44;
        case 'n': return 45;
        case 'm': return 46;
        case '.': return 47;
        case '`': return 50;
        default: return 0;
    }
}

- (NSNumber *)transformedValue:(NSNumber *)value {
    NSNumber *output;
    
    output = [[RimeKeyCodeTransformer keyMapping] objectForKey:value];
    if (!output) {
        // Not in the special key code mapping, and Rime key code is the ASCII char when between 0x20-0x7e
        // Sorry but this is completely different story and we have to use hard-coded characterToKeyCode
        unichar character = [value charValue];
        if (character >= 0x20 && character <= 0x7e) {
            output = @([self characterToKeyCode:character]);
        }
    }
    
    return output;
}

// Transform a Mac OS X key code to Rime key code
- (NSNumber *)reverseTransformedValue:(NSNumber *)value character:(unichar)keyChar {
    NSNumber *output;
    
    output = [[RimeKeyCodeTransformer reverseKeyMapping] objectForKey:value];
    if (!output) {
        // Not in the special key code mapping
        output = [NSNumber numberWithInt:((keyChar >= 0x20 && keyChar <= 0x7e) ? keyChar : 0)];
    }
    
    return output;
}

#pragma mark - Custom converters

// Convert a Rime key code to human readable string (can be used in config files), and vice versa
- (NSString *)keyCodeToName:(int)keyCode {
    const char* keyNameChars = RimeGetKeyName(keyCode);
    
    if (keyNameChars)
        return [NSString stringWithCString:keyNameChars encoding:NSASCIIStringEncoding];

    return nil;
}

- (int)keyNameToCode:(NSString *)keyName {
    int keyCode = RimeGetKeycodeByName([keyName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (keyCode == XK_VoidSymbol) keyCode = 0;
    
    return keyCode;
}

#pragma mark - Init and shared instance

+ (instancetype)sharedTransformer {
    static dispatch_once_t onceToken;
    static RimeKeyCodeTransformer *transformer = nil;
    dispatch_once(&onceToken, ^{
        transformer = [[self alloc] init];
    });
    return transformer;
}

@end
