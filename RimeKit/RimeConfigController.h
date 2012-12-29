//
//  RimeConfigController.h
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeConfigController : NSObject {
    
}

@property BOOL useUSKeyboardLayout;
@property BOOL enableNotifications;
@property BOOL enableBuiltinNotifications;

- (id)init;
@end
