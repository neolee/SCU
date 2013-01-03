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
        [self addObserver:self forKeyPath:@"flagShowNotification" options:0 context:nil];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self reload];
}

- (void)reload {
    [self setUseUSKeyboardLayout:_delegate.configController.useUSKeyboardLayout];
    
    NSInteger flag = 1;
    BOOL enableNotifications = _delegate.configController.enableNotifications;
    BOOL enableBuiltinNotifications = _delegate.configController.enableBuiltinNotifications;
    if (enableNotifications && enableBuiltinNotifications) flag = 0;
    if (!enableNotifications && !enableBuiltinNotifications) flag = 2;
    [self setFlagShowNotification:flag];
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
    if ([keyPath isEqualToString:@"flagShowNotification"]) {
        [[_delegate configController] setShowNotificationWhen:_flagShowNotification];
        return;
    }
}

@end
