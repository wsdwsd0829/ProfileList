//
//  ProfileScrollView.h
//  ProfileList
//
//  Created by Sida Wang on 1/2/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileScrollViewDelegate <NSObject>
-(void)headerViewDidOffScreenWithOffset:(CGFloat)offset inScrollView: (UIScrollView*)scrollView;
-(void)headerViewDidShowOnScreenWithOffset:(CGFloat)offset inScrollView: (UIScrollView*)scrollView;
@end

@interface ProfileScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic) UILabel* nameLabel;
@property (nonatomic) UILabel* bioLabel;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UIImageView* imageView;

@property (nonatomic) UIView* contentView;

@property (nonatomic, weak) id<ProfileScrollViewDelegate> profileScrollViewDelegate;

-(CGFloat)headerImageOffset;

@end
