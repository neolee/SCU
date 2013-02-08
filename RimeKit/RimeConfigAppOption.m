//
//  RimeConfigAppOption.m
//  SCU
//
//  Created by Neo on 2/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "RimeConfigAppOption.h"
#import "NSString+SHExtensions.h"

@implementation RimeConfigAppOption

- (NSString *)description {
    return [NSString stringWithFormat:@"AppOption(appId=%@, asciiMode=%@, softCursor=%@, appName=%@)",
            _appId, [NSString stringWithBool:_asciiMode], [NSString stringWithBool:_softCursor], _appName];
}

@end
