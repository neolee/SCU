//
//  HelpPreferencesViewController.h
//  SCU
//
//  Created by Neo on 1/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"

@interface HelpPreferencesViewController : NSViewController <MASPreferencesViewController> {
    AppDelegate *_delegate;
}

- (IBAction)askSquirrelToDeploy:(id)sender;
@end
