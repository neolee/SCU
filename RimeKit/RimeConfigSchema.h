//
//  RimeConfigSchema.h
//  SCU
//
//  Created by Neo on 2/8/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RimeConfigSchema : NSObject

@property(strong) NSString *schemaId;
@property(strong) NSString *name;
@property(strong) NSString *version;
@property(strong) NSArray *authors;
@property(strong) NSString *desc;
@property(strong) NSArray *dependencies;

@property(strong) NSString *authorsString;
@property(strong) NSString *dependenciesString;

@property BOOL enabled;

- (RimeConfigSchema *)initWithSchemaId:(NSString *)schemaId;
+ (RimeConfigSchema *)schemaWithSchemaId:(NSString *)schemaId;
@end
