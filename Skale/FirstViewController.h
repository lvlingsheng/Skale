//
//  FirstViewController.h
//  Skale
//
//  Created by 吕凌晟 on 15/10/28.
//  Copyright (c) 2015年 Lingsheng Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "UICustomActionSheet.h"
//#import "DGActivityIndicatorView/DGActivityIndicatorView.h"
@interface FirstViewController : UIViewController{
    UIAlertController *alert;
    NSMutableArray *weighttemp;
    CFTimeInterval starttime;
    int i;
    float perweight;
    UICustomActionSheet *actionSheet;
    float currentweight;
}

@property (weak, nonatomic) IBOutlet UILabel *weightshow;
@property (weak, nonatomic) IBOutlet UILabel *unitlabel;
@property BOOL scaleweight;

-(void) resetscale;

-(void) displayweight;
@end

