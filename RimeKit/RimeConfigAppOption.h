//
//  RimeConfigAppOption.h
//  SCU
//
//  Created by Neo on 2/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeConfigAppOption : NSObject

@property(strong) NSString *appId;
@property BOOL asciiMode;   // Force ASCII mode
@property BOOL softCursor;  // Force soft cursor

// Properties for Cocoa app using, not initiated in RimeConfigController
@property(strong) NSString *appName;   // Application display name
@end
