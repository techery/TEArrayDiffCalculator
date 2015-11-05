//
//  TETableViewDataSource.h
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/3/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TEModelTransfer;

@interface TETableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, readonly) NSArray *items;

- (id)initWithTableView:(UITableView *)tableView cellClass:(Class<TEModelTransfer>)cellClass;

- (void)updateItems:(NSArray *)items;


@end
