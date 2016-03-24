//
//  SecondViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/10/28.
//  Copyright (c) 2015年 Lingsheng Lyu. All rights reserved.
//

#import "SecondViewController.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"
@interface SecondViewController ()

@end

@implementation SecondViewController{

KYGooeyMenu *gooeyMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-25, CGRectGetMaxY(self.view.frame)-75) andDiameter:50.0f andSuperView:self.view themeColor:[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;     //这里把小圆半径设为大圆的1/4
    gooeyMenu.extraDistance = 20; //间距设为R+r+20。注：R+r是默认存在的。
    gooeyMenu.MenuCount = 3;      //4个子菜单
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:
                                 [UIImage imageNamed:@"setting"],
                                 [UIImage imageNamed:@"plus.png"],
                                 [UIImage imageNamed:@"scaling"],
                                 nil];
    
}


-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
    if(index==1){
        
        SecondViewController *secondViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"settingcontroller"];
        [self presentViewController:secondViewController animated:YES completion:nil];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
