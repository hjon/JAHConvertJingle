//
//  JAHConvertJingle.h
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^XMLToObjectBlock)(NSXMLElement* element);
typedef id (^ObjectToXMLBlock)(id);

@interface JAHConvertJingle : NSObject

+ (id)objectForElement:(NSXMLNode*)parentElement;

+ (void)registerElementName:(NSString*)name namespace:(NSString*)namespace withDictionary:(NSDictionary*)dictionary;
+ (XMLToObjectBlock)blockForElement:(NSXMLElement*)element;
+ (ObjectToXMLBlock)blockForName:(NSString*)name namespace:(NSString*)namespace;

+ (NSString*)attributeForXMLElement:(NSXMLElement*)element withName:(NSString*)name defaultValue:(NSString*)defaultValue;
+ (NSArray*)childrenOfElement:(NSXMLElement*)element withName:(NSString*)name namespace:(NSString*)namespace;

@end
