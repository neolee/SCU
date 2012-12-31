//
//  StylePreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "StylePreferencesViewController.h"
#import "RimeConfigController.h"

@interface StylePreferencesViewController ()

@end

@implementation StylePreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _numbersOfCandidates = [[NSArray alloc] initWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"name", @"3", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"4", @"name", @"4", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"5", @"name", @"5", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"6", @"name", @"6", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"7", @"name", @"7", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"8", @"name", @"8", @"value", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"9", @"name", @"9", @"value", nil],
                   nil];

        _numberOfCandidates = @"5";
    }
    
    return self;
}

-(NSString *)identifier{
    return @"Style";
}

-(NSImage *)toolbarItemImage{
    return [NSImage imageNamed:NSImageNameColorPanel];
}

-(NSString *)toolbarItemLabel{
    return NSLocalizedString(@"Style tab label", nil);
}

@end
