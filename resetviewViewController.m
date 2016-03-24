//
//  resetviewViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/10/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "resetviewViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DGActivityIndicatorView.h"
#import "myTableViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
#import "FirstViewController.h"
@import UIKit;
@interface resetviewViewController ()

@end

@implementation resetviewViewController

@synthesize scaleweight;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.weightfinallabel.hidden=YES;
    self.weightlabel.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.weightinput resignFirstResponder];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

-(void) viewDidAppear:(BOOL)animated{
    self.weightfinallabel.hidden=YES;
    self.weightlabel.hidden=YES;
    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    motionManager.deviceMotionUpdateInterval = 0.1; // 告诉manager，更新频率是100Hz
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *devMotion, NSError *error){
        double gravityX = motionManager.deviceMotion.gravity.x;
        double gravityY = motionManager.deviceMotion.gravity.y;
        double gravityZ = motionManager.deviceMotion.gravity.z;
        double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
        
        NSLog(@"%f",zTheta);
        if(-90<zTheta && zTheta<-89){
            [motionManager stopDeviceMotionUpdates];
            [self setbasevalue];
        }
    }]; // 开始更新，后台线程开始运行。
    //CMAccelerometerData *newestAccel = motionManager.accelerometerData;
    //double accelerationX = newestAccel.acceleration.x;
    //double accelerationY = newestAccel.acceleration.y;
    //double accelerationZ = newestAccel.acceleration.z;
    
    /*double gravityX = motionManager.deviceMotion.gravity.x;
    double gravityY = motionManager.deviceMotion.gravity.y;
    double gravityZ = motionManager.deviceMotion.gravity.z;
    
    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
    NSLog(@"%f",zTheta);
    if(zTheta<=1){
        self.hitone.hidden=YES;
        self.hittwo.hidden=NO;
        self.weightinput.hidden=NO;
        self.unitchoose.hidden=NO;
        self.unittext.hidden=NO;
    }*/
    
    weighttemp= [[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 [NSNumber numberWithFloat:0.0f],
                 nil];
    self.scaleweight=true;
    starttime=CACurrentMediaTime();
    i=0;
    
    
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    UIButton *iconnetweight = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconnetweight setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-80, 160, 40)];
    [iconnetweight setTitle:[NSString stringWithFormat:@"%@ Cancel",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [iconnetweight bs_configureAsWarningStyle];
    [iconnetweight.titleLabel setFont:font];
    [self.view addSubview:iconnetweight];
    [iconnetweight addTarget:self action:@selector(cancelreset)forControlEvents: UIControlEventTouchDown];

}


- (void) cancelreset{
    FirstViewController *firstviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"firstview"];
    //SecondViewController *secondViewController =
    //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
    [self presentViewController:firstviewcontroller animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self putthingon];

    }
}

-(void) setbasevalue{
    //self.hitone.hidden=YES;
    self.hittwo.hidden=NO;
    self.weightinput.hidden=NO;
    self.unitchoose.hidden=NO;
    self.unittext.hidden=NO;
    self.enterbutton.hidden=NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    self.hitone.alpha =0.0;
    [UIView commitAnimations];

    //[NSThread sleepForTimeInterval:0.5];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    //self.hitone.alpha =0.0;
    self.hittwo.alpha =1;
    self.weightinput.alpha=1;
    self.unitchoose.alpha=1;
    self.unittext.alpha=1;
    self.enterbutton.alpha=1;
    [UIView commitAnimations];
}

-(void) putthingon{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    self.hittwo.alpha =0.0;
    self.weightinput.alpha=0.0;
    self.unitchoose.alpha =0.0;
    self.unittext.alpha=0.0;
    self.enterbutton.alpha=0.0;
    [UIView commitAnimations];
    
    
    
    self.hittwo.hidden=YES;
    self.weightinput.hidden=YES;
    self.unitchoose.hidden=YES;
    self.unittext.hidden=YES;
    self.enterbutton.hidden=YES;
    
    
    self.finalhit.hidden=FALSE;
    self.weightlabel.hidden=FALSE;
    self.unitlabel.hidden=FALSE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    //self.hitone.alpha =0.0;
    self.finalhit.alpha =1;
    self.weightlabel.alpha=1;
    self.unitlabel.alpha=1;
    [UIView commitAnimations];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //for(int i=0;i<6;i++){
    for (UITouch *userTouch in touches) {
        
        if(i==6){
            i=0;
        }
        
        if(self.scaleweight==TRUE){
            if(CACurrentMediaTime()-starttime>0.2){
                starttime = CACurrentMediaTime();
                self.weightlabel.text=[[NSString alloc] initWithFormat:@"%f",userTouch.force];
                [weighttemp replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:userTouch.force]];
                NSLog(@"0 %f",[[weighttemp objectAtIndex:0] floatValue]);
                NSLog(@"1 %f",[[weighttemp objectAtIndex:1] floatValue]);
                NSLog(@"2 %f",[[weighttemp objectAtIndex:2] floatValue]);
                NSLog(@"3 %f",[[weighttemp objectAtIndex:3] floatValue]);
                NSLog(@"4 %f",[[weighttemp objectAtIndex:4] floatValue]);
                NSLog(@"5 %f",[[weighttemp objectAtIndex:5] floatValue]);
                
                
                if([[weighttemp objectAtIndex:0] floatValue]==[[weighttemp objectAtIndex:1] floatValue] &&
                   [[weighttemp objectAtIndex:1] floatValue]==[[weighttemp objectAtIndex:2] floatValue] &&
                   [[weighttemp objectAtIndex:2] floatValue]==[[weighttemp objectAtIndex:3] floatValue] &&
                   [[weighttemp objectAtIndex:3] floatValue]==[[weighttemp objectAtIndex:4] floatValue] &&
                   [[weighttemp objectAtIndex:4] floatValue]==[[weighttemp objectAtIndex:5] floatValue] ){
                    [[NSUserDefaults standardUserDefaults] setFloat:[[weighttemp objectAtIndex:0] floatValue] forKey:@"standardweight"];
                    [self confirmweight];
                    //self.scaleweight=FALSE;
                    break;
                }
                i=i+1;
                
            }
        }
        //}
    }
}

-(void)confirmweight{
    self.weightfinallabel.text=[[NSString alloc] initWithFormat:@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:@"standardweight"]];
    self.weightlabel.hidden=YES;
    self.weightfinallabel.hidden=NO;
    float scaleunit=[[NSUserDefaults standardUserDefaults] floatForKey:@"inputnumber"]/[[NSUserDefaults standardUserDefaults] floatForKey:@"standardweight"];
    NSLog(@"%f",scaleunit);
    [[NSUserDefaults standardUserDefaults] setFloat:scaleunit forKey:@"scaleunit"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Done" message:@"Reset is done" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
