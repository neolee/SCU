//
//  GeneralPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "GeneralPreferencesViewController.h"

@interface GeneralPreferencesViewController ()

@end

@implementation GeneralPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
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

@end
