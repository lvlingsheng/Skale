//
//  resetthreeViewController.h
//  Skale
//
//  Created by 吕凌晟 on 15/11/28.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resetthreeViewController : UIViewController{

    int i;
    NSMutableArray *weighttemp;
    //BOOL scaleweight;
    CFTimeInterval starttime;
    float afterfirst;
    float aftersecond;
    float afterthird;
    float afterfourth;
    float firstquarter;
    float secondquarter;
    float thirdquarter;
    float fourthquarter;
    UIButton *firstdone;
    UIButton *seconddone;
    UIButton *thirddone;
    UIButton *fourthdone;
}
@property (weak, nonatomic) IBOutlet UILabel *weightlabel;
@property (weak, nonatomic) IBOutlet UILabel *weightfinallabel;
@property BOOL scaleweight;
@end
