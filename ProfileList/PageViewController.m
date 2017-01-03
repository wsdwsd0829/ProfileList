//
//  PageViewController.m
//  iOSCodingChallenge
//
//  Created by Sida Wang on 12/28/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(DetailViewController*) createDetailPage{
    DetailViewController* dvc = [[DetailViewController alloc] init];
    dvc.viewModel = self.viewModel;
    return dvc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if(![viewController isKindOfClass: [DetailViewController class]]) {
        return nil;
    }
    DetailViewController* oldVC = (DetailViewController*)viewController;
    DetailViewController* dvc = [self createDetailPage];
    dvc.profile = [self.viewModel previousProfileFor:oldVC.profile];
    return dvc.profile ? dvc: nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if(![viewController isKindOfClass: [DetailViewController class]]) {
        return nil;
    }
    DetailViewController* oldVC = (DetailViewController*)viewController;
    DetailViewController* dvc = [self createDetailPage];
    dvc.profile = [self.viewModel nextProfileFor: oldVC.profile];
    return dvc.profile ? dvc: nil;
}


@end
