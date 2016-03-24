//
//  AddNewFoodViewController.m
//  database
//
//  Created by Labuser on 11/28/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import "AddNewFoodViewController.h"

@interface AddNewFoodViewController ()

@end

@implementation AddNewFoodViewController

@synthesize foodName = _foodName;
@synthesize calories = _calories;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addFoodButtonCliked:(id)sender {
    NSString *upperCaseForFoodName = [_foodName.text uppercaseString];
    PFObject *food = [PFObject objectWithClassName:@"Foods"];
    food[@"calories"] =@([_calories.text integerValue]);
    food[@"foodName"] = upperCaseForFoodName;
    [food saveEventually];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
