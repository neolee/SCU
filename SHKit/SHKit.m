//
//  SHKit.m
//  SCU
//
//  Created by Neo on 12/30/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "SHKit.h"

@implementation SHKit

+ (NSInteger)alertWithMessage:(NSString *)messageText info:(NSString *)infoText cancelButton:(NSString *)buttonTitle {
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert setMessageText:messageText];
    [alert setInformativeText:infoText];
    [alert addButtonWithTitle:buttonTitle];
    
    return [alert runModal];
}

@end
