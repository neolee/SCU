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
                    // Special keys
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
                    @(XK_F12): @(OSX_VK_F12),
                    // Others
                    @('a'): @(0),
                    @('s'): @(1),
                    @('d'): @(2),
                    @('f'): @(3),
                    @('h'): @(4),
                    @('g'): @(5),
                    @('z'): @(6),
                    @('x'): @(7),
                    @('c'): @(8),
                    @('v'): @(9),
                    // What is 10?
                    @('b'): @(11),
                    @('q'): @(12),
                    @('w'): @(13),
                    @('e'): @(14),
                    @('r'): @(15),
                    @('y'): @(16),
                    @('t'): @(17),
                    @('1'): @(18),
                    @('2'): @(19),
                    @('3'): @(20),
                    @('4'): @(21),
                    @('6'): @(22),
                    @('5'): @(23),
                    @('='): @(24),
                    @('9'): @(25),
                    @('7'): @(26),
                    @('-'): @(27),
                    @('8'): @(28),
                    @('0'): @(29),
                    @(']'): @(30),
                    @('o'): @(31),
                    @('u'): @(32),
                    @('['): @(33),
                    @('i'): @(34),
                    @('p'): @(35),
                    @('l'): @(37),
                    @('j'): @(38),
                    @('\''): @(39),
                    @('k'): @(40),
                    @(';'): @(41),
                    @('\\'): @(42),
                    @(','): @(43),
                    @('/'): @(44),
                    @('n'): @(45),
                    @('m'): @(46),
                    @('.'): @(47),
                    @('`'): @(50)                    
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

- (NSNumber *)transformedValue:(NSNumber *)value {
    NSNumber *output = [[RimeKeyCodeTransformer keyMapping] objectForKey:value];
    if (!output) output = @(0);
    
    return output;
}

// Transform a Mac OS X key code to Rime key code
- (NSNumber *)reverseTransformedValue:(NSNumber *)value {
    NSNumber *output = [[RimeKeyCodeTransformer reverseKeyMapping] objectForKey:value];
    if (!output) output = @(0);
    
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
