//
//  myTableViewController.m
//  Skale
//
//  Created by 吕凌晟 on 15/11/20.
//  Copyright © 2015年 Lingsheng Lyu. All rights reserved.
//

#import "myTableViewController.h"
#import "FirstViewController.h"
#import "UICustomActionSheet.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LLBootstrap.h"

@interface myTableViewController ()<menuDidSelectedDelegate>

@end

@implementation myTableViewController{
    KYGooeyMenu *gooeyMenu;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    gooeyMenu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.view.frame)-25, CGRectGetMaxY(self.view.frame)-75) andDiameter:50.0f andSuperView:self.view themeColor:[UIColor colorWithRed:0.20 green:0.60 blue:0.86 alpha:1.0]];
    gooeyMenu.menuDelegate = self;
    gooeyMenu.radius = 100/4;     //这里把小圆半径设为大圆的1/4
    gooeyMenu.extraDistance = 20; //间距设为R+r+20。注：R+r是默认存在的。
    gooeyMenu.MenuCount = 2;      //4个子菜单
    gooeyMenu.menuImagesArray = [NSMutableArray arrayWithObjects:
                                 [UIImage imageNamed:@"setting"],
                                 [UIImage imageNamed:@"unit"],
                                 [UIImage imageNamed:@"cal"],
                                 nil];
}

-(void)menuDidSelected:(int)index{
    NSLog(@"选中第%d",index);
    if(index==3){
        
        
        FirstViewController *firstviewcontroller =
        [self.storyboard instantiateViewControllerWithIdentifier:@"firstview"];
        [self presentViewController:firstviewcontroller animated:NO completion:nil];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rownum=indexPath.row;
    if(rownum==1){
        //self.hidesBottomBarWhenPushed=YES;
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
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    #warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
