//
//  ProfilesViewModel.h
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
#import "CacheService.h"

typedef void(^updateUI)();
@interface ProfilesViewModel : NSObject

@property (nonatomic, copy) NSArray<Profile *>* profiles;

@property id<CacheServiceProtocol> cacheService;
@property (nonatomic, copy) updateUI updateBlock;

-(void) loadProfiles;

-(NSString*) fullNameForProfileAtIndex:(NSInteger)index;
-(NSString*) titleForProfileAtIndex:(NSInteger) index;
-(NSString*) bioForProfileAtIndex:(NSInteger) index;

@end
