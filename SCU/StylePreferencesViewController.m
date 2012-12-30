//
//  StylePreferencesViewController.m
//  SCU
//
//  Created by Neo on 12/27/12.
//  Copyright (c) 2012 Neo. All rights reserved.
//

#import "StylePreferencesViewController.h"
#import <YACYAML/YACYAML.h>
#import "NSString+SHFoundation.h"
#import "RimeConfig.h"
#import "RimeConstants.h"

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
    RimeConfig *defaultConfig = [[RimeConfig alloc] initWithConfigName:RIME_DEFAULT_CONFIG_NAME];
    NSLog(@"Default config loaded.\n%@", defaultConfig);
    
    RimeConfig *squirrelConfig = [[RimeConfig alloc] initWithConfigName:RIME_SQUIRREL_CONFIG_NAME];
    NSLog(@"Squirrel config loaded.\n%@", squirrelConfig);
    
    RimeConfig *lunaPinyinConfig = [[RimeConfig alloc] initWithSchemaName:RIME_SCHEMA_LUNA_PINYIN];
    NSLog(@"Luna Pinyin schema config loaded.\n%@", lunaPinyinConfig);
}

@end
