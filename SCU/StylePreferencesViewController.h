//
//  StylePreferencesViewController.h
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "AppDelegate.h"

@interface StylePreferencesViewController : NSViewController<MASPreferencesViewController> {
    AppDelegate *_delegate;
    
    __unsafe_unretained IBOutlet NSTextField *_fontField;
}

@property NSInteger orientation;
@property NSArray *numbersOfCandidates;
@property NSInteger numberOfCandidates;
@property NSFont *currentFont;
@property NSString *fontFace;
@property NSInteger fontPoint;
@property NSInteger cornerRadius;
@property NSInteger borderHeight;
@property NSInteger borderWidth;
@property float alpha;
@property NSArray *colorThemes;
@property NSString *colorTheme;

- (void)reload;
- (IBAction)chooseFont:(id)sender;
- (void)updateFontField;
@end
