//
//  SHFoundation.m
//  SH Foundation
//
//  Created by Neo Lee on 9/13/11.
//  Copyright (c) 2011 Ragnarok Studio. All rights reserved.
//

#import "SHFoundation.h"
#import <objc/runtime.h>

@implementation SHFoundation

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)alt {    
    Method origMethod = class_getInstanceMethod(c, orig);
    Method altMethod = class_getInstanceMethod(c, alt);
    
    if (class_addMethod(c, orig, method_getImplementation(altMethod), method_getTypeEncoding(altMethod))) {
        class_replaceMethod(c, alt, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod, altMethod);
    }
}

@end
