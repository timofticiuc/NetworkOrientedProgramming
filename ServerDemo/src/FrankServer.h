//
//  FrankServer.h
//  Frank
//
//  Created by phodgson on 5/24/10.
//  Copyright 2010 ThoughtWorks. See NOTICE file for details.
//

#import <Cocoa/Cocoa.h>

@class HTTPServer;

#define FRANK_SERVER_PORT 37266

@interface FrankServer : NSObject {
	HTTPServer *_httpServer;
}
+ (void)setDefaultHttpPort:(NSUInteger)port;
             

- (id) initWithDefaultBundle;
- (id) initWithStaticFrankBundleNamed:(NSString *)bundleName;

- (BOOL) startServer;


@end
