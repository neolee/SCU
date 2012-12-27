//
//  AppDelegate.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "AppDelegate.h"
#import "GeneralPreferencesViewController.h"
#import "StylePreferencesViewController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSViewController *generalViewController = [[GeneralPreferencesViewController alloc] initWithNibName:@"GeneralPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *styleViewController = [[StylePreferencesViewController alloc] initWithNibName:@"StylePreferencesViewController" bundle:[NSBundle mainBundle]];
    NSArray *views = [NSArray arrayWithObjects:generalViewController, styleViewController, nil];
    NSString *title = NSLocalizedString(@"Preference window title", nil);

    _prefWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:views title:title];
    [_prefWindowController showWindow:self];
}

- (IBAction)showPreferencesWindow:(id)sender {
    [_prefWindowController showWindow:self];
}

- (IBAction)reloadFromDisk:(id)sender {
    // TODO: Reload all preferences from disk: ~/Library/Rime/*
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
