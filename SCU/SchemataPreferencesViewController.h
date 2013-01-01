//
//  SchemataPreferencesViewController.h
//  SCU
//
//  Created by Neo on 12/31/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"

@interface SchemataPreferencesViewController : NSViewController<MASPreferencesViewController> {
    AppDelegate *_delegate;
}

- (void)reload;
@end
