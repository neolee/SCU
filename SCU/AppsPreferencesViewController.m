//
//  AppsPreferencesViewController.m
//  SCU
//
//  Created by Neo on 1/1/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "AppsPreferencesViewController.h"

@interface AppsPreferencesViewController ()

@end

@implementation AppsPreferencesViewController

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

}

-(NSString *)identifier {
    return @"Apps";
}

-(NSImage *)toolbarItemImage {
    return [NSImage imageNamed:NSImageNameAdvanced];
}

-(NSString *)toolbarItemLabel {
    return NSLocalizedString(@"Apps tab label", nil);
}

@end
