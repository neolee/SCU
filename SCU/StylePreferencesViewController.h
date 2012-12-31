//
//  StylePreferencesViewController.h
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"

@interface StylePreferencesViewController : NSViewController <MASPreferencesViewController> {
    AppDelegate *_delegate;    
}

@property NSArray *numbersOfCandidates;
@property NSString *numberOfCandidates;
@property NSInteger fontSize;
@end
