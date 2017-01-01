//
//  FlickrNetworkServiceProtocol.h
//  FlickrDemo
//
//  Created by Sida Wang on 12/26/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkResultHandler)(NSArray* items, NSError* error);

@protocol NetworkServiceProtocol <NSObject>

-(void)loadImageWithUrlString: (NSString*) urlString withHandler:(void(^)(NSData* data, NSError* error))handler;


@end
