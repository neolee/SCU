//
//  HelpPreferencesViewController.m
//  SCU
//
//  Created by Neo on 1/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "HelpPreferencesViewController.h"

@interface HelpPreferencesViewController ()

@end

@implementation HelpPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = [NSApp delegate];
    }
    
    return self;
}

- (IBAction)askSquirrelToDeploy:(id)sender {
    [_delegate askSquirrelToDeploy:sender];
}

#pragma mark - MASPreferencesViewController protocol

-(NSString *)identifier {
    return @"Help";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNameInfo];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"Help tab label", nil);
}

@end
