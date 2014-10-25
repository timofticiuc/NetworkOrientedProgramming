//
//  AppDelegate.h
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Node.h"
#import "NodeDiscovery.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NodeDiscoveryDelegate>
{
    NSMutableArray *dataSource;
}

+(Node*)mainNodeInstance;

@property(nonatomic, retain) IBOutlet NSTableView *mainTableView;
@property(nonatomic, retain) IBOutlet NSTextField *nodeLabel;

@end

