//
//  NetworkManager.m
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//
#import "ApiClientProtocol.h"
#import "ParserProtocol.h"
#import "Reachability.h"
#import "NetworkService.h"
#import "ApiClient.h"
#import "Parser.h"


@interface NetworkService () {
    id<ApiClientProtocol> apiClient;
    id<ParserProtocol> parser;
    Reachability* reachability;
}

@end
@implementation NetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        apiClient = [ApiClient defaultClient];
        parser = [[Parser alloc] init]; //? can this be singeton, can I just use static method to parse data
        
        //setup reachability
        reachability = [Reachability reachabilityForInternetConnection];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
        [reachability startNotifier];
        
    }
    return self;
}

-(void)loadImageWithUrlString: (NSString*) urlString withHandler:(void(^)(NSData* data, NSError* error))handler{
    //GCD or Operation
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(imageData);
        });
    });
     */
    [apiClient fetchWithUrlString:urlString withHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        handler(responseObject, error);
    }];
}


//Mark: Reachability Protocol
-(void)networkChanged:(NSNotification*) notification {
    Reachability* reach = notification.object;
    if([reach currentReachabilityStatus] == ReachableViaWiFi || [reach currentReachabilityStatus] == ReachableViaWWAN) {
        NSString* isFromNotReachable = [[NSUserDefaults standardUserDefaults] stringForKey:@"kNotReachable"];
        if([isFromNotReachable isEqualToString:@"YES"]) {
            [self networkChangedFromOfflineToOnline:notification];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kNotReachable"];
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kNotReachable"];
    }
}
-(void)networkChangedFromOfflineToOnline:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkOfflineToOnline object: notification.object];
}

-(void)dealloc {
    [reachability stopNotifier];
}
@end
