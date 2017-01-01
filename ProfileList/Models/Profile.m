//
//  Profile.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "Profile.h"

@implementation Profile

-(instancetype)initWithId: (NSString*) identifier withFirstName:(NSString*) firstName withLastName:(NSString*) lastName withTitle: (NSString*) title {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _firstName = firstName;
        _lastName = lastName;
        _title = title;
    }
    return self;
}



@end
