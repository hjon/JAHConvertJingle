//
//  JAHConvertJingle.h
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^XMLConversionBlock)(NSXMLElement* element);
typedef id (^CocoaConversionBlock)(id);

@interface JAHConvertJingle : NSObject

+ (id)objectForElement:(NSXMLNode*)parentElement;

+ (void)registerElementName:(NSString*)name namespace:(NSString*)namespace withDictionary:(NSDictionary*)dictionary;
+ (XMLConversionBlock)blockForElement:(NSXMLElement*)element; // block to convert from XML to Cocoa objects
+ (CocoaConversionBlock)blockForName:(NSString*)name namespace:(NSString*)namespace; // block to convert from Cocoa objects to XML

+ (NSString*)attributeForXMLElement:(NSXMLElement*)element withName:(NSString*)name defaultValue:(NSString*)defaultValue;
+ (NSArray*)childrenOfElement:(NSXMLElement*)element withName:(NSString*)name namespace:(NSString*)namespace;

@end
