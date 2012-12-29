//
//  RimeConfig.h
//  SCU
//
//  Created by Neo on 12/29/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeConfig : NSObject {
    NSString *_fileName;
    NSString *_filePath;
    NSString *_customPatchName;
    NSString *_customPatchPath;
}

- (RimeConfig *)initWithConfigName:(NSString *)name;
- (RimeConfig *)initWithSchemaName:(NSString *)name;
+ (RimeConfig *)defaultConfig;
+ (RimeConfig *)squirrelConfig;
@end
