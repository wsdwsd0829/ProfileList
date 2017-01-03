//
//  PageViewController.h
//  iOSCodingChallenge
//
//  Created by Sida Wang on 12/28/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

#import "ProfilesViewModel.h"
#import "ProfileScrollView.h"
@interface DetailViewController: UIViewController

@property (nonatomic) ProfileScrollView* scrollView;

//@property (nonatomic) UILabel* nameLabel;
//@property (nonatomic) UILabel* titleLabel;
//@property (nonatomic) UILabel* bioLabel;
//@property (nonatomic) UIImageView* imageView;

//dependencies
@property (nonatomic) Profile* profile;
//better to have it's own ProfileViewModel managed by ProfilesViewModel as Array
@property (nonatomic) ProfilesViewModel* viewModel;

@end
