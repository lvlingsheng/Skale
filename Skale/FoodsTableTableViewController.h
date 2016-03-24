//
//  FoodsTableTableViewController.h
//  database
//
//  Created by Labuser on 11/25/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FoodsTableTableViewController : UIViewController <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *cellContent;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *calories;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebutton;
extern float weight;
@end
