//
//  TETableViewDataSource.m
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/3/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import "TETableViewDataSource.h"
#import "TEArrayDiffCalculator.h"
#import "TEArrayDiff+NSIndexPath.h"
#import "TEMoveIndexPath.h"
#import "TEModelTransfer.h"


@interface TETableViewDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic) Class<TEModelTransfer> cellClass;

@end

@implementation TETableViewDataSource

- (id)initWithTableView:(UITableView *)tableView cellClass:(Class<TEModelTransfer>)cellClass {
    if (self = [super init]) {
        _tableView = tableView;
        _cellClass = cellClass;
        _items = @[];
        [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        tableView.dataSource = self;
    }
    
    return self;
}

- (void)updateItems:(NSArray *)items {
    TEArrayDiffCalculator *diffCalculator = [TEArrayDiffCalculator new];
    TEArrayDiff *diff = [diffCalculator calculateDiffsWithOldArray:self.items newArray:items];
    
    NSSet *deleted = [NSSet setWithArray:[diff.deleted valueForKeyPath:@"index"]];
    NSSet *movedToIndexes = [NSSet setWithArray:[diff.moved valueForKeyPath:@"index"]];
    NSSet *movedFromIndexes = [NSSet setWithArray:[diff.moved valueForKeyPath:@"fromIndex"]];
    NSSet *updated = [NSSet setWithArray:[diff.updated valueForKeyPath:@"index"]];
    
    BOOL shouldReload = [deleted intersectsSet:movedFromIndexes] || [deleted intersectsSet:movedToIndexes] || [updated intersectsSet:movedToIndexes] || [updated intersectsSet:movedFromIndexes];
    
    if (_items.count == 0 || shouldReload) {
        _items = items;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        _items = items;
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:diff.insertedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView deleteRowsAtIndexPaths:diff.deletedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadRowsAtIndexPaths:diff.updatedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [diff.movedIndexPaths enumerateObjectsUsingBlock:^(TEMoveIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView moveRowAtIndexPath:obj.fromIndexPath toIndexPath:obj.toIndexPath];
            [self.tableView moveRowAtIndexPath:obj.toIndexPath toIndexPath:obj.fromIndexPath];
        }];
        
        [self.tableView endUpdates];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell<TEModelTransfer> *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellClass) forIndexPath:indexPath];
    
    [cell updateWithModel:self.items[indexPath.row]];
    
    return cell;
}



@end
