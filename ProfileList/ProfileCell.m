//
//  ProfileCell.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ProfileCell.h"
#import "Masonry.h"
#import "YBTopAlignedCollectionViewFlowLayout.h"
#import "Utility.h"
#import "UILabel+Convenient.h"

NSString* const kProfileCellId = @"ProfileCell";

@interface ProfileCell()
@property BOOL isHeightCalculated;

//@property (nonatomic, strong) MASConstraint *widthConstraint;

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
    self.nameLabel = nameLabel;
    
    //bioLabel
    UILabel* bioLabel = [UILabel labelWithMultiline];
    self.bioLabel = bioLabel;
    
    //bioLabel
    UILabel* titleLabel = [UILabel labelWithMultiline];
    self.titleLabel = titleLabel;

    UIImage* image = [UIImage imageNamed:@"person-placeholder"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage: image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView = imageView;
    self.imageView.bounds = CGRectInset(self.imageView.frame, 10, 10);
    [self setupConstraints];
    /*
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints: NO];

    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem: self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem: self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem: self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem: self.nameLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.contentView addConstraints: @[top, left, right, bottom]];
    */
}
-(void) setupConstraints {
    [self.contentView addSubview: self.imageView];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.nameLabel];
    
    float labeloffset = 0;
    float imgOffset = 10;
    UIEdgeInsets imagePadding = UIEdgeInsetsMake(imgOffset, imgOffset, -imgOffset, -imgOffset);
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
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


-(void)updateConstraints {
    [super updateConstraints];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.width / 2;
    self.imageView.clipsToBounds = YES;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    //self.isHeightCalculated = NO;
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    layoutAttributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    if(self.isHeightCalculated) {
//        return layoutAttributes;
//    }
//    self.isHeightCalculated = YES;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    //!!! not needed
    //self.translatesAutoresizingMaskIntoConstraints = NO;
    //self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    CGSize aSize = layoutAttributes.size;
    aSize.width = ([UIScreen mainScreen].bounds.size.width-30)/2;

    for(NSLayoutConstraint* constraint in self.constraints) {
        if(constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = aSize.width;
        }
    }
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:aSize];
    CGRect newFrame = layoutAttributes.frame;

    newFrame.size.height = size.height;
    newFrame.size.width = aSize.width;
    
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}

+(BOOL) requiresConstraintBasedLayout
{
    return YES;
}
@end
