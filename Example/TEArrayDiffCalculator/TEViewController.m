//
//  TEViewController.m
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/02/2015.
//  Copyright (c) 2015 Anastasiya Gorban. All rights reserved.
//

#import "TEViewController.h"
#import "TETableViewDataSource.h"
#import "TEExampleTableViewCell.h"
#import "TEExampleModel.h"

@interface TEViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) TETableViewDataSource *dataSource;

@end

@implementation TEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataSource = [[TETableViewDataSource alloc] initWithTableView:self.tableView cellClass:[TEExampleTableViewCell class]];
    [self.dataSource updateItems:@[[TEExampleModel modelWithIdentifier:@(1) value:@"1"],
                                   [TEExampleModel modelWithIdentifier:@(2) value:@"2"],
                                   [TEExampleModel modelWithIdentifier:@(3) value:@"3"],
                                   [TEExampleModel modelWithIdentifier:@(4) value:@"4"],
                                   [TEExampleModel modelWithIdentifier:@(5) value:@"5"]]];
    
}

- (IBAction)updateItems:(id)sender {
    [self.dataSource updateItems:@[[TEExampleModel modelWithIdentifier:@(1) value:@"1"],
                                   [TEExampleModel modelWithIdentifier:@(4) value:@"4"],
                                   [TEExampleModel modelWithIdentifier:@(2) value:@"2"],
                                   [TEExampleModel modelWithIdentifier:@(5) value:@"5 updated"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
