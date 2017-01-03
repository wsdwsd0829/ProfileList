//
//  ProfilesViewModel.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ProfilesViewModel.h"
#import "NetworkService.h"
#import "PersistService.h"

@interface ProfilesViewModel () {
    id<NetworkServiceProtocol> networkService;
    id<PersistServiceProtocol> persistService;
}
@end

@implementation ProfilesViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _profiles = [NSMutableArray new];
        
        //setup services
        networkService = [[NetworkService alloc] init];
      
        persistService = [[PersistService alloc] init];
    }
    return self;
}

-(void) loadProfiles {
    [persistService loadDataWithHandler:^(id profs, NSError *error) {
        if(error) {
            NSLog(@"Error Loading Profiles");
        } else {
            if(![profs isKindOfClass: [NSArray class]]) {
                [[NSException exceptionWithName:@"Logic Error" reason:@"expect array of profiles from persistService" userInfo:nil] raise];
            }
            self.profiles = profs;
            self.updateBlock();
        }
    }];
}

-(NSString*) fullNameForProfileAtIndex:(NSInteger)index {
    if(index < self.profiles.count) {
        Profile* profile = self.profiles[index];
        return [NSString stringWithFormat:@"%@ %@", profile.firstName, profile.lastName];
    } else {
        return @"";
    }
}

-(NSString*) titleForProfileAtIndex:(NSInteger) index {
    if(index < self.profiles.count) {
        return self.profiles[index].title;
    } else {
        return @"";
    }
}

-(NSString*) bioForProfileAtIndex:(NSInteger) index {
    if(index < self.profiles.count) {
        return self.profiles[index].bio;
    } else {
        return @"";
    }
}

-(Profile*)previousProfileFor:(Profile *)profile {
    NSInteger index = [self.profiles indexOfObject: profile];
    if(index == 0) {
        return nil;
    }
    return self.profiles[index - 1];
}

-(Profile*)nextProfileFor:(Profile *)profile {
    NSInteger index = [self.profiles indexOfObject: profile];
    if(index == self.profiles.count-1) {
        return nil;
    }
    return self.profiles[index + 1];
}


@end
