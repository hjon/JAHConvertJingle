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

NSString* attribute(NSXMLElement* element, NSString* name) {
    NSXMLNode* attribute = [element attributeForName:name];
    return (attribute ? [attribute stringValue] : @"");
}

NSMutableDictionary* jingle(NSXMLElement* element) {
    NSMutableDictionary* jingleDictionary = [NSMutableDictionary dictionary];

    jingleDictionary[@"action"] = attribute(element, @"action");
    jingleDictionary[@"initiator"] = attribute(element, @"initiator");
    jingleDictionary[@"responder"] = attribute(element, @"responder");
    jingleDictionary[@"sid"] = attribute(element, @"sid");

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
