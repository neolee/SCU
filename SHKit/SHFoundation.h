//
//  SHFoundation.h
//  SH Foundation
//
//  Created by Neo Lee on 9/13/11.
//  Copyright (c) 2011 Ragnarok Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFoundation : NSObject

// Objective-C utilities
+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)alt;
@end
