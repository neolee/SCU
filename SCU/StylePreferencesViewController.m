//
//  StylePreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "StylePreferencesViewController.h"
#import "RimeConfigController.h"

#import "NSString+SHExtensions.h"

@interface StylePreferencesViewController ()

@end

@implementation StylePreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _delegate = [NSApp delegate];
        
        // UI inialization and properties default value
        _numbersOfCandidates = @[
        @{@"name" : @"3", @"value" : @"3"},
        @{@"name" : @"4", @"value" : @"4"},
        @{@"name" : @"5", @"value" : @"5"},
        @{@"name" : @"6", @"value" : @"6"},
        @{@"name" : @"7", @"value" : @"7"},
        @{@"name" : @"8", @"value" : @"8"},
        @{@"name" : @"9", @"value" : @"9"}
        ];
        
        _colorThemes = @[
        @{@"name" : @"系统／Native", @"value" : @"native"},
        @{@"name" : @"碧水／Aqua", @"value" : @"aqua"},
        @{@"name" : @"青天／Azure", @"value" : @"azure"},
        @{@"name" : @"暗堂／Dark Temple", @"value" : @"dark_temple"},
        @{@"name" : @"谷歌／Google", @"value" : @"google"},
        @{@"name" : @"墨池／Ink", @"value" : @"ink"},
        @{@"name" : @"孤寺／Lost Temple", @"value" : @"lost_temple"},
        @{@"name" : @"明月／Luna", @"value" : @"luna"},
        @{@"name" : @"星際我爭霸／StarCraft", @"value" : @"starcraft"}
        ];

        _orientation = 0;
        _numberOfCandidates = 5;
        _fontPoint = [NSFont systemFontSize];
        _currentFont = [NSFont systemFontOfSize:_fontPoint];
        _fontFace = [_currentFont fontName];
        _cornerRadius = 5;
        _borderHeight = 0;
        _borderWidth = 0;
        _alpha = 1.0;
        _colorTheme = @"native";
        
        [self addObserver:self forKeyPath:@"orientation" options:0 context:nil];
        [self addObserver:self forKeyPath:@"numberOfCandidates" options:0 context:nil];
        [self addObserver:self forKeyPath:@"fontFace" options:0 context:nil];
        [self addObserver:self forKeyPath:@"fontPoint" options:0 context:nil];
        [self addObserver:self forKeyPath:@"cornerRadius" options:0 context:nil];
        [self addObserver:self forKeyPath:@"borderHeight" options:0 context:nil];
        [self addObserver:self forKeyPath:@"borderWidth" options:0 context:nil];
        [self addObserver:self forKeyPath:@"alpha" options:0 context:nil];
        [self addObserver:self forKeyPath:@"colorTheme" options:0 context:nil];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self reload];
}

- (void)reload {
    BOOL isHorizontal = [[_delegate configController] isHorizontal];
    [self setOrientation:(isHorizontal ? 1 : 0)];
    [self setNumberOfCandidates:[[_delegate configController] numberOfCandidates]];
    [self setFontFace:[[_delegate configController] fontFace]];
    [self setFontPoint:[[_delegate configController] fontPoint]];
    [self setCornerRadius:[[_delegate configController] cornerRadius]];
    [self setBorderHeight:[[_delegate configController] borderHeight]];
    [self setBorderWidth:[[_delegate configController] borderWidth]];
    [self setAlpha:[[_delegate configController] alpha]];
    [self setColorTheme:[[_delegate configController] colorTheme]];
    
    // Update local helper object and UI
    if (_fontFace && ![_fontFace isEqualToString:@""] && _fontPoint > 0) {
        _currentFont = [NSFont fontWithName:_fontFace size:_fontPoint];
    }
    
    [self updateFontField];
}

- (void)updateFontField {
    [_fontField setStringValue:[NSString stringWithFormat:@"%@", [_currentFont fontName]]];
    NSFont *font = [NSFont fontWithName:_fontFace size:[NSFont systemFontSize]];
    [_fontField setFont:font];
}

- (IBAction)chooseFont:(id)sender {
    NSFontManager *fontManager = [NSFontManager sharedFontManager];
    [fontManager setSelectedFont:_currentFont isMultiple:NO];
    [fontManager orderFrontFontPanel:nil];
}

// Callback called by the shared NSFontManager when user chooses a new font or size in the Font Panel
- (void)changeFont:(id)sender {
    NSFontManager *fontManager = [NSFontManager sharedFontManager];
    [self setCurrentFont:[fontManager convertFont:[fontManager selectedFont]]];
    [self setFontFace:[_currentFont fontName]];
    [self setFontPoint:[_currentFont pointSize]];
    [self updateFontField];
}

#pragma mark - MASPreferencesViewController protocol

-(NSString *)identifier {
    return @"Style";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNameColorPanel];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"Style tab label", nil);
}

#pragma mark - Configuration changing actions

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"orientation"]) {
        [[_delegate configController] setIsHorizontal:(_orientation==1)];
        return;
    }
    if ([keyPath isEqualToString:@"numberOfCandidates"]) {
        [[_delegate configController] setNumberOfCandidates:_numberOfCandidates];
        return;
    }
    if ([keyPath isEqualToString:@"fontFace"]) {
        [[_delegate configController] setFontFace:_fontFace];
        return;
    }
    if ([keyPath isEqualToString:@"fontPoint"]) {
        [[_delegate configController] setFontPoint:_fontPoint];
        return;
    }
    if ([keyPath isEqualToString:@"cornerRadius"]) {
        [[_delegate configController] setCornerRadius:_cornerRadius];
        return;
    }
    if ([keyPath isEqualToString:@"borderHeight"]) {
        [[_delegate configController] setBorderHeight:_borderHeight];
        return;
    }
    if ([keyPath isEqualToString:@"borderWidth"]) {
        [[_delegate configController] setBorderWidth:_borderWidth];
        return;
    }
    if ([keyPath isEqualToString:@"alpha"]) {
        [[_delegate configController] setAlpha:_alpha];
        return;
    }
    if ([keyPath isEqualToString:@"colorTheme"]) {
        [[_delegate configController] setColorTheme:_colorTheme];
        return;
    }
}

@end
