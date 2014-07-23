//
//  JAHConvertJingle.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle.h"

@implementation JAHConvertJingle

+ (id)objectForElement:(NSXMLNode*)parentElement {
    for (NSXMLNode* node in [parentElement children]) {
        if ([node kind] == NSXMLElementKind) {
            NSXMLElement* element = (NSXMLElement*)node;
            NSLog(@"Name: %@", [element name]);

            id (*function)(NSXMLElement*) = [[[self class] sharedFunctionMapper] functionToConvertElement:element];
            if (function != NULL) {
                return function(element);
            }
        }
    }

    return nil;
}

+ (JAHFunctionMapper*)sharedFunctionMapper {
    static JAHFunctionMapper* functionMapper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        functionMapper = [[JAHFunctionMapper alloc] init];
    });
    return functionMapper;
}

@end


@implementation JAHFunctionMapping
@end


@interface JAHFunctionMapper ()
@property (nonatomic, strong) NSMutableDictionary* elementToFunction;
@end

@implementation JAHFunctionMapper

- (void)registerFunctionMapping:(JAHFunctionMapping*)functionMapping {
    NSString* key = [NSString stringWithFormat:@"%@|%@", functionMapping.element, functionMapping.namespace];
    [self.elementToFunction setObject:functionMapping forKey:key];
}

- (void*)functionToConvertElement:(NSXMLElement*)element {
    NSXMLNode* namespace = [element resolveNamespaceForName:[element name]];
    NSString* key = [NSString stringWithFormat:@"%@|%@", [element localName], [namespace stringValue]];
    JAHFunctionMapping* mapping = self.elementToFunction[key];
    return [mapping.functionValue pointerValue];
}

- (NSMutableDictionary*)elementToFunction {
    if (!_elementToFunction) {
        _elementToFunction = [NSMutableDictionary dictionary];
    }
    return _elementToFunction;
}

@end
