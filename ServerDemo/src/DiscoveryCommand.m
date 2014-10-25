//
//  DiscoveryCommand.m
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "DiscoveryCommand.h"
#import "JSON.h"
#import "AppDelegate.h"

@implementation DiscoveryCommand

- (NSString *)handleCommandWithRequestBody:(NSString *)requestBody {
    
    NSDictionary *responseDictionary = @{@"ip":[AppDelegate mainNodeInstance].ip, @"clientName":[AppDelegate mainNodeInstance].clientName};
    
    return TO_JSON(responseDictionary);
}

@end
