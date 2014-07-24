//
//  JAHConvertJingle+Jingle.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/23/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle+Jingle.h"

@implementation JAHConvertJingle (Jingle)

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

        for (NSXMLNode* node in [element children]) {
            if ([node kind] == NSXMLElementKind) {
                if ([[node name] isEqualToString:@"description"]) {
                    id descriptionObject = [JAHConvertJingle objectForElement:node];
                    if (descriptionObject) {
                        contentDictionary[@"description"] = descriptionObject;
                    }
                } else if ([[node name] isEqualToString:@"transport"]) {
                    id transportObject = [JAHConvertJingle objectForElement:node];
                    if (transportObject) {
                        contentDictionary[@"transport"] = transportObject;
                    }
                }
            }
        }

        return contentDictionary;
    }];
}


@end
