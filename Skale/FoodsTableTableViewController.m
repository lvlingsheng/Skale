//
//  FoodsTableTableViewController.m
//  database
//
//  Created by Labuser on 11/25/15.
//  Copyright (c) 2015 Xuting. All rights reserved.
//

#import "FoodsTableTableViewController.h"
#import "FoodTableViewCell.h"
#import "FirstViewController.h"
#include <stdlib.h>

@interface FoodsTableTableViewController ()
{
    NSMutableArray *displayFoods;
}

@end

@implementation FoodsTableTableViewController

float weight;

@synthesize cellContent = _cellContent;
@synthesize searchBar = _searchBar;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    weight = [[NSUserDefaults standardUserDefaults] floatForKey:@"caluse"];
        
    CGRect barFrame = self.searchBar.frame;
    barFrame.size.width = self.view.frame.size.width;
    self.searchBar.frame = barFrame;
    
    CGRect frameOfTable = CGRectMake(0, 0, self.view.frame.size.width-10, 450);
    self.tableView.frame = frameOfTable;
//    [self.tableView setContentInset:UIEdgeInsetsMake(-65,0,0,0)];
//    
//    CGRect tableFrame = self.tableView.frame;
//    tableFrame.size.width = self.view.bounds.size.width;
//    
//    self.tableView.frame = tableFrame;
    
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    
}
- (IBAction)donecal:(id)sender {
    UIStoryboard *story_first = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FirstViewController *firstviewcontroller=[story_first instantiateViewControllerWithIdentifier:@"firstview"];
    //SecondViewController *secondViewController =
    //[self.storyboard instantiateViewControllerWithIdentifier:@"settingview"];
    [self presentViewController:firstviewcontroller animated:YES completion:nil];
    
}

-(void) fetchFoodsFromDatabase:(NSString *)searchText{
    NSString *upperCaseSearchText = [searchText uppercaseString];
    NSArray *components = [upperCaseSearchText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    //NSLog(@"%@",components);
    PFQuery *query = [PFQuery queryWithClassName:@"Foods"];
    [query whereKey:@"foodName" hasPrefix:components[0]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //NSLog(@"%@",object);
                [displayFoods addObject:object];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self.tableView reloadData];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
//    UIView* view = recognizer.view;
//    CGPoint loc = [recognizer locationInView:self.view];
//    UIView* subview = [view hitTest:loc withEvent:nil];
//    if(CGRectIntersectsRect(subview.frame, self.tableView.frame))
//    {
//        [self.searchBar resignFirstResponder];
//    }
    
    CGPoint tapLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if (indexPath) { //we are in a tableview cell, let the gesture be handled by the view
        //recognizer.cancelsTouchesInView = NO;
        [self.searchBar resignFirstResponder];
        FoodTableViewCell * touchedCell = (FoodTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"%@",touchedCell.tableLabel.text);
        //NSLog([NSString stringWithFormat:@"%ld", touchedCell.calories]);
        
        _calories.text = [NSString stringWithFormat:@"%.02f %@", touchedCell.calories*weight, @"Calories"];
        _weight.text = [NSString stringWithFormat:@"%.02f %@", weight, @"grams"];
        
    } else { // anywhere else, do what is needed for your case
        //[self.navigationController popViewControllerAnimated:YES];
        //NSLog(@"in else");
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)keyboardShown:(NSNotification *)note
{
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= keyboardFrame.size.height;
    [self.tableView setFrame:tableViewFrame];
}

-(void)keyboardHidden:(NSNotification *)note
{
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height += keyboardFrame.size.height;
    [self.tableView setFrame:tableViewFrame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] != 0)
    {
        displayFoods = [[NSMutableArray alloc]init];
        [self fetchFoodsFromDatabase:searchText];
    }
//    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    return [displayFoods count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"foodTableCell";
    
    FoodTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FoodTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...

    
    cell.tableLabel.adjustsFontSizeToFitWidth = YES;
    cell.tableLabel.numberOfLines = 0;
    cell.tableLabel.text = [displayFoods
                           objectAtIndex: [indexPath row]][@"foodName"];
    cell.calories = [[displayFoods
                     objectAtIndex: [indexPath row]][@"calories"] intValue];
    
    
  
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 300)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 30)];
//    [label setFont:[UIFont boldSystemFontOfSize:20]];
//    NSString *string = @"hello";
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}

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
