//
//  JAHConvertJingle+JAHJingleHelpers.h
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/23/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import "JAHConvertJingle.h"

@interface JAHConvertJingle (JAHJingleHelpers)

+ (NSString*)attributeForXMLElement:(NSXMLElement*)element withName:(NSString*)name defaultValue:(NSString*)defaultValue;

@end
