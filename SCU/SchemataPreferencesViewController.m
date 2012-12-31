//
//  SchemataPreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/31/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import "SchemataPreferencesViewController.h"

#import <YACYAML/YACYAML.h>

#import "NSString+SHFoundation.h"
#import "SHKit.h"

#import "RimeConfigController.h"

@interface SchemataPreferencesViewController ()

@end

@implementation SchemataPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSString *)identifier{
    return @"Schemata";
}

-(NSImage *)toolbarItemImage{
    return [NSImage imageNamed:NSImageNameAdvanced];
}

-(NSString *)toolbarItemLabel{
    return NSLocalizedString(@"Schemata tab label", nil);
}

- (IBAction)testYACYAML:(id)sender {
    NSString *s1 = @"some string";
    NSNumber *n1 = [NSNumber numberWithInt:69];
    BOOL b1 = YES;
    BOOL b2 = NO;
    
    NSArray *a1 = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];
    NSDictionary *d1 = [NSDictionary dictionaryWithObjectsAndKeys:s1, @"stringKey",
                        n1, @"numberKey",
                        a1, @"arrayKey",
                        nil];
    NSDictionary *d2 = [NSDictionary dictionaryWithObjectsAndKeys:@"test test", @"stringKey",
                        [NSString stringWithBool:b1], @"boolKey1",
                        [NSString stringWithBool:b2], @"boolKey2",
                        d1, @"dictKey",
                        nil];
    
    NSString *y1 = [a1 YACYAMLEncodedString];
    NSString *y2 = [d1 YACYAMLEncodedString];
    NSString *y3 = [d2 YACYAMLEncodedString];
    
    NSLog(@"Encoding test 1\n%@", y1);
    NSLog(@"Encoding test 2\n%@", y2);
    NSLog(@"Encoding test 3\n%@", y3);
    
    NSDictionary *d4 = [y3 YACYAMLDecode];
    NSLog(@"Decoding test 1\n%@", [d4 description]);
    NSArray *a2 = [d4 valueForKeyPath:@"dictKey.arrayKey"];
    NSLog(@"Decoding test 2\n%@\na2[1]=%@", [a2 description], a2[1]);
}

- (IBAction)testRimeKit:(id)sender {
    RimeConfigError *error;
    
    RimeConfigController *controller = [[RimeConfigController alloc] init:&error];
    
    if (!controller) {
        NSString *message;
        NSString *info;
        
        switch ([error errorType]) {
            case RimeConfigFolderNotExistsError:
                message = @"Rime configuration folder does not exist";
                info = [NSString stringWithFormat:@"Path: %@\n\nYou should run the Deploy command from Squirrel IME menu before any customization.", [RimeConfigController rimeFolder]];
                break;
            case RimeConfigFileNotExistsError:
                message = @"Rime configuration file does not exist";
                info = [NSString stringWithFormat:@"Path: %@\n\nYou should run the Deploy command from Squirrel IME menu before any customization.", [error configFile]];
                break;
            default:
                message = @"Rime configuration loading failed";
                info = @"You should run the Deploy command from Squirrel IME menu before any customization. If this error persists please report to me.";
                break;
        }
        [SHKit alertWithMessage:message info:info cancelButton:@"OK"];
        
        return;
    }
    
    
}

@end
