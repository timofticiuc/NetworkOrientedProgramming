//
//  AppDelegate.m
//  ServerDemo
//
//  Created by Andrei-Gabriel Timofticiuc on 7/17/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "AppDelegate.h"
#import "FrankServer.h"

@interface AppDelegate ()
            
@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

static Node *mainNode;

+(NSString*) getIP{
    NSArray *addresses = [[NSHost currentHost] addresses];
    NSString *address;
    
    for (NSString *anAddress in addresses) {
        if (![anAddress hasPrefix:@"127"] && [[anAddress componentsSeparatedByString:@"."] count] == 4) {
            address = anAddress;
            break;
        } else {
            address = @"IPv4 address not available" ;
        }
    }
    
    return address;
}

-(void)hasDiscoveredNode:(Node *)node
{
    [dataSource addObject:node];
    
    [_mainTableView beginUpdates];
    [_mainTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:dataSource.count-1] withAnimation:NSTableViewAnimationEffectGap];
    [_mainTableView endUpdates];
}

+(Node*)mainNodeInstance
{
    static dispatch_once_t predicate;
    
	dispatch_once(&predicate, ^{
        mainNode = [Node new];
        mainNode.ip = [AppDelegate getIP];
        mainNode.clientName = [[NSHost currentHost] localizedName];
    });
    
	return mainNode;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    dataSource = [NSMutableArray new];
    [_mainTableView setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
    static dispatch_once_t frankDidBecomeActiveToken;
    
    _nodeLabel.stringValue = [NSString stringWithFormat:@"%@@%@", [AppDelegate mainNodeInstance].clientName, [AppDelegate mainNodeInstance].ip];
    
    dispatch_once(&frankDidBecomeActiveToken, ^{
        FrankServer *server = [[FrankServer alloc] initWithDefaultBundle];
        [server startServer];
    });
    
    [[NodeDiscovery sharedInstance] beginDiscovery];
    [NodeDiscovery sharedInstance].delegate = self;
//     Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//tableviewDelegate

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    // There is no existing cell to reuse so create a new one
    if (result == nil) {
        
        // Create the new NSTextField with a frame of the {0,0} with the width of the table.
        // Note that the height of the frame is not really relevant, because the row height will modify the height.
        result = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
        
        // The identifier of the NSTextField instance is set to MyView.
        // This allows the cell to be reused.
        result.identifier = @"MyView";
    }
    
    // result is now guaranteed to be valid, either as a reused cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    [result setBordered:NO];
    [result setEditable:NO];
    result.stringValue = [tableColumn.identifier isEqualToString:@"0"]?((Node*)dataSource[row]).clientName:((Node*)dataSource[row]).ip;
    
    // Return the result
    return result;
    
}

@end
