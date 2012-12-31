//
//  RimeConfigError.h
//  SCU
//
//  Created by Neo on 12/31/12.
//  Copyright (c) 2012 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RimeConfigFolderNotExistsError,
    RimeConfigFileNotExistsError,
    RimeConfigUnknownError
} RimeConfigErrorType;

@interface RimeConfigError : NSError

@property RimeConfigErrorType errorType;

@property(strong) NSString *configFolder;
@property(strong) NSString *configFile;
@end
