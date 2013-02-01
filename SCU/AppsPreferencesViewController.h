//
//  AppsPreferencesViewController.h
//  SCU
//
//  Created by Neo on 1/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"

@interface AppsPreferencesViewController : NSViewController<MASPreferencesViewController, NSTableViewDataSource> {
    AppDelegate *_delegate;
    
    NSMutableArray *_appOptions;
    NSMutableDictionary *_appIcons;
}

- (void)reload;
@end
