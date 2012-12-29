//
//  NSString+SHFoundation.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "NSString+SHFoundation.h"

@implementation NSString (SHFoundation)

+ (NSString *)stringWithBool:(BOOL)value {
    return value ? @"true" : @"false";
}

@end
