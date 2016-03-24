//
//  FoodTableViewCell.m
//  database
//
//  Created by Labuser on 11/25/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import "FoodTableViewCell.h"

@implementation FoodTableViewCell

@synthesize tableLabel = _tableLabel;
@synthesize calories = _calories;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
