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
#import "RimeConfigSchema.h"

@interface SchemataPreferencesViewController : NSViewController<MASPreferencesViewController, NSTableViewDelegate, NSTableViewDataSource> {
    AppDelegate *_delegate;
    
    NSMutableArray *_schemata;
}

@property (strong) RimeConfigSchema *currentSchema;
@property (weak) IBOutlet NSTableView *schemataTableView;

- (void)reload;
@end
