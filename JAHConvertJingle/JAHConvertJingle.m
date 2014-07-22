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

            NSXMLNode* namespace = [[element namespaces] firstObject];
            NSString* key = [NSString stringWithFormat:@"%@|%@", [element name], [namespace stringValue]];
            NSValue* functionPointer = [[[self class] functionDictionary] objectForKey:key];
            if (functionPointer) {
                id (*function)(NSXMLElement*) = [functionPointer pointerValue];
                return function(element);
            }
        }
    }

    return nil;
}

+ (NSDictionary*)functionDictionary {
    static NSMutableDictionary* functionDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        functionDictionary = [NSMutableDictionary dictionary];

        NSMutableDictionary* (*jinglePointer)(NSXMLElement*) = jingle;
        NSValue* jingleValue = [NSValue valueWithPointer:jinglePointer];
        functionDictionary[@"jingle|urn:xmpp:jingle:1"] = jingleValue;
    });
    return functionDictionary;
}

#pragma mark - Jingle Element Actions

NSMutableDictionary* jingle(NSXMLElement* element) {
    NSMutableDictionary* jingleDictionary = [NSMutableDictionary dictionary];

    NSXMLNode* action = [element attributeForName:@"action"];
    if (action) {
        jingleDictionary[[action name]] = [action stringValue];
    }

    NSXMLNode* sid = [element attributeForName:@"sid"];
    if (sid) {
        jingleDictionary[[sid name]] = [sid stringValue];
    }

    NSXMLNode* initiator = [element attributeForName:@"initiator"];
    if (initiator) {
        jingleDictionary[[initiator name]] = [initiator stringValue];
    }

    NSXMLNode* responder = [element attributeForName:@"responder"];
    if (responder) {
        jingleDictionary[[responder name]] = [responder stringValue];
    }

    NSMutableArray* children = [NSMutableArray array];
    for (NSXMLNode* node in [element children]) {
        id object = [JAHConvertJingle objectForElement:node];
        if (object) {
            [children addObject:object];
        }
    }
    if ([children count] > 0) {
        jingleDictionary[@"contents"] = children;
    }

    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:jingleDictionary forKey:[element name]];

    return dictionary;
}

@end
