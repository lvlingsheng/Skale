//
//  FoodTableViewCell.h
//  database
//
//  Created by Labuser on 11/25/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tableLabel;

@property(nonatomic) NSInteger calories;

@end
