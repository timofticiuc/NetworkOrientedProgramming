//
//  NodeDiscovery.h
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@protocol NodeDiscoveryDelegate <NSObject>

-(void)hasDiscoveredNode:(Node*)node;

@end

@interface NodeDiscovery : NSObject

+ (NodeDiscovery *)sharedInstance;

-(void)beginDiscovery;

@property(nonatomic, assign) id<NodeDiscoveryDelegate> delegate;

@end
