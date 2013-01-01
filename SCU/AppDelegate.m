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
#import "SHKit.h"

@implementation AppDelegate

- (RimeConfigController *)configController {
    if (!_configController) {
        RimeConfigError *error;
        
        _configController = [[RimeConfigController alloc] init:&error];
        
        if (!_configController) {
            NSString *message;
            NSString *info;
            
            switch ([error errorType]) {
                case RimeConfigFolderNotExistsError:
                    message = @"Rime configuration folder does not exist";
                    info = [NSString stringWithFormat:@"Path: %@\n\nYou should run the Deploy command from Squirrel IME menu before any customization.", [RimeConfigController rimeFolder]];
                    break;
                case RimeConfigFileNotExistsError:
                    message = @"Rime configuration file does not exist";
                    info = [NSString stringWithFormat:@"Path: %@\n\nYou should run the Deploy command from Squirrel IME menu before any customization.", [error configFile]];
                    break;
                default:
                    message = @"Rime configuration loading failed";
                    info = @"You should run the Deploy command from Squirrel IME menu before any customization. If this error persists please report to me.";
                    break;
            }
            [SHKit alertWithMessage:message info:info cancelButton:@"OK"];
            
            return nil;
        }
    }
    
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
