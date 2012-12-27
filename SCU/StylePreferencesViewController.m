//
//  StylePreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "StylePreferencesViewController.h"

@interface StylePreferencesViewController ()

@end

@implementation StylePreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
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
