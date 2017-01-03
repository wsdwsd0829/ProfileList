//
//  PageViewController.m
//  iOSCodingChallenge
//
//  Created by Sida Wang on 12/28/16.
//  Copyright © 2016 Touch of Modern. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry.h"
@interface DetailViewController ()<ProfileScrollViewDelegate>
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //create & config
    self.scrollView = [[ProfileScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.profileScrollViewDelegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferFontChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self preferFontChanged: nil];
    //add to heirarchy and set constaints
    [self setupConstraints];
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [self setNavigationItemTitle];
}

-(void) setupConstraints {
    [self.view addSubview: self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.scrollView.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
    }];
}

-(void) preferFontChanged:(id)notification {
   //[[UIApplication sharedApplication] preferredContentSizeCategory];
    self.scrollView.nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.scrollView.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.scrollView.bioLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self updateUI];
}

-(void) updateUI {
    NSInteger index = [self.viewModel.profiles indexOfObject:self.profile];
    self.scrollView.nameLabel.text = [self.viewModel fullNameForProfileAtIndex:index] ;
    self.scrollView.bioLabel.text = [self.viewModel bioForProfileAtIndex:index];
    self.scrollView.titleLabel.text = [self.viewModel titleForProfileAtIndex:index];
    [self.scrollView.imageView sd_setImageWithURL:[NSURL URLWithString: self.profile.avatar]
                 placeholderImage:[UIImage imageNamed:@"persion-placeholder"]];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //NSLog(@"%f", [self.topLayoutGuide length]);
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


#pragma mark - ProfileScrollViewDelegate 
-(void)headerViewDidOffScreenWithOffset:(CGFloat)offset inScrollView:(UIScrollView *)scrollView {
    [self setNavigationItemTitle];
}
-(void)headerViewDidShowOnScreenWithOffset:(CGFloat)offset inScrollView:(UIScrollView *)scrollView{
    [self setNavigationItemTitle];
}

-(void) setNavigationItemTitle {
    CGFloat offset = [self.scrollView headerImageOffset];
    if(offset > -150) {
        self.parentViewController.navigationItem.titleView = nil;
        return;
    }
    
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 22;
    imageView.clipsToBounds = YES;
    imageView.image = self.scrollView.imageView.image;
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    imageView.frame = titleView.bounds;
    [titleView addSubview:imageView];
    
    self.parentViewController.navigationItem.titleView = titleView;
}


@end
