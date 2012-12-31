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

- (void)reload {
    [[NSUserDefaults standardUserDefaults] setBool:_delegate.configController.useUSKeyboardLayout forKey:@"useUSKeyboardLayout"];
    
    NSInteger flagShowNotification = 1;
    BOOL enableNotifications = _delegate.configController.enableNotifications;
    BOOL enableBuiltinNotifications = _delegate.configController.enableBuiltinNotifications;
    if (enableNotifications && enableBuiltinNotifications) flagShowNotification = 0;
    if (!enableNotifications && !enableBuiltinNotifications) flagShowNotification = 2;
    [[NSUserDefaults standardUserDefaults] setInteger:flagShowNotification forKey:@"flagShowNotification"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = [NSApp delegate];
        
        [self reload];
    }
    
    return self;
}

-(NSString *)identifier{
    return @"General";
}

-(NSImage *)toolbarItemImage{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

-(NSString *)toolbarItemLabel{
    return NSLocalizedString(@"General tab label", nil);
}

- (IBAction)alwaysUseUSKeyboardLayoutChanged:(id)sender {
    BOOL useUSKeyboardLayout = [[NSUserDefaults standardUserDefaults] boolForKey:@"useUSKeyboardLayout"];
    NSLog(@"useUSKeyboardLayout: %@", [NSString stringWithBool:useUSKeyboardLayout]);
}

- (IBAction)switchNotificationChanged:(id)sender {
    NSInteger flagShowNotification = [[NSUserDefaults standardUserDefaults] integerForKey:@"flagShowNotification"];
    NSLog(@"flagShowNotification: %ld", flagShowNotification);
}

@end
