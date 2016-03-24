//
//  resetthreeViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/11/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "resetthreeViewController.h"
#import "resettwoViewController.h"
#import "resetoneViewController.h"
#import "resetviewViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DGActivityIndicatorView.h"
#import "myTableViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
#import "FirstViewController.h"

@interface resetthreeViewController ()

@end

@implementation resetthreeViewController
@synthesize scaleweight;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor colorWithRed:0.95 green:0.40 blue:0.30 alpha:1.0]];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    activityIndicatorView.frame = CGRectMake(5*width/12, 3*height/12, width/6, height/6);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    UIButton *iconnetweight = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconnetweight setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-80, 160, 40)];
    [iconnetweight setTitle:[NSString stringWithFormat:@"%@ Cancel",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [iconnetweight bs_configureAsWarningStyle];
    [iconnetweight.titleLabel setFont:font];
    [self.view addSubview:iconnetweight];
    [iconnetweight addTarget:self action:@selector(cancelreset)forControlEvents: UIControlEventTouchDown];

    firstdone = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstdone setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-90, CGRectGetMaxY(self.view.frame)-140, 180, 40)];
    [firstdone setTitle:[NSString stringWithFormat:@"%@ put first quarter",@"fa-check-square".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [firstdone bs_configureAsPrimaryStyle];
    [firstdone.titleLabel setFont:font];
    [self.view addSubview:firstdone];
    [firstdone addTarget:self action:@selector(firstquarter)forControlEvents: UIControlEventTouchDown];

//    UIButton *seconddone = [UIButton buttonWithType:UIButtonTypeCustom];
//    [seconddone setFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-180, CGRectGetMaxY(self.view.frame)-140, 150, 40)];
//    [seconddone setTitle:[NSString stringWithFormat:@"%@ put first quarter",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
//    [seconddone bs_configureAsPrimaryStyle];
//    [seconddone.titleLabel setFont:font];
//    [self.view addSubview:seconddone];
//    [seconddone addTarget:self action:@selector(secondquarter)forControlEvents: UIControlEventTouchDown];
    
    
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
    //int count=0;
       // Do any additional setup after loading the view.
}


-(void) firstquarter{
    firstdone.hidden=YES;
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    
    afterfirst=[self.weightlabel.text floatValue];
    
    seconddone = [UIButton buttonWithType:UIButtonTypeCustom];
    [seconddone setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-90, CGRectGetMaxY(self.view.frame)-140, 180, 40)];
    [seconddone setTitle:[NSString stringWithFormat:@"%@ put second quarter",@"fa-check-square".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [seconddone bs_configureAsPrimaryStyle];
    [seconddone.titleLabel setFont:font];
    [self.view addSubview:seconddone];
    [seconddone addTarget:self action:@selector(secondquarter)forControlEvents: UIControlEventTouchDown];

    
}

-(void) secondquarter{
    seconddone.hidden=YES;
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    
    
    aftersecond=[self.weightlabel.text floatValue];
    
    thirddone = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirddone setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-90, CGRectGetMaxY(self.view.frame)-140, 180, 40)];
    [thirddone setTitle:[NSString stringWithFormat:@"%@ put third quarter",@"fa-check-square".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [thirddone bs_configureAsPrimaryStyle];
    [thirddone.titleLabel setFont:font];
    [self.view addSubview:thirddone];
    [thirddone addTarget:self action:@selector(thirdquarter)forControlEvents: UIControlEventTouchDown];

}


-(void) thirdquarter{
    afterthird=[self.weightlabel.text floatValue];
    thirddone.hidden=YES;
    
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    fourthdone = [UIButton buttonWithType:UIButtonTypeCustom];
    [fourthdone setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-90, CGRectGetMaxY(self.view.frame)-140, 180, 40)];
    [fourthdone setTitle:[NSString stringWithFormat:@"%@ put fourth quarter",@"fa-check-square".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [fourthdone bs_configureAsPrimaryStyle];
    [fourthdone.titleLabel setFont:font];
    [self.view addSubview:fourthdone];
    [fourthdone addTarget:self action:@selector(fourthquarter)forControlEvents: UIControlEventTouchDown];
}

-(void) fourthquarter{
    afterfourth=[self.weightlabel.text floatValue];
    
    secondquarter=aftersecond-afterfirst;
    thirdquarter=afterthird-aftersecond;
    fourthquarter=afterfourth-afterthird;
    
    
    
    [[NSUserDefaults standardUserDefaults] setFloat:(fourthquarter+thirdquarter)/2 forKey:@"standardweight"];
    [self confirmweight];
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //for(int i=0;i<6;i++){
    for (UITouch *userTouch in touches) {
        
        if(i==4){
            i=0;
        }
        
        if(self.scaleweight==TRUE){
            if(CACurrentMediaTime()-starttime>0.1){
                starttime = CACurrentMediaTime();
                self.weightlabel.text=[[NSString alloc] initWithFormat:@"%f",userTouch.force];


                [weighttemp replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:userTouch.force]];
                NSLog(@"0 %f",[[weighttemp objectAtIndex:0] floatValue]);
                NSLog(@"1 %f",[[weighttemp objectAtIndex:1] floatValue]);
                NSLog(@"2 %f",[[weighttemp objectAtIndex:2] floatValue]);
                
                
                if([[weighttemp objectAtIndex:0] floatValue]==[[weighttemp objectAtIndex:1] floatValue] &&
                   [[weighttemp objectAtIndex:1] floatValue]==[[weighttemp objectAtIndex:2] floatValue]  ){
//                    [[NSUserDefaults standardUserDefaults] setFloat:[[weighttemp objectAtIndex:0] floatValue] forKey:@"standardweight"];
//                    [self confirmweight];
//                    //self.scaleweight=FALSE;
//                    break;
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
    float scaleunit=5.67/[[NSUserDefaults standardUserDefaults] floatForKey:@"standardweight"];
    NSLog(@"%f",scaleunit);
    [[NSUserDefaults standardUserDefaults] setFloat:scaleunit forKey:@"scaleunit"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Done" message:@"Reset is done" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        FirstViewController *firstviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"firstview"];
        //SecondViewController *secondViewController =
        //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
        [self presentViewController:firstviewcontroller animated:YES completion:nil];
    }];
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
