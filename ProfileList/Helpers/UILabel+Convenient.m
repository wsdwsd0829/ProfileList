//
//  UILabel+Convenient.m
//  ProfileList
//
//  Created by Sida Wang on 1/2/17.
//  Copyright © 2017 Sida Wang. All rights reserved.
//

#import "UILabel+Convenient.h"

@implementation UILabel (Convenient)
+(UILabel *) labelWithMultiline {
    UILabel* label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    //self.nameLabel.preferredMaxLayoutWidth = ([UIScreen mainScreen].bounds.size.width-40)/2; //if not using self sizing cells
    return label;
}

@end
