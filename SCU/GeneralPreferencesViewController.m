//
//  GeneralPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "GeneralPreferencesViewController.h"
#import "RimeConfigController.h"
#import "RimeKey.h"

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
        [self addObserver:self forKeyPath:@"switcherCaption" options:0 context:nil];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Set default modifier flag options of all shortcut recorders
    NSUInteger allowedModifierFlags = NSCommandKeyMask | NSAlternateKeyMask | NSShiftKeyMask | NSControlKeyMask;
    NSUInteger requiredModifierFlags = 0;
    for (int n = 1; n <= SWITCHER_HOTKEY_COUNT; n++) {
        SRRecorderControl *shortcutRecorder = [self valueForKey:[@"shortcutRecorder" stringByAppendingFormat:@"%d", n]];
        [shortcutRecorder setAllowedModifierFlags:allowedModifierFlags
                            requiredModifierFlags:requiredModifierFlags
                         allowsEmptyModifierFlags:YES];
    }
    
    [self reload];
}

- (void)reload {
    [self setUseUSKeyboardLayout:_delegate.configController.useUSKeyboardLayout];
    [self setShowNotificationWhen:_delegate.configController.showNotificationWhen];
    [self setShowNotificationViaNotificationCenter:_delegate.configController.showNotificationViaNotificationCenter];
    [self setSwitcherCaption:_delegate.configController.switcherCaption];
    
    [self loadSwitcherHotkeys];
}

- (void)loadSwitcherHotkeys {
    // We ONLY handle the first SHORTCUT_RECORDER_COUNT hotkey config
    int n = 1;
    for (NSString *keyString in _delegate.configController.switcherHotkeys) {
        RimeKey *key = [RimeKey keyWithRimeConfig:keyString];
        NSDictionary *value = @{
                                @"keyCode": @([key keyCode]),
                                @"modifierFlags": @([key modifiersFlag])
                                };
        SRRecorderControl *shortcutRecorder = [self valueForKey:[@"shortcutRecorder" stringByAppendingFormat:@"%d", n]];
        [shortcutRecorder setObjectValue:value];        
        
        if (++n > SWITCHER_HOTKEY_COUNT) break;
    }
}

#pragma mark - Helper property overrides

- (BOOL)isNotificationCenterNotAvailable {
    return ![NSUserNotificationCenter class];
}

#pragma mark - SRRecorderControlDelegate protocol

- (void)shortcutRecorderDidEndRecording:(SRRecorderControl *)shortcutRecorder {
    NSMutableArray *hotkeys = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int n = 1; n <= SWITCHER_HOTKEY_COUNT; n++) {
        SRRecorderControl *shortcutRecorder = [self valueForKey:[@"shortcutRecorder" stringByAppendingFormat:@"%d", n]];
        NSDictionary *value = [shortcutRecorder objectValue];
        RimeKey *key = [RimeKey keyWithSRDictionary:value];
        [hotkeys addObject:[key rimeKeyString]];
    }
    
    [[_delegate configController] setSwitcherHotkeys:hotkeys];
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
    if ([keyPath isEqualToString:@"switcherCaption"]) {
        [[_delegate configController] setSwitcherCaption:_switcherCaption];
        return;
    }
}

@end
