//
//  PageViewController.h
//  iOSCodingChallenge
//
//  Created by Sida Wang on 12/28/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfilesViewModel.h"
#import "DetailViewController.h"
#import "OpenSourceProtocol.h"

@interface PageViewController : UIPageViewController <OpenSourceProtocol,UIPageViewControllerDataSource>
@property (nonatomic) CGRect fromFrame;
@property (nonatomic) ProfilesViewModel* viewModel; //the point to above that is serving
-(DetailViewController*) createDetailPage;
@end
