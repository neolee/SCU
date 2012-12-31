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
#import "SchemataPreferencesViewController.h"

#import "NSString+SHFoundation.h"

@implementation AppDelegate

- (RimeConfigController *)configController {
    if (!_configController) _configController = [[RimeConfigController alloc] init];
    
    return _configController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Load Rime/Squirrel configuration
    if (![self configController]) {
        NSLog(@"Loading Rime configuration failed.");
    }
    else {
        NSLog(@"Loaded Rime configuration.");
        NSLog(@"useUSKeyboardLayout: %@", [NSString stringWithBool:_configController.useUSKeyboardLayout]);
        NSLog(@"enableNotifcations: %@", [NSString stringWithBool:_configController.enableNotifications]);
        NSLog(@"enableBuiltinNotifications: %@", [NSString stringWithBool:_configController.enableBuiltinNotifications]);
    }
    
    // Display the prefenrences window as main UI
    NSViewController *generalViewController = [[GeneralPreferencesViewController alloc] initWithNibName:@"GeneralPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *styleViewController = [[StylePreferencesViewController alloc] initWithNibName:@"StylePreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *schemataViewController = [[SchemataPreferencesViewController alloc] initWithNibName:@"SchemataPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSArray *views = [NSArray arrayWithObjects:generalViewController, styleViewController, schemataViewController, nil];
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
