//
//  AppsPreferencesViewController.m
//  SCU
//
//  Created by Neo on 1/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "AppsPreferencesViewController.h"
#import "RimeConfigAppOption.h"

@interface AppsPreferencesViewController ()

@end

@implementation AppsPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = [NSApp delegate];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self reload];
}

- (void)reload {
    _appOptions = [[_delegate configController] appOptions];
    _appIcons = [[NSMutableDictionary alloc] init];
    
    // Populate *name* and *icon* attribute in appOptions
    for (RimeConfigAppOption *option in _appOptions) {
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        NSString *path = [workspace absolutePathForAppBundleWithIdentifier:[option appId]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [option setAppName:[[NSFileManager defaultManager] displayNameAtPath:path]];
            NSImage *icon = [workspace iconForFile:path];
            [_appIcons setObject:icon forKey:[option appId]];
        }
        else {
            [option setAppName:[NSString stringWithFormat:@"*%@", [option appId]]];
        }
    }
}

#pragma mark - NSTableViewDataSource protocol

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_appOptions count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {    
    NSString *columnIdentifer = [tableColumn identifier];
    RimeConfigAppOption *option = [_appOptions objectAtIndex:row];
    
    if ([columnIdentifer isEqualToString:@"icon"]) {
        return [_appIcons valueForKey:[option appId]];
    }
    else if ([columnIdentifer isEqualToString:@"name"]) {
        return [option appName];
    }
    else if ([columnIdentifer isEqualToString:@"id"]) {
        return [option appId];
    }
    else if ([columnIdentifer isEqualToString:@"ascii"]) {
        return [NSNumber numberWithInteger:([option asciiMode] ? NSOnState : NSOffState)];
    }
    else if ([columnIdentifer isEqualToString:@"cursor"]) {
        return [NSNumber numberWithInteger:([option softCursor] ? NSOnState : NSOffState)];
    }
    
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *columnIdentifer = [tableColumn identifier];
    
    if ([columnIdentifer isEqualToString:@"icon"]) {
        // Not editable
    }
    else if ([columnIdentifer isEqualToString:@"name"]) {
        // Not editable
    }
    else if ([columnIdentifer isEqualToString:@"id"]) {
        // Not editable
    }
    else if ([columnIdentifer isEqualToString:@"ascii"]) {
        RimeConfigAppOption *option = [_appOptions objectAtIndex:row];
        [option setAsciiMode:object];
    }
    else if ([columnIdentifer isEqualToString:@"cursor"]) {
        RimeConfigAppOption *option = [_appOptions objectAtIndex:row];
        [option setSoftCursor:object];
    }
}

#pragma mark - MASPreferencesViewController protocol

-(NSString *)identifier {
    return @"Apps";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNameAdvanced];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"Apps tab label", nil);
}

#pragma mark - Configuration changing actions

@end
