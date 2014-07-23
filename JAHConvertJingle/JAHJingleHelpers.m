//
//  JAHJingleHelpers.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/23/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHJingleHelpers.h"
#import "JAHConvertJingle.h"

@implementation JAHJingleHelpers

NSMutableDictionary* jingle(NSXMLElement* element) {
    NSMutableDictionary* jingleDictionary = [NSMutableDictionary dictionary];

    NSXMLNode* action = [element attributeForName:@"action"];
    if (action) {
        jingleDictionary[@"action"] = [action stringValue];
    }

    NSXMLNode* sid = [element attributeForName:@"sid"];
    if (sid) {
        jingleDictionary[@"sid"] = [sid stringValue];
    }

    NSXMLNode* initiator = [element attributeForName:@"initiator"];
    if (initiator) {
        jingleDictionary[@"initiator"] = [initiator stringValue];
    }

    NSXMLNode* responder = [element attributeForName:@"responder"];
    if (responder) {
        jingleDictionary[@"responder"] = [responder stringValue];
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
    [dictionary setObject:jingleDictionary forKey:@"jingle"];

    return dictionary;
}

@end
