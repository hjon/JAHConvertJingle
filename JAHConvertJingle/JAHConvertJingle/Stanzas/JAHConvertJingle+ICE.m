//
//  JAHConvertJingle+ICE.m
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/24/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle+ICE.h"

@implementation JAHConvertJingle (ICE)

+ (void)load {
    [[self class] registerElementName:@"transport" namespace:@"urn:xmpp:jingle:transports:ice-udp:1" withBlock:^id(NSXMLElement *element) {
        NSMutableDictionary* iceDictionary = [NSMutableDictionary dictionary];

        iceDictionary[@"transType"] = @"iceUdp";
        iceDictionary[@"pwd"] = [JAHConvertJingle attributeForXMLElement:element withName:@"pwd" defaultValue:nil];
        iceDictionary[@"ufrag"] = [JAHConvertJingle attributeForXMLElement:element withName:@"ufrag" defaultValue:nil];

        iceDictionary[@"candidates"] = [JAHConvertJingle childrenOfElement:element withName:@"candidate" namespace:@"urn:xmpp:jingle:transports:ice-udp:1"];
        iceDictionary[@"fingerprints"] = [JAHConvertJingle childrenOfElement:element withName:@"fingerprint" namespace:@"urn:xmpp:jingle:apps:dtls:0"];
        iceDictionary[@"sctp"] = [JAHConvertJingle childrenOfElement:element withName:@"sctpmap" namespace:@"urn:xmpp:jingle:transports:dtls-sctp:1"];

        return iceDictionary;
    }];


    [[self class] registerElementName:@"candidate" namespace:@"urn:xmpp:jingle:transports:ice-udp:1" withBlock:^id(NSXMLElement *element) {
        NSMutableDictionary* candidateDictionary = [NSMutableDictionary dictionary];

        candidateDictionary[@"component"] = [JAHConvertJingle attributeForXMLElement:element withName:@"component" defaultValue:nil];
        candidateDictionary[@"foundation"] = [JAHConvertJingle attributeForXMLElement:element withName:@"foundation" defaultValue:nil];
        candidateDictionary[@"generation"] = [JAHConvertJingle attributeForXMLElement:element withName:@"generation" defaultValue:nil];
        candidateDictionary[@"id"] = [JAHConvertJingle attributeForXMLElement:element withName:@"id" defaultValue:nil];
        candidateDictionary[@"ip"] = [JAHConvertJingle attributeForXMLElement:element withName:@"ip" defaultValue:nil];
        candidateDictionary[@"network"] = [JAHConvertJingle attributeForXMLElement:element withName:@"network" defaultValue:nil];
        candidateDictionary[@"port"] = [JAHConvertJingle attributeForXMLElement:element withName:@"port" defaultValue:nil];
        candidateDictionary[@"priority"] = [JAHConvertJingle attributeForXMLElement:element withName:@"priority" defaultValue:nil];
        candidateDictionary[@"protocol"] = [JAHConvertJingle attributeForXMLElement:element withName:@"protocol" defaultValue:nil];
        candidateDictionary[@"relAddr"] = [JAHConvertJingle attributeForXMLElement:element withName:@"rel-addr" defaultValue:nil];
        candidateDictionary[@"relPort"] = [JAHConvertJingle attributeForXMLElement:element withName:@"rel-port" defaultValue:nil];
        candidateDictionary[@"type"] = [JAHConvertJingle attributeForXMLElement:element withName:@"type" defaultValue:nil];

        return candidateDictionary;
    }];

    [[self class] registerElementName:@"fingerprint" namespace:@"urn:xmpp:jingle:apps:dtls:0" withBlock:^id(NSXMLElement  *element) {
        NSMutableDictionary* fingerprintDictionary = [NSMutableDictionary dictionary];

        fingerprintDictionary[@"hash"] = [JAHConvertJingle attributeForXMLElement:element withName:@"hash" defaultValue:nil];
        fingerprintDictionary[@"setup"] = [JAHConvertJingle attributeForXMLElement:element withName:@"setup" defaultValue:nil];
        fingerprintDictionary[@"value"] = [element stringValue];

        return fingerprintDictionary;
    }];

    [[self class] registerElementName:@"sctpmap" namespace:@"urn:xmpp:jingle:transports:dtls-sctp:1" withBlock:^id(NSXMLElement *element) {
        NSMutableDictionary* sctpDictionary = [NSMutableDictionary dictionary];

        sctpDictionary[@"number"] = [JAHConvertJingle attributeForXMLElement:element withName:@"number" defaultValue:nil];
        sctpDictionary[@"protocol"] = [JAHConvertJingle attributeForXMLElement:element withName:@"protocol" defaultValue:nil];
        sctpDictionary[@"streams"] = [JAHConvertJingle attributeForXMLElement:element withName:@"streams" defaultValue:nil];

        return sctpDictionary;
    }];
}

@end
