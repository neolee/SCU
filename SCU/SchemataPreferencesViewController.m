//
//  SchemataPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/31/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "SchemataPreferencesViewController.h"

@interface SchemataPreferencesViewController ()

@end

@implementation SchemataPreferencesViewController

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
    _schemata = [[_delegate configController] schemata];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_schemataTableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

#pragma mark - NSTableViewDelegate protocol

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    NSInteger index = [_schemataTableView selectedRow];
    if (index < 0) return;

    [self setCurrentSchema:[_schemata objectAtIndex:index]];
}

#pragma mark - NSTableViewDataSource protocol

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_schemata count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *columnIdentifer = [tableColumn identifier];
    RimeConfigSchema *schema = [_schemata objectAtIndex:row];
    
    if ([columnIdentifer isEqualToString:@"enabled"]) {
        return [NSNumber numberWithInteger:([schema enabled] ? NSOnState : NSOffState)];
    }
    else if ([columnIdentifer isEqualToString:@"name"]) {
        return [schema name];
    }
    else if ([columnIdentifer isEqualToString:@"id"]) {
        return [schema schemaId];
    }
    
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *columnIdentifer = [tableColumn identifier];
    RimeConfigSchema *schema = [_schemata objectAtIndex:row];
    
    if ([columnIdentifer isEqualToString:@"enabled"]) {
        [schema setEnabled:object];
        [[_delegate configController] setEnabled:[schema enabled] forSchema:[schema schemaId]];
    }
    else if ([columnIdentifer isEqualToString:@"name"]) {
        // Not editable
    }
    else if ([columnIdentifer isEqualToString:@"id"]) {
        // Not editable
    }
}

#pragma mark - MASPreferencesViewController protocol

-(NSString *)identifier {
    return @"Schemata";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNameAdvanced];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"Schemata tab label", nil);
}

#pragma mark - Configuration changing actions

@end
