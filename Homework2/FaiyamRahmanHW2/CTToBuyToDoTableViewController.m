//
//  CTToBuyToDoTableViewController.m
//  FaiyamRahmanHW2
//
//  Created by Faiyam Rahman on 9/19/14.
//  Copyright (c) 2014 FaiyamLearningiOS. All rights reserved.
//

#import "CTToBuyToDoTableViewController.h"

@interface CTToBuyToDoTableViewController ()

- (void) getRidOfTable;

@end

@implementation CTToBuyToDoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    // Super initialization
    self = [super initWithStyle:style];
    
    // Custom initalization
    if (self) {
        // Add a "Done" Button to get rid of the table
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(getRidOfTable)];
        
        // Add a title
        self.title = @"Action Items";
    }

    return self;
}

- (void) getRidOfTable {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // one section for "To Buy", one for "to do"
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.toBuyArray count];
    } else if (section == 1) {
        return [self.toDoArray count];
    } else {
        return 0;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // tell the OS where to find memory for new cells
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // First few times through, we need to init new cells from scratch
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"cell"];
    }
    
    // Fetch the information for the section/row from the appropriate array
    int s = (int) indexPath.section;
    int r = (int) indexPath.row;
    NSString *mainText;
    NSString *detailText;
    if ((s == 0) && ([self.toBuyArray count] > 0)) {
        mainText = [[NSString alloc] initWithString:
                    [[self.toBuyArray objectAtIndex:r] objectAtIndex:0]];
        detailText = [[NSString alloc] initWithString:
                    [[self.toBuyArray objectAtIndex:r] objectAtIndex:1]];
    }
    else if ((s == 1) && ([self.toDoArray count] > 0)) {
        mainText = [[NSString alloc] initWithString:
                    [[self.toDoArray objectAtIndex:r] objectAtIndex:0]];
        detailText = [[NSString alloc] initWithString:
                      [[self.toDoArray objectAtIndex:r] objectAtIndex:1]];
        
    }
    cell.textLabel.text = mainText;
    cell.detailTextLabel.text = detailText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int section = indexPath.section;
    NSString *mainText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSString *detailText = [[[tableView cellForRowAtIndexPath:indexPath] detailTextLabel] text];
    NSString *message = [[NSString alloc] initWithFormat:@"Item: %@, Remember: %@", mainText, detailText];
    NSString *title;
    if (section == 0) {
        title = @"To Buy";
    } else if (section == 1) {
        title = @"To Do";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    
    [alertView show];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Tim Novikoff" forKey:@"Name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end