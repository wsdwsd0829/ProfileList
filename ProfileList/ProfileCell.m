//
//  ProfileCell.m
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import "ProfileCell.h"
#import "Masonry.h"

NSString* const kProfileCellId = @"ProfileCell";

@implementation ProfileCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    UILabel* label = [[UILabel alloc] init];
    [label setTranslatesAutoresizingMaskIntoConstraints: NO];
    self.nameLabel = label;
    [self addSubview:label];
    label.backgroundColor = [UIColor purpleColor];
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(padding);
    }];
}

-(void)updateConstraints {
    [super updateConstraints];
}

-(void)layoutSubviews {
    [super layoutSubviews];
}


@end
