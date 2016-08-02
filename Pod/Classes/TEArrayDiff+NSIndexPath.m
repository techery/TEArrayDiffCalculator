//
// Created by Anastasiya Gorban on 9/7/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "TEArrayDiff+NSIndexPath.h"
#import "TEArrayDiff.h"
#import "TEDiffIndex.h"
#import "TEMoveIndexPath.h"

@implementation TEArrayDiff (NSIndexPath)

- (NSArray<NSIndexPath *> *)insertedIndexPathsForSection:(NSUInteger)section {
    return [self transformDiffsToIndexPaths:self.inserted forSection:section];
}

- (NSArray<NSIndexPath *> *)insertedIndexPaths {
    return [self insertedIndexPathsForSection:0];
}

- (NSArray<NSIndexPath *> *)deletedIndexPathsForSection:(NSUInteger)section {
    return [self transformDiffsToIndexPaths:self.deleted forSection:section];
}

- (NSArray<NSIndexPath *> *)deletedIndexPaths {
    return [self deletedIndexPathsForSection:0];
}

- (NSArray<NSIndexPath *> *)updatedIndexPathsForSection:(NSUInteger)section {
    return [self transformDiffsToIndexPaths:self.updated forSection:section];
}

- (NSArray<NSIndexPath *> *)updatedIndexPaths {
    return [self updatedIndexPathsForSection:0];
}

- (NSArray<TEMoveIndexPath *> *)movedIndexPathsForSection:(NSUInteger)section {
    NSMutableArray *movedIndexPaths = [NSMutableArray arrayWithCapacity:self.moved.count];
    [self.moved enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:obj.index inSection:section];
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:obj.fromIndex inSection:section];
        TEMoveIndexPath *moveIndexPath = [TEMoveIndexPath pathWithFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [movedIndexPaths addObject:moveIndexPath];
    }];
    
    return [NSArray arrayWithArray:movedIndexPaths];
}

- (NSArray<TEMoveIndexPath *> *)movedIndexPaths {
    return [self movedIndexPathsForSection:0];
}

#pragma mark - Private

- (NSArray<NSIndexPath *> *)transformDiffsToIndexPaths:(NSArray<TEDiffIndex *> *)diffs forSection:(NSUInteger)section {
    NSMutableArray *insertedIndexPaths = [NSMutableArray arrayWithCapacity:diffs.count];
    [diffs enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:obj.index inSection:section];
        [insertedIndexPaths addObject:indexPath];
    }];
    
    return [NSArray arrayWithArray:insertedIndexPaths];
}

- (NSArray<NSIndexPath *> *)transformDiffsToIndexPaths:(NSArray<TEDiffIndex *> *)diffs {
    return [self transformDiffsToIndexPaths:diffs forSection:0];
}

@end