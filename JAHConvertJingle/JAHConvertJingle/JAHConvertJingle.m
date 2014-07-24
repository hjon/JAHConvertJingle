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

        XMLToObjectBlock block = [[self class] blockForElement:element];
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

+ (void)registerElementName:(NSString*)name namespace:(NSString*)namespace withDictionary:(NSDictionary*)dictionary {
    NSString* key = [NSString stringWithFormat:@"%@|%@", name, namespace];
    [[[self class] sharedConversionMap] setObject:dictionary forKey:key];
}

+ (XMLToObjectBlock)blockForElement:(NSXMLElement*)element {
    NSXMLNode* namespace = [element resolveNamespaceForName:[element name]];
    NSString* key = [NSString stringWithFormat:@"%@|%@", [element localName], [namespace stringValue]];
    NSDictionary* dictionary = [[[self class] sharedConversionMap] objectForKey:key];
    return dictionary[@"toObject"];
}

+ (ObjectToXMLBlock)blockForName:(NSString*)name namespace:(NSString*)namespace {
    NSString* key = [NSString stringWithFormat:@"%@|%@", name, namespace];
    NSDictionary* dictionary = [[[self class] sharedConversionMap] objectForKey:key];
    return dictionary[@"toElement"];
}

+ (NSString*)attributeForXMLElement:(NSXMLElement*)element withName:(NSString*)name defaultValue:(NSString*)defaultValue {
    NSXMLNode* attribute = [element attributeForName:name];
    NSString* value = attribute ? [attribute stringValue] : defaultValue;
    value = value ? value : @"";
    return value;
}

+ (NSArray*)childrenOfElement:(NSXMLElement*)element withName:(NSString*)name namespace:(NSString*)namespace {
    NSMutableArray* children = [NSMutableArray array];
    for (NSXMLNode* node in [element elementsForLocalName:name URI:namespace]) {
        id object = [JAHConvertJingle objectForElement:node];
        if (object) {
            [children addObject:object];
        }
    }

    return children;
}

@end
