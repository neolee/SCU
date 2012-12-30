//
//  SHKit.h
//  SCU
//
//  Created by Neo on 12/30/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SHKit : NSObject

+ (NSInteger)alertWithMessage:(NSString *)messageText info:(NSString *)infoText cancelButton:(NSString *)buttonTitle;
@end
