//
//  Profile.h
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

-(instancetype)initWithId: (NSString*) identifier withFirstName:(NSString*) firstName withLastName:(NSString*) lastName withTitle: (NSString*) title;

@property (nonatomic, readonly, copy) NSString* identifier;
@property (nonatomic, readonly, copy) NSString* firstName;
@property (nonatomic, readonly, copy) NSString* lastName;
@property (nonatomic, readonly, copy) NSString* title;

@property  (nonatomic, copy) NSString* bio;
@property  (nonatomic, copy) NSString* avatar;

@end
