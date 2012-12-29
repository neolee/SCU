//
//  RimeConfigController.m
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "RimeConfigController.h"

@implementation RimeConfigController

- (id)init {
    
    _useUSKeyboardLayout = YES;

    _enableNotifications = NO;
    _enableBuiltinNotifications = NO;

    return self;
}

@end
