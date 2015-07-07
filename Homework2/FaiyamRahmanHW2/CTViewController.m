//
//  CTViewController.m
//  FaiyamRahmanHW2
//
//  Created by Faiyam Rahman on 9/19/14.
//  Copyright (c) 2014 FaiyamLearningiOS. All rights reserved.
//

#import "CTViewController.h"
#import "CTToBuyToDoTableViewController.h"

@interface CTViewController ()

@property (strong, nonatomic) IBOutlet UITextField *mainText;
@property (strong, nonatomic) IBOutlet UITextField *detailText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *toBuyOrToDo;
@property (strong, nonatomic) IBOutlet UIButton *addToListButton;
@property (strong, nonatomic) NSString *toBuyKey;
@property (strong, nonatomic) NSString *toDoKey;

@property (strong, nonatomic) CTToBuyToDoTableViewController *myTableViewController;

@end

@implementation CTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create a table View Controller to hold all the to dos/to buys
    self.myTableViewController = [[CTToBuyToDoTableViewController alloc]
                                  initWithStyle:UITableViewStyleGrouped];
    self.myTableViewController.view.frame = self.view.bounds;
    
    // Initalize the arrays that hold table toDo/toBuy information
    self.toBuyKey = @"toBuyArray";
    self.toDoKey = @"toDoArray";
    if ([[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] containsObject:self.toBuyKey]) {
        NSLog(@"retrieving from dict");
        self.myTableViewController.toBuyArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.toBuyKey];
        self.myTableViewController.toDoArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.toDoKey];
    } else {
        self.myTableViewController.toBuyArray = [[NSMutableArray alloc] init];
        self.myTableViewController.toDoArray = [[NSMutableArray alloc] init];
    }

    
    //
}
- (IBAction)addToList:(id)sender {

    // Add the toDo/toBuy info to the appropriate interim array
    if (self.toBuyOrToDo.selectedSegmentIndex == 0) {
        [self.myTableViewController.toBuyArray addObject:@[self.mainText.text,
                                                           self.detailText.text]];
    } else {
        NSLog(@"Adding to toDoArray!");
        assert(self.toBuyOrToDo.selectedSegmentIndex == 1);
        [self.myTableViewController.toDoArray addObject:@[self.mainText.text,
                                                           self.detailText.text]];
    }
    
    // Sync the dictionary with disk
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Sends the keyboard down
    [self.view endEditing:YES];

}
- (IBAction)segmentedControlClicked:(id)sender {
    // Refresh the text boxes
    self.mainText.text = nil;
    self.detailText.text = nil;

}

- (IBAction)showList:(id)sender {
    
    // this assures that we can update the table after the view first appears
    [self.myTableViewController.tableView reloadData];
    
    // update the arrays in NSUserdefaults
    [[NSUserDefaults standardUserDefaults] setObject:self.myTableViewController.toBuyArray forKey:self.toBuyKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.myTableViewController.toDoArray forKey:self.toDoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // present the table in an animated fashion
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.myTableViewController];
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
