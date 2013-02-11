//
//  RimeModifierFlagTransformer.h
//  SCU
//
//  Created by Neo on 2/11/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RimeKeyOSXConstants.h"

@interface RimeModifierFlagTransformer : NSValueTransformer

+ (instancetype)sharedTransformer;
+ (NSDictionary *)keyMapping;

- (NSString *)modifiersFlagToString:(int)flag;
- (int)modifiersStringToFlag:(NSString *)string;
@end
