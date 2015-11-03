//
// Created by Anastasiya Gorban on 9/7/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "TEArrayDiff+NSIndexPath.h"
#import "TEArrayDiff.h"
#import "TEDiffIndex.h"
#import "TEMoveIndexPath.h"

@implementation TEArrayDiff (NSIndexPath)

- (NSArray<NSIndexPath *> *)insertedIndexPaths {
    return [self transformDiffsToIndexPaths:self.inserted];

}

- (NSArray<NSIndexPath *> *)deletedIndexPaths {
    return [self transformDiffsToIndexPaths:self.deleted];
}

- (NSArray<NSIndexPath *> *)updatedIndexPaths {
    return [self transformDiffsToIndexPaths:self.updated];
}

- (NSArray<TEMoveIndexPath *> *)movedIndexPaths {
    NSMutableArray *movedIndexPaths = [NSMutableArray arrayWithCapacity:self.moved.count];
    [self.moved enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:obj.index inSection:0];
        NSIndexPath *fromIndexPath = [NSIndexPath indexPathForItem:obj.fromIndex inSection:0];
        TEMoveIndexPath *moveIndexPath = [TEMoveIndexPath pathWithFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [movedIndexPaths addObject:moveIndexPath];
    }];

    return [NSArray arrayWithArray:movedIndexPaths];

}

#pragma mark - Private

- (NSArray<NSIndexPath *> *)transformDiffsToIndexPaths:(NSArray<TEDiffIndex *> *)diffs {
    NSMutableArray *insertedIndexPaths = [NSMutableArray arrayWithCapacity:diffs.count];
    [diffs enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:obj.index inSection:0];
        [insertedIndexPaths addObject:indexPath];
    }];

    return [NSArray arrayWithArray:insertedIndexPaths];
}

@end