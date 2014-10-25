//
//  HTTPRequester.h
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequester : NSObject

+(NSData*)performGETOn:(NSString*)url;
+(NSData*)performPOSTOn:(NSString*)url withBody:(NSData*)body;

@end
