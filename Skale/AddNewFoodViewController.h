//
//  AddNewFoodViewController.h
//  database
//
//  Created by Labuser on 11/28/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface AddNewFoodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *foodName;
@property (weak, nonatomic) IBOutlet UITextField *calories;
@property (weak, nonatomic) IBOutlet UIButton *addFoodButton;


@end
