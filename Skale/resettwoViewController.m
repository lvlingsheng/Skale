//
//  resettwoViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/11/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "resettwoViewController.h"
#import "resetoneViewController.h"
#import "resetthreeViewController.h"
#import "resetviewViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DGActivityIndicatorView.h"
#import "myTableViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
#import "FirstViewController.h"
@interface resettwoViewController ()

@end

@implementation resettwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    UIButton *iconnetweight = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconnetweight setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-80, 160, 40)];
    [iconnetweight setTitle:[NSString stringWithFormat:@"%@ Cancel",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [iconnetweight bs_configureAsWarningStyle];
    [iconnetweight.titleLabel setFont:font];
    [self.view addSubview:iconnetweight];
    [iconnetweight addTarget:self action:@selector(cancelreset)forControlEvents: UIControlEventTouchDown];
}
- (IBAction)confirmweight:(id)sender {
    
    [self.weightinput resignFirstResponder];
    [NSCharacterSet decimalDigitCharacterSet];
    
    
    //NSString *string = @“123456”;
    NSString *inputstring=self.weightinput.text;
    NSString *string = [self.weightinput.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        NSLog(@"不是数字");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Wrong Info" message:@"The info you typed in is not a number" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Re-enter" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"是数字");
        [[NSUserDefaults standardUserDefaults] setFloat:[inputstring floatValue] forKey:@"inputnumber"];
        NSLog(@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:@"inputnumber"]);
        resetthreeViewController *resetthreecontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"resetthreeview"];
        //SecondViewController *secondViewController =
        //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
        [self presentViewController:resetthreecontroller animated:NO completion:nil];
        
    }

}

- (void) cancelreset{
    FirstViewController *firstviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"firstview"];
    //SecondViewController *secondViewController =
    //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
    [self presentViewController:firstviewcontroller animated:YES completion:nil];
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
