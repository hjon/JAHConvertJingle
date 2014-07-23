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

NSString* attribute(NSXMLElement* element, NSString* name, NSString* defaultValue) {
    NSXMLNode* attribute = [element attributeForName:name];
    NSString* value = attribute ? [attribute stringValue] : defaultValue;
    value = value ? value : @"";
    return value;
}

NSMutableDictionary* jingle(NSXMLElement* element) {
    NSMutableDictionary* jingleDictionary = [NSMutableDictionary dictionary];

    jingleDictionary[@"action"] = attribute(element, @"action", nil);
    jingleDictionary[@"initiator"] = attribute(element, @"initiator", nil);
    jingleDictionary[@"responder"] = attribute(element, @"responder", nil);
    jingleDictionary[@"sid"] = attribute(element, @"sid", nil);

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

NSMutableDictionary* content(NSXMLElement* element) {
    NSMutableDictionary* contentDictionary = [NSMutableDictionary dictionary];

    contentDictionary[@"creator"] = attribute(element, @"creator", nil);
    contentDictionary[@"disposition"] = attribute(element, @"disposition", @"session");
    contentDictionary[@"name"] = attribute(element, @"name", nil);
    contentDictionary[@"senders"] = attribute(element, @"senders", @"both");

    NSXMLElement* description = [[element elementsForName:@"description"] firstObject];
    id descriptionObject = [JAHConvertJingle objectForElement:description];
    if (descriptionObject) {
        contentDictionary[@"description"] = descriptionObject;
    }

    NSXMLElement* transport = [[element elementsForName:@"transport"] firstObject];
    id transportObject = [JAHConvertJingle objectForElement:transport];
    if (transportObject) {
        contentDictionary[@"transport"] = transportObject;
    }

    return contentDictionary;
}

@end
