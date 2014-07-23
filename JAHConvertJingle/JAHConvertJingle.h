//
//  JAHConvertJingle.h
//  JAHConvertJingle
//
//  Created by Jon Hjelle on 7/16/14.
//  Copyright (c) 2014 Jon Hjelle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JAHFunctionMapper;

@interface JAHConvertJingle : NSObject

+ (id)objectForElement:(NSXMLNode*)parentElement;

+ (JAHFunctionMapper*)sharedFunctionMapper;

@end


@interface JAHFunctionMapping : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* element;
@property (nonatomic, strong) NSString* namespace;
@property (nonatomic, strong) NSValue* functionValue;

@end


@interface JAHFunctionMapper : NSObject

- (void)registerFunctionMapping:(JAHFunctionMapping*)functionMapping;

- (void*)functionToConvertElement:(NSXMLElement*)element;

@end
