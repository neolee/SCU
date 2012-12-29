//
//  AppDelegate.h
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RimeConfigController.h"
#import "MASPreferencesWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    RimeConfigController *_configController;
    
    MASPreferencesWindowController *_prefWindowController;
}

- (RimeConfigController *)configController;

- (IBAction)showPreferencesWindow:(id)sender;
- (IBAction)reloadFromDisk:(id)sender;
@end
