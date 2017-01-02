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
    [self.contentView addSubview: self.nameLabel];
    [self.contentView addSubview: self.imageView];
//    [self.contentView addSubview: self.bioLabel];
//    [self.contentView addSubview: self.titleLabel];
//
   
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        //make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(self.contentView.mas_width);
    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.contentView);
//        make.top.equalTo(self.imageView).with.offset(8);
//    }];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).with.priority(1000);//.with.offset(8);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
//    [self.bioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.and.bottom.equalTo(self.contentView);
//        make.top.equalTo(self.nameLabel).with.offset(8);
//    }];
//
    
//    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView).with.insets(padding);
//    }];
    
    
}


-(void)updateConstraints {
//    for (UIView *view in self.contentView.subviews)
//    {
//        NSArray *constraints = [self.contentView constraintsReferencingView:view];
//        for (NSLayoutConstraint *constraint in constraints)
//            [constraint remove];
//    }
    for(id constraint in self.contentView.constraints) {
//        if([constraint isKindOfClass: [NSAutoresizingMaskLayoutConstraint class]]) {
//            
//        }
    }
    [super updateConstraints];
}

-(void)layoutSubviews {
    [super layoutSubviews];
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
    aSize.width = ([UIScreen mainScreen].bounds.size.width-40)/2;

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
