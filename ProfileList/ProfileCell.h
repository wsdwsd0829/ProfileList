//
//  ProfileCell.h
//  ProfileList
//
//  Created by Sida Wang on 12/31/16.
//  Copyright © 2016 Sida Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const kProfileCellId;

@interface ProfileCell : UICollectionViewCell
//??? should this be weak like nibs, I think not needed;
@property (nonatomic) UILabel* nameLabel;
@property (nonatomic) UILabel* titleLabel;

@property (nonatomic) UIImageView* imageView;

@end
