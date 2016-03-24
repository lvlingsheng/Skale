//
//  resetoneViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/11/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "resetoneViewController.h"
#import "resettwoViewController.h"
#import "resetviewViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DGActivityIndicatorView.h"
#import "myTableViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
#import "FirstViewController.h"
#import "resetthreeViewController.h"
@interface resetoneViewController ()

@end

@implementation resetoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    UIButton *iconnetweight = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconnetweight setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-80, 160, 40)];
    [iconnetweight setTitle:[NSString stringWithFormat:@"%@ Cancel",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [iconnetweight bs_configureAsWarningStyle];
    [iconnetweight.titleLabel setFont:font];
    [self.view addSubview:iconnetweight];
    [iconnetweight addTarget:self action:@selector(cancelreset)forControlEvents: UIControlEventTouchDown];
    
    // Do any additional setup after loading the view.
    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    motionManager.deviceMotionUpdateInterval = 0.1; // 告诉manager，更新频率是100Hz
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *devMotion, NSError *error){
        double gravityX = motionManager.deviceMotion.gravity.x;
        double gravityY = motionManager.deviceMotion.gravity.y;
        double gravityZ = motionManager.deviceMotion.gravity.z;
        double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
        
        NSLog(@"%f",zTheta);
        float angel=zTheta+90;
        NSString *stringFloat = [NSString stringWithFormat:@"%f",angel];
        self.angellabel.text=stringFloat;
        if(-90<zTheta && zTheta<-88){
            [motionManager stopDeviceMotionUpdates];
            resetthreeViewController *resetthreecontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"resetthreeview"];
            //SecondViewController *secondViewController =
            //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
            [self presentViewController:resetthreecontroller animated:YES completion:nil];
        }
    }]; // 开始更新，后台线程开始运行。

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
