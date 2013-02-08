//
//  RimeConfigSchema.m
//  SCU
//
//  Created by Neo on 2/8/13.
//  Copyright (c) 2013 Paradigm X. All rights reserved.
//

#import "RimeConfigSchema.h"
#import "RimeConstants.h"
#import "RimeConfig.h"

#import "NSString+SHExtensions.h"

@implementation RimeConfigSchema

- (RimeConfigSchema *)initWithSchemaId:(NSString *)schemaId {
    _schemaId = schemaId;

    RimeConfigError *error;
    RimeConfig *schemaConfig = [[RimeConfig alloc] initWithBundledSchemaName:schemaId error:&error];
    if (!schemaConfig) return nil;
    _name = [schemaConfig stringForKeyPath:@"schema.name"];
    _version = [schemaConfig stringForKeyPath:@"schema.version"];
    _authors = [schemaConfig arrayForKeyPath:@"schema.author"];
    _desc = [schemaConfig stringForKeyPath:@"schema.description"];
    _dependencies = [schemaConfig arrayForKeyPath:@"schema.dependencies"];
    
    _authorsString = [_authors componentsJoinedByString:@", "];
    _dependenciesString = [_dependencies componentsJoinedByString:@", "];
    
    _enabled = NO;
    
    return self;
}

+ (RimeConfigSchema *)schemaWithSchemaId:(NSString *)schemaId {
    return [[RimeConfigSchema alloc] initWithSchemaId:schemaId];
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"Schema(schemaId=%@, name=%@, version=%@, author=%@, desc=%@, dependencies=%@, enabled=%@)",
            _schemaId, _name, _version, _authors, _desc, _dependencies, [NSString stringWithBool:_enabled]];
}

@end
