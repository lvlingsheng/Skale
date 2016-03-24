//
//  resetviewViewController.h
//  Skale
//
//  Created by 吕凌晟 on 15/10/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>  
@interface resetviewViewController : UIViewController{
    int i;
    NSMutableArray *weighttemp;
    //BOOL scaleweight;
    CFTimeInterval starttime;
}
@property BOOL scaleweight;
@property (weak, nonatomic) IBOutlet UILabel *hitone;
@property (weak, nonatomic) IBOutlet UILabel *hitthree;
@property (weak, nonatomic) IBOutlet UILabel *hittwo;
@property (weak, nonatomic) IBOutlet UITextField *weightinput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitchoose;
@property (weak, nonatomic) IBOutlet UILabel *unittext;

@property (weak, nonatomic) IBOutlet UIButton *enterbutton;
@property (weak, nonatomic) IBOutlet UILabel *unitlabel;
@property (weak, nonatomic) IBOutlet UILabel *weightlabel;
@property (weak, nonatomic) IBOutlet UILabel *finalhit;
@property (weak, nonatomic) IBOutlet UILabel *weightfinallabel;

-(void) setbasevalue;
-(void) putthingon;
@end
