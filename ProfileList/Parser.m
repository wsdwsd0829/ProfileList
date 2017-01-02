//
//  PhotoParser.m
//  FlickrDemo
//
//  Created by Sida Wang on 12/25/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "Parser.h"
#import "Profile.h"

@implementation Parser

-(void)parse:(id)responseObject withHandler:(void (^)(NSArray *, NSError *))handler {
    [self parseToItemsWith:responseObject withHandler:handler];
}

-(void)parseToItemsWith: (id) responseObject withHandler: (void(^)(NSArray* items, NSError* error)) handler {
    NSMutableArray* results = [NSMutableArray new];
    NSError* serialError;
    NSArray* responseObjects = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&serialError];
    if(serialError) {
        handler(nil, serialError);
        return;
    }
    if([responseObjects isKindOfClass: [NSArray class]]) {
        NSArray* objs = (NSArray*)responseObjects;
        for(id obj in objs) {
            if([obj objectForKey: @"firstName"] && [obj objectForKey:@"lastName"] && [obj objectForKey: @"id"] && [obj objectForKey: @"title"]) {
                @autoreleasepool {
                    if([obj isKindOfClass:[NSDictionary class]]) {
                        NSDictionary* itemDict = (NSDictionary*) obj;
                        NSString* identifier = itemDict[@"id"];
                        NSString* firstName = itemDict[@"firstName"];
                        NSString* lastName = itemDict[@"lastName"];
                        NSString* title = itemDict[@"title"];
                        
                        if(identifier && firstName && lastName && title) {

                            Profile* result = [[Profile alloc] initWithId:identifier withFirstName:firstName withLastName:lastName withTitle:title];
                            result.bio = [itemDict objectForKey:@"bio"];
                            result.avatar = [itemDict objectForKey:@"avatar"];
                            [results addObject:result];
                        }
                    }
                }
            }
        }
    }
    
    if(results.count > 0) {
        handler(results, nil);
    } else {
        NSError* err = [NSError errorWithDomain:kErrorDomainParse code:ErrorParseFailed userInfo: @{kErrorDisplayUserInfoKey: @"Fail to parse profiles"}];
        handler(nil, err);
    }
}
@end
