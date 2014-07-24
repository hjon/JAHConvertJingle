//
//  JAHConvertJingle.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle.h"

@implementation JAHConvertJingle

+ (id)objectForElement:(NSXMLNode*)node {
    if ([node kind] == NSXMLElementKind) {
        NSXMLElement* element = (NSXMLElement*)node;
        NSLog(@"Name: %@", [element name]);

        XMLConversionBlock block = [[self class] blockForElement:element];
        if (block) {
            return block(element);
        }
    }

    return nil;
}

+ (NSMutableDictionary*)sharedConversionMap {
    static NSMutableDictionary* conversionMap;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        conversionMap = [NSMutableDictionary dictionary];
    });
    return conversionMap;
}

+ (void)registerElementName:(NSString*)name namespace:(NSString*)namespace withBlock:(XMLConversionBlock)block {
    NSString* key = [NSString stringWithFormat:@"%@|%@", name, namespace];
    [[[self class] sharedConversionMap] setObject:block forKey:key];
}

+ (XMLConversionBlock)blockForElement:(NSXMLElement*)element {
    NSXMLNode* namespace = [element resolveNamespaceForName:[element name]];
    NSString* key = [NSString stringWithFormat:@"%@|%@", [element localName], [namespace stringValue]];
    return [[[self class] sharedConversionMap] objectForKey:key];
}

+ (NSString*)attributeForXMLElement:(NSXMLElement*)element withName:(NSString*)name defaultValue:(NSString*)defaultValue {
    NSXMLNode* attribute = [element attributeForName:name];
    NSString* value = attribute ? [attribute stringValue] : defaultValue;
    value = value ? value : @"";
    return value;
}

@end
