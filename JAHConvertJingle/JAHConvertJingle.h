//
//  JAHConvertJingle.h
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^XMLConversionBlock)(NSXMLElement* element);

@interface JAHConvertJingle : NSObject

+ (id)objectForElement:(NSXMLNode*)parentElement;

+ (void)registerElementName:(NSString*)name namespace:(NSString*)namespace withBlock:(XMLConversionBlock)block;
+ (XMLConversionBlock)blockForElement:(NSXMLElement*)element;

@end
