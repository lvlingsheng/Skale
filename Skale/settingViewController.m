//
//  settingViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/11/24.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "settingViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
#import "FirstViewController.h"
#import "LLBootstrap.h"
#import "aboutViewController.h"
@interface settingViewController ()<menuDidSelectedDelegate>

@end

@implementation settingViewController{
    KYGooeyMenu *gooeyMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-25, CGRectGetMaxY(self.view.frame)-75) andDiameter:50.0f andSuperView:self.view themeColor:[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;     //这里把小圆半径设为大圆的1/4
    gooeyMenu.extraDistance = 20; //间距设为R+r+20。注：R+r是默认存在的。
    gooeyMenu.MenuCount = 2;      //4个子菜单
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:
                                 [UIImage imageNamed:@"setting"],
                                 [UIImage imageNamed:@"scaling"],
                                 nil];
    
    
    UIFont *font = [UIFont bs_awesomeFontOfSize:17.f];
    UIButton *unitchoose = [UIButton buttonWithType:UIButtonTypeCustom];
    [unitchoose setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, 160, 160, 50)];
    [unitchoose setTitle:[NSString stringWithFormat:@"%@ Net weight",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [unitchoose bs_configureAsPrimaryStyle];
    [unitchoose.titleLabel setFont:font];
    [self.view addSubview:unitchoose];
    [unitchoose addTarget:self action:@selector(unitchoose) forControlEvents: UIControlEventTouchDown];
    
    UIButton *resetbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetbut setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, 80, 160, 50)];
    [resetbut setTitle:[NSString stringWithFormat:@"%@ Reset",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [resetbut bs_configureAsInfoStyle];
    [resetbut.titleLabel setFont:font];
    [self.view addSubview:resetbut];
    [resetbut addTarget:self action:@selector(unitchoose) forControlEvents: UIControlEventTouchDown];
    
    UIButton *aboutbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [aboutbut setFrame:CGRectMake(CGRectGetMidX(self.view.frame)-80, 80, 160, 50)];
    [aboutbut setTitle:[NSString stringWithFormat:@"%@ About",@"fa-undo".bs_awesomeIconRepresentation] forState:UIControlStateNormal];
    [aboutbut bs_configureAsInfoStyle];
    [aboutbut.titleLabel setFont:font];
    [self.view addSubview:aboutbut];
    [aboutbut addTarget:self action:@selector(aboutpage) forControlEvents: UIControlEventTouchDown];
}

-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
    if(index==2){
        
        
        FirstViewController *firstviewcontroller =
        [self.storyboard instantiateViewControllerWithIdentifier:@"firstview"];
        [self presentViewController:firstviewcontroller animated:NO completion:nil];
        
    }
}

-(void) unitchoose{
    UICustomActionSheet* actionSheet = [[UICustomActionSheet alloc] initWithTitle:@"Choose Unit" delegate:nil buttonTitles:@[@"Cancel",@"Gram",@"Ounce"]];
    
    [actionSheet setButtonColors:@[[UIColor redColor]]];
    [actionSheet setBackgroundColor:[UIColor clearColor]];
    
    //        [actionSheet setSubtitle:@"Choose the unit your want use"];
    //        [actionSheet setSubtitleColor:[UIColor whiteColor]];
    
    //[actionSheet showInView:self.view];
    [actionSheet setTintColor:[UIColor colorWithRed:0.20 green:0.80 blue:0.40 alpha:1]];
    [actionSheet setTitleColor:[UIColor whiteColor]];
    [actionSheet setBlurTintColor:[UIColor colorWithWhite:0.5 alpha:0.4]];
    [actionSheet showInView:[self.view window]];
}

-(void) aboutpage{
    aboutViewController *aboutpage=[self.storyboard instantiateViewControllerWithIdentifier:@"aboutview"];
    [self presentViewController:aboutpage animated:YES completion:nil];
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
