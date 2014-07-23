//
//  JAHConvertJingleTests.m
//  JAHConvertJingleTests
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JAHConvertJingle.h"
#import "JAHJingleHelpers.h"

@interface JAHConvertJingleTests : XCTestCase

@end

@implementation JAHConvertJingleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJingleXMLToObjects {
    JAHFunctionMapping* jingleMapping = [[JAHFunctionMapping alloc] init];
    jingleMapping.name = @"jingle";
    jingleMapping.element = @"jingle";
    jingleMapping.namespace = @"urn:xmpp:jingle:1";
    NSMutableDictionary* (*jinglePointer)(NSXMLElement*) = jingle;
    NSValue* jingleValue = [NSValue valueWithPointer:jinglePointer];
    jingleMapping.functionValue = jingleValue;
    [[JAHConvertJingle sharedFunctionMapper] registerFunctionMapping:jingleMapping];

    NSBundle* testBundle = [NSBundle bundleForClass:[self class]];
    NSURL* jingleURL = [testBundle URLForResource:@"jingle" withExtension:@"xml"];
    NSXMLDocument* document = [[NSXMLDocument alloc] initWithContentsOfURL:jingleURL options:0 error:nil];

    NSXMLElement* aNode = [document rootElement];
    NSXMLElement* iqElement = [[aNode children] firstObject];

    NSDictionary* dictionary = [JAHConvertJingle objectForElement:[[iqElement children] firstObject]];

    NSLog(@"Dictionary: %@", dictionary);
    XCTAssertNotNil(dictionary, @"No dictionary could be made");
}

@end
