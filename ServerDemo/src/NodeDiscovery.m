//
//  NodeDiscovery.m
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "NodeDiscovery.h"
#import "Endpoints.h"
#import "HTTPRequester.h"
#import "JSON.h"
#import "FrankServer.h"

static NodeDiscovery *sharedInstance;

@implementation NodeDiscovery

+ (NodeDiscovery *)sharedInstance {
	static dispatch_once_t predicate;
    
	dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
	return sharedInstance;
}

-(void)beginDiscovery
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        for(int i=0;i<=255;++i)
        {
            Node* node = [Node new];
            
            NSString *ip = [NSString stringWithFormat:@"http://192.168.1.%d:%d/%@",i, FRANK_SERVER_PORT,ENDPOINT_DISCOVERY];
            NSLog(@"discovery for %@", ip);
            
            NSData *response = [HTTPRequester performGETOn:ip];
            
            if(response!=nil)
            {
                NSDictionary *responseDictionary = FROM_JSON([[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding]);
                NSLog(@"response for %@ with:\n %@", ip, [responseDictionary description]);
                
                node.ip = responseDictionary[@"ip"];
                node.clientName = responseDictionary[@"clientName"];
                
                if(_delegate!=nil && [_delegate respondsToSelector:@selector(hasDiscoveredNode:)])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_delegate hasDiscoveredNode:node];
                    });
                }
            }
        }
    });
}

@end
