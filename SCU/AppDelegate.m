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
#import "AppsPreferencesViewController.h"
#import "SchemataPreferencesViewController.h"
#import "HelpPreferencesViewController.h"

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
                    message = NSLocalizedString(@"Rime configuration folder does not exist", nil);
                    info = [NSString stringWithFormat:NSLocalizedString(@"Should run the Deploy command with file path", nil), [RimeConfigController rimeFolder]];
                    break;
                case RimeConfigFileNotExistsError:
                    message = NSLocalizedString(@"Rime configuration file does not exist", nil);
                    info = [NSString stringWithFormat:NSLocalizedString(@"Should run the Deploy command with file path", nil), [error configFile]];
                    break;
                default:
                    message = NSLocalizedString(@"Rime configuration loading failed", nil);
                    info = NSLocalizedString(@"Should run the Deploy command with further info", nil);
                    break;
            }
            NSString *buttonLabel = NSLocalizedString(@"OK", nil);
            [SHKit alertWithMessage:message info:info cancelButton:buttonLabel];
            
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

        [NSApp terminate:nil];
    }
    else {
        NSLog(@"Loaded Rime configuration.");
    }
    
    // Display the prefenrences window as main UI
    NSViewController *generalViewController = [[GeneralPreferencesViewController alloc] initWithNibName:@"GeneralPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *styleViewController = [[StylePreferencesViewController alloc] initWithNibName:@"StylePreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *appsViewController = [[AppsPreferencesViewController alloc] initWithNibName:@"AppsPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *schemataViewController = [[SchemataPreferencesViewController alloc] initWithNibName:@"SchemataPreferencesViewController" bundle:[NSBundle mainBundle]];
    NSViewController *helpViewController = [[HelpPreferencesViewController alloc] initWithNibName:@"HelpPreferencesViewController" bundle:[NSBundle mainBundle]];

    NSArray *views = [NSArray arrayWithObjects:
                      generalViewController,
                      styleViewController,
                      appsViewController,
                      schemataViewController,
                      helpViewController,
                      nil];
    NSString *title = NSLocalizedString(@"Preference window title", nil);

    _prefWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:views title:title];
    [_prefWindowController showWindow:self];
}

- (IBAction)showPreferencesWindow:(id)sender {
    [_prefWindowController showWindow:self];
}

- (IBAction)askSquirrelToDeploy:(id)sender {
    // Squirrel will soon add this support. See the link below for details:
    // https://github.com/lotem/squirrel/commit/62848ce6f2da56d6f5e48413b369d9a52e42ed91
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"SquirrelReloadNotification"
                                                                   object:nil];
    
    NSLog(@"Asked for Deploy...");
}

- (IBAction)reloadFromDisk:(id)sender {
    // TODO: Reload all preferences from disk: ~/Library/Rime/*
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
