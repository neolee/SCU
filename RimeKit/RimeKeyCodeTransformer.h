//
//  RimeKeyCodeTransformer.h
//  SCU
//
//  Created by Neo on 2/11/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RimeKeyOSXConstants.h"

@interface RimeKeyCodeTransformer : NSValueTransformer

+ (instancetype)sharedTransformer;

+ (NSDictionary *)keyMapping;
+ (NSDictionary *)reverseKeyMapping;

- (NSNumber *)reverseTransformedValue:(NSNumber *)value character:(unichar)keyChar;

- (NSString *)keyCodeToName:(int)keyCode;
- (int)keyNameToCode:(NSString *)keyName;
@end
