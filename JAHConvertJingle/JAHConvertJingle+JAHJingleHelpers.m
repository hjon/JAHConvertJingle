//
//  JAHConvertJingle+JAHJingleHelpers.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/23/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle+JAHJingleHelpers.h"

@implementation JAHConvertJingle (JAHJingleHelpers)

+ (void)load {
    [[self class] registerElementName:@"jingle" namespace:@"urn:xmpp:jingle:1" withBlock:^id(NSXMLElement *element) {
        NSMutableDictionary* jingleDictionary = [NSMutableDictionary dictionary];

        jingleDictionary[@"action"] = [JAHConvertJingle attributeForXMLElement:element withName:@"action" defaultValue:nil];
        jingleDictionary[@"initiator"] = [JAHConvertJingle attributeForXMLElement:element withName:@"initiator" defaultValue:nil];
        jingleDictionary[@"responder"] = [JAHConvertJingle attributeForXMLElement:element withName:@"responder" defaultValue:nil];
        jingleDictionary[@"sid"] = [JAHConvertJingle attributeForXMLElement:element withName:@"sid" defaultValue:nil];

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
    }];

    [[self class] registerElementName:@"content" namespace:@"urn:xmpp:jingle:1" withBlock:^id(NSXMLElement *element) {
        NSMutableDictionary* contentDictionary = [NSMutableDictionary dictionary];

        contentDictionary[@"creator"] = [JAHConvertJingle attributeForXMLElement:element withName:@"creator" defaultValue:nil];
        contentDictionary[@"disposition"] = [JAHConvertJingle attributeForXMLElement:element withName:@"disposition" defaultValue:@"session"];
        contentDictionary[@"name"] = [JAHConvertJingle attributeForXMLElement:element withName:@"name" defaultValue:nil];
        contentDictionary[@"senders"] = [JAHConvertJingle attributeForXMLElement:element withName:@"senders" defaultValue:@"both"];

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
    }];
}


@end
