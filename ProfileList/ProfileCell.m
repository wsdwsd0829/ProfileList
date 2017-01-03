//
//  ProfileCell.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ProfileCell.h"
#import "Masonry.h"
#import "UILabel+Convenient.h"

NSString* const kProfileCellId = @"ProfileCell";

@interface ProfileCell()
@property BOOL isHeightCalculated;
@end

@implementation ProfileCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isHeightCalculated = NO;
        [self setupViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    //nameLabel
    UILabel* nameLabel = [UILabel labelWithMultiline];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;

    //titleLabel
    UILabel* titleLabel = [UILabel labelWithMultiline];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;

    UIImage* image = [UIImage imageNamed:@"person-placeholder"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage: image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.bounds = CGRectInset(self.imageView.frame, 10, 10);
    self.imageView = imageView;
    [self setupConstraints];
}

-(void) setupConstraints {
    [self.contentView addSubview: self.imageView];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.nameLabel];
    
    float labeloffset = 0;
    UIEdgeInsets labelPadding = UIEdgeInsetsMake(0, labeloffset, 0, -labeloffset);
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-8);
        //make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(self.imageView.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView).with.insets(labelPadding);
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);//.with.offset(8);
        //make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


-(void)updateConstraints {
    [super updateConstraints];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = (self.contentView.bounds.size.width-16) / 2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 3.0f;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    //self.isHeightCalculated = NO;
}

+(BOOL) requiresConstraintBasedLayout
{
    return YES;
}
@end
