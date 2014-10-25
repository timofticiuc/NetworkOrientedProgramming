//
//  HTTPRequester.m
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "HTTPRequester.h"

@implementation HTTPRequester

+(NSData*)performGETOn:(NSString*)url
{
    NSData *result = nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0.1];
    [request setHTTPMethod:@"GET"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    result = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    return result;
}

+(NSData*)performPOSTOn:(NSString*)url withBody:(NSData*)body
{
    NSData *result = nil;
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0.1];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    result = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    return result;
}

@end
