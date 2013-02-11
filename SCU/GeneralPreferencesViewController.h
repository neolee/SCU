//
//  GeneralPreferencesViewController.h
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"
#import "SRRecorderControl.h"

@interface GeneralPreferencesViewController : NSViewController<MASPreferencesViewController, SRRecorderControlDelegate> {
    AppDelegate *_delegate;
}

@property (weak) IBOutlet SRRecorderControl *shortcutRecorder1;
@property (weak) IBOutlet SRRecorderControl *shortcutRecorder2;
@property (weak) IBOutlet SRRecorderControl *shortcutRecorder3;

@property BOOL useUSKeyboardLayout;
@property NSUInteger showNotificationWhen;
@property BOOL showNotificationViaNotificationCenter;
@property NSString *switcherCaption;

// Helper properties
@property (nonatomic) BOOL isNotificationEnabled;
@property (nonatomic) BOOL isNotificationCenterNotAvailable;

- (void)reload;
@end
