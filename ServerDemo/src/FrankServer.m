//
//  FrankServer.m
//  Frank
//
//  Created by phodgson on 5/24/10.
//  Copyright 2010 ThoughtWorks. See NOTICE file for details.
//

#import "FrankServer.h"

#import "HTTPServer.h"
#import "RoutingHTTPConnection.h"
#import "FrankCommandRoute.h"
#import "VersionCommand.h"
#import "SuccessCommand.h"
#import "DiscoveryCommand.h"
#import "Endpoints.h"

#ifndef FRANK_PRODUCT_VERSION
#define FRANK_PRODUCT_VERSION 1.0
#endif

#define xstr(s) str(s)
#define str(s) #s
#define VERSIONED_NAME "Frank iOS Server " xstr(FRANK_PRODUCT_VERSION)
const unsigned char frank_what_string[] = "@(#)" VERSIONED_NAME "\n";

static NSUInteger __defaultPort = FRANK_SERVER_PORT;
@implementation FrankServer

+ (void)setDefaultHttpPort:(NSUInteger)port
{
    __defaultPort = port;
}
- (id) initWithDefaultBundle {
	return [self initWithStaticFrankBundleNamed: @"frank_static_resources"];
}

- (id) initWithStaticFrankBundleNamed:(NSString *)bundleName
{    
	self = [super init];
	if (self != nil) {
		if( ![bundleName hasSuffix:@".bundle"] )
			bundleName = [bundleName stringByAppendingString:@".bundle"];
		
		FrankCommandRoute *frankCommandRoute = [FrankCommandRoute singleton];
        
        [frankCommandRoute registerCommand:[[[VersionCommand alloc] initWithVersion:[NSString stringWithFormat:@"%s",xstr(FRANK_PRODUCT_VERSION)]]autorelease] withName:ENDPOINT_VERSION];
        [frankCommandRoute registerCommand:[[[DiscoveryCommand alloc] init]autorelease] withName:ENDPOINT_DISCOVERY];
        
		[[RequestRouter singleton] registerRoute:frankCommandRoute];
		
		_httpServer = [[[HTTPServer alloc]init] retain];
		
		[_httpServer setName:@"Frank UISpec server"];
		[_httpServer setType:@"_http._tcp."];
		[_httpServer setConnectionClass:[RoutingHTTPConnection class]];
		[_httpServer setPort:__defaultPort];
		NSLog( @"Creating the server: %@", _httpServer );
	}
	return self;
}

- (BOOL) startServer{
    NSLog( @"Starting server %s", VERSIONED_NAME );
	NSError *error;
	if( ![_httpServer start:&error] ) {
		NSLog(@"Error starting HTTP Server:");// %@", error);
		return NO;
	}
	return YES;
}

- (void) dealloc
{
	[_httpServer release];
	[super dealloc];
}

@end
