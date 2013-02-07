//
//  GeneralPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "GeneralPreferencesViewController.h"

#import "NSString+SHExtensions.h"

@interface GeneralPreferencesViewController ()

@end

@implementation GeneralPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = [NSApp delegate];
        
        [self addObserver:self forKeyPath:@"useUSKeyboardLayout" options:0 context:nil];
        [self addObserver:self forKeyPath:@"showNotificationWhen" options:0 context:nil];
        [self addObserver:self forKeyPath:@"showNotificationViaNotificationCenter" options:0 context:nil];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self reload];
}

- (void)reload {
    [self setUseUSKeyboardLayout:_delegate.configController.useUSKeyboardLayout];
    [self setShowNotificationWhen:_delegate.configController.showNotificationWhen];
    [self setShowNotificationViaNotificationCenter:_delegate.configController.showNotificationViaNotificationCenter];
}

#pragma mark - Helper property overrides

- (BOOL)isNotificationCenterNotAvailable {
    return ![NSUserNotificationCenter class];
}

#pragma mark - MASPreferencesViewController protocol

-(NSString *)identifier {
    return @"General";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"General tab label", nil);
}

#pragma mark - Configuration changing actions

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"useUSKeyboardLayout"]) {
        [[_delegate configController] setUseUSKeyboardLayout:_useUSKeyboardLayout];
        return;
    }
    if ([keyPath isEqualToString:@"showNotificationWhen"]) {
        [[_delegate configController] setShowNotificationWhen:_showNotificationWhen];
        if (_showNotificationWhen == 2) {
            [self setIsNotificationEnabled:NO];
            [self setShowNotificationViaNotificationCenter:NO];
        }
        else {
            [self setIsNotificationEnabled:YES];
        }
        return;
    }
    if ([keyPath isEqualToString:@"showNotificationViaNotificationCenter"]) {
        [[_delegate configController] setShowNotificationViaNotificationCenter:_showNotificationViaNotificationCenter];
        return;
    }
}

@end
