//
//  FirstViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/10/28.
//  Copyright (c) 2015年 Lingsheng Lyu. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
#import "DGActivityIndicatorView.h"
#import "myTableViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "resetviewViewController.h"
#import "resetoneViewController.h"

#import "LLBootstrap.h"
@interface FirstViewController () <UICustomActionSheetDelegate,menuDidSelectedDelegate>

@end

@implementation FirstViewController{
    KYGooeyMenu *gooeyMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"unit"];
    currentweight=0;
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
//    UIButton *iconSuccess = [UIButton buttonWithType:UIButtonTypeCustom];
//    [iconSuccess setFrame:CGRectMake(20, CGRectGetMaxY(self.view.frame)-70, 130, 45)];
//    [iconSuccess setTitle:[NSString stringWithFormat:@"%@ Calorie",@"fa-bar-chart-o".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
//    [iconSuccess bs_configureAsSuccessStyle];
//    [iconSuccess.titleLabel setFont:font];
//    [self.view addSubview:iconSuccess];
    
    UIButton *iconnetweight = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconnetweight setFrame:CGRectMake(CGRectGetMaxX(self.view.frame)-150, CGRectGetMaxY(self.view.frame)-70, 130, 50)];
    [iconnetweight setTitle:[NSString stringWithFormat:@"%@ zero",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [iconnetweight bs_configureAsWarningStyle];
    [iconnetweight.titleLabel setFont:font];
    [self.view addSubview:iconnetweight];
    [iconnetweight addTarget:self action:@selector(zerofun)forControlEvents: UIControlEventTouchDown];
    
    UIButton *resetzero = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetzero setFrame:CGRectMake(20, CGRectGetMaxY(self.view.frame)-70, 130, 50)];
    [resetzero setTitle:[NSString stringWithFormat:@"%@ reset",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [resetzero bs_configureAsPrimaryStyle];
    [resetzero.titleLabel setFont:font];
    [self.view addSubview:resetzero];
    [resetzero addTarget:self action:@selector(resetzero)forControlEvents: UIControlEventTouchDown];
    
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-25, CGRectGetMaxY(self.view.frame)-70) andDiameter:50.0f andSuperView:self.view themeColor:[UIColor colorWithRed:1.00 green:0.40 blue:0.40 alpha:1.0]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;     //这里把小圆半径设为大圆的1/4
    gooeyMenu.extraDistance = 20; //间距设为R+r+20。注：R+r是默认存在的。
    gooeyMenu.MenuCount = 3;      //4个子菜单
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:
                                 [UIImage imageNamed:@"unit"],
                                 [UIImage imageNamed:@"calibe"],
                                 [UIImage imageNamed:@"cal"],
                                  nil];
    
    //UICustomActionSheet*
    actionSheet = [[UICustomActionSheet alloc] initWithTitle:@"Choose Unit" delegate:nil buttonTitles:@[@"Cancel",@"Gram",@"Ounce"]];
    [actionSheet setButtonColors:@[[UIColor redColor]]];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    actionSheet.delegate=self;
    
    //        [actionSheet setSubtitle:@"Choose the unit your want use"];
    //        [actionSheet setSubtitleColor:[UIColor whiteColor]];
    
    //[actionSheet showInView:self.view];
    [actionSheet setTintColor:[UIColor colorWithRed:0.20 green:0.80 blue:0.40 alpha:1]];
    [actionSheet setTitleColor:[UIColor whiteColor]];
    [actionSheet setBlurTintColor:[UIColor colorWithWhite:0.5 alpha:0.4]];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
    if(index==1){
        


        [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(showsetting) userInfo:nil repeats:NO];


    }
    if(index==2){

        actionSheet = [[UICustomActionSheet alloc] initWithTitle:@"Choose Unit" delegate:nil buttonTitles:@[@"Cancel",@"Gram",@"Ounce"]];
        [actionSheet setButtonColors:@[[UIColor redColor]]];
        [actionSheet setBackgroundColor:[UIColor clearColor]];
        actionSheet.delegate=self;
        
        //        [actionSheet setSubtitle:@"Choose the unit your want use"];
        //        [actionSheet setSubtitleColor:[UIColor whiteColor]];
        
        //[actionSheet showInView:self.view];
        [actionSheet setTintColor:[UIColor colorWithRed:0.20 green:0.80 blue:0.40 alpha:1]];
        [actionSheet setTitleColor:[UIColor whiteColor]];
        [actionSheet setBlurTintColor:[UIColor colorWithWhite:0.5 alpha:0.4]];
        [actionSheet showInView:[self.view window]];
        

    }
    
    if(index==3){
        UIStoryboard *story_first = [UIStoryboard storyboardWithName:@"database" bundle:nil];
        resetoneViewController *databaseinitial=[story_first instantiateViewControllerWithIdentifier:@"databaseinitial"];
        //SecondViewController *secondViewController =
        //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
        [self presentViewController:databaseinitial animated:YES completion:nil];
    }
}

-(void)customActionSheet:(UICustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"unit"]==2){
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"unit"];
            self.unitlabel.text=@"gram";
            //[[NSUserDefaults standardUserDefaults] setFloat:<#(float)#> forKey:<#(nonnull NSString *)#>];
            perweight=[[NSUserDefaults standardUserDefaults] floatForKey:@"scaleunit"];
            perweight=perweight*28.3495231;
            [[NSUserDefaults standardUserDefaults] setFloat:perweight forKey:@"scaleunit"];
            
            float temp=[self.weightshow.text floatValue];
            temp=temp*28.3495231;
            currentweight=currentweight*28.3495231;
            NSString* format = [NSString stringWithFormat:@"%%.%df",2];
            
            
            
            NSString* resultStr = [NSString stringWithFormat:format,temp];
            
            self.weightshow.text=resultStr;
        }
    }
    if(buttonIndex==2){
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"unit"]==1){

            [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"unit"];
            self.unitlabel.text=@"ounce";
            perweight=[[NSUserDefaults standardUserDefaults] floatForKey:@"scaleunit"];
            perweight=perweight/28.3495231;
            [[NSUserDefaults standardUserDefaults] setFloat:perweight forKey:@"scaleunit"];
            
            float temp=[self.weightshow.text floatValue];
            temp=temp/28.3495231;
            currentweight=currentweight/28.3495231;
            NSString* format = [NSString stringWithFormat:@"%%.%df",2];
            
            
            
            NSString* resultStr = [NSString stringWithFormat:format,temp];

            self.weightshow.text=resultStr;
        }
    }
}

-(void)zerofun{
    currentweight=[self.weightshow.text floatValue];
    self.weightshow.text=@"0";

}

-(void)resetzero{
    currentweight=0;
}

-(void)showsetting{
//    resetviewViewController *resetviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"resetview"];
//    //SecondViewController *secondViewController =
//    //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
//    [self presentViewController:resetviewcontroller animated:NO completion:nil];
    
    resetoneViewController *resetoneviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"resetoneview"];
    //SecondViewController *secondViewController =
    //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
    [self presentViewController:resetoneviewcontroller animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        [self resetscale];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        // Do any additional setup after loading the view, typically from a nib.
    }
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
    perweight=[[NSUserDefaults standardUserDefaults] floatForKey:@"scaleunit"];
    NSLog(@"%f",perweight);
    
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor colorWithRed:0.95 green:0.40 blue:0.30 alpha:1.0]];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    activityIndicatorView.frame = CGRectMake(5*width/12, 3*height/12, width/6, height/6);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void) resetscale{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Calibration"message:@"First Time use application, Please do caliberation"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        resetoneViewController *resetviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"resetoneview"];
        //SecondViewController *secondViewController =
        //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
        [self presentViewController:resetviewcontroller animated:YES completion:nil];
    }];

    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    //[alert addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
                
                
                NSString* format = [NSString stringWithFormat:@"%%.%df",2];
                
                
                
                NSString* resultStr = [NSString stringWithFormat:format,userTouch.force*perweight-currentweight];
                float weight = userTouch.force*perweight-currentweight;
                //self.weightshow.text=[[NSString alloc] initWithFormat:@"%f",weight];
                [[NSUserDefaults standardUserDefaults] setFloat:weight forKey:@"caluse"];
                self.weightshow.text=resultStr;
                [weighttemp replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:weight]];
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
                    [[NSUserDefaults standardUserDefaults] setFloat:[[weighttemp objectAtIndex:0] floatValue] forKey:@"displayweight"];
                    [self displayweight];
                    //self.scaleweight=FALSE;
                    break;
                }
                i=i+1;
                
            }
        }
        //}
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayweight{

    

    
    NSString* format = [NSString stringWithFormat:@"%%.%df",2];
    
    
    
    NSString* resultStr = [NSString stringWithFormat:format,[[weighttemp objectAtIndex:0] floatValue]];
    self.weightshow.text=resultStr;
    NSLog(@"success");
}


@end
