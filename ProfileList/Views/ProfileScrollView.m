//
//  ProfileScrollView.m
//  ProfileList
//
//  Created by Sida Wang on 1/2/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "ProfileScrollView.h"
#import "Masonry.h"
#import "UILabel+Convenient.h"

CGFloat kProfileImageHeight = 300;
CGFloat kMaxInsetY = 150;

@implementation ProfileScrollView 

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.isHeightCalculated = NO;
        self.backgroundColor = [UIColor grayColor];
        self.delegate = self;
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentView = contentView;
    //nameLabel
    UILabel* nameLabel = [UILabel labelWithMultiline];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
    //titleLabel
    UILabel* titleLabel = [UILabel labelWithMultiline];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    //bioLabel
    UILabel* bioLabel = [UILabel labelWithMultiline];
    self.bioLabel = bioLabel;

    //image
    UIImage* image = [UIImage imageNamed:@"person-placeholder"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage: image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView = imageView;
    
    [self setupConstraints];
}

-(void) setupConstraints {
    
    [self addSubview: self.contentView];
    [self addSubview: self.imageView];
    [self addSubview: self.titleLabel];
    [self addSubview: self.nameLabel];
    [self addSubview: self.bioLabel];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-8);
        
        make.height.equalTo(self.imageView.mas_width);
        make.height.equalTo([NSNumber numberWithFloat:kProfileImageHeight]);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.bioLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-20);
    }];
    
}

-(CGFloat)headerImageOffset {
    return [self convertRect:self.imageView.frame toView:self.superview].origin.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //self.contentInset = UIEdgeInsetsMake(-self.contentOffset.y, 0, 0, 0);
    if(self.contentOffset.y >= 0 && self.contentOffset.y < kMaxInsetY) {
        //self.contentInset = UIEdgeInsetsMake(self.contentOffset.y, 0, 0, 0);
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(8 + self.contentOffset.y);
            make.height.equalTo([NSNumber numberWithFloat: (kProfileImageHeight - self.contentOffset.y)]);
        }];
    }
    
    NSLog(@"frameY: %f", [self convertRect:self.imageView.frame toView:self.superview].origin.y);
    CGFloat offsetY = [self headerImageOffset];
    if(offsetY < 0) {
        [self.profileScrollViewDelegate headerViewDidOffScreenWithOffset: offsetY inScrollView:self];
    } else {
        [self.profileScrollViewDelegate headerViewDidShowOnScreenWithOffset: offsetY inScrollView:self];
    }

    NSLog(@"offset: %f", self.contentOffset.y);
    NSLog(@"inset: %f", self.contentInset.top);
    NSLog(@"height: %f", self.contentSize.height);
}

-(void)updateConstraints {
    [super updateConstraints];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if(self.contentOffset.y >= 0  && self.contentOffset.y < kMaxInsetY) {
        self.imageView.layer.cornerRadius = (kProfileImageHeight - self.contentOffset.y) / 2;
    } else {
        if(self.contentOffset.y > 0) {
            self.imageView.layer.cornerRadius = kMaxInsetY/2;
        } else {
            self.imageView.layer.cornerRadius = kProfileImageHeight/2;
        }
    }
    self.imageView.clipsToBounds = YES;
}

+(BOOL) requiresConstraintBasedLayout
{
    return YES;
}

@end
