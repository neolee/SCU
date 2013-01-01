//
//  GeneralPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "GeneralPreferencesViewController.h"
#import "NSString+SHFoundation.h"


@interface GeneralPreferencesViewController ()

@end

@implementation GeneralPreferencesViewController

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
    [self setUseUSKeyboardLayout:_delegate.configController.useUSKeyboardLayout];
    
    NSInteger flag = 1;
    BOOL enableNotifications = _delegate.configController.enableNotifications;
    BOOL enableBuiltinNotifications = _delegate.configController.enableBuiltinNotifications;
    if (enableNotifications && enableBuiltinNotifications) flag = 0;
    if (!enableNotifications && !enableBuiltinNotifications) flag = 2;
    [self setFlagShowNotification:flag];
}

-(NSString *)identifier {
    return @"General";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"General tab label", nil);
}

- (IBAction)alwaysUseUSKeyboardLayoutChanged:(id)sender {
    NSLog(@"useUSKeyboardLayout: %@", [NSString stringWithBool:_useUSKeyboardLayout]);
}

- (IBAction)switchNotificationChanged:(id)sender {
    NSLog(@"flagShowNotification: %ld", _flagShowNotification);
}

@end
