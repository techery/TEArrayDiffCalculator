//
// Created by Anastasiya Gorban on 9/7/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "TEArrayDiffCalculator.h"
#import "TEDiffIndex.h"
#import "TEUnique.h"
#import "TEArrayDiff.h"
#import "NSArray+DCFunctional.h"
#import "NSArray+TEUnique.h"


@interface TEArrayDiffCalculator ()
@property(nonatomic, strong) NSArray *inserted;
@property(nonatomic, strong) NSArray *deleted;
@property(nonatomic, strong) NSArray *updated;
@property(nonatomic, strong) NSArray *moved;
@end

@implementation TEArrayDiffCalculator

- (TEArrayDiff *)calculateDiffsWithOldArray:(NSArray<id<TEUnique>> *)oldArray newArray:(NSArray<id<TEUnique>> *)newArray {
    self.inserted = [self calculateInsertions:oldArray newArray:newArray];
    self.deleted = [self calculateDeletions:oldArray newArray:newArray];
    self.moved = [self calculateMoves:oldArray newArray:newArray];    
    self.updated = [self calculateUpdates:oldArray newArray:newArray];

    return [TEArrayDiff containerWithInserted:[self.inserted copy]
                                      deleted:[self.deleted copy]
                                      updated:[self.updated copy]
                                        moved:[self.moved copy]];
}

#pragma mark - Private

- (NSArray *)substractArray:(NSArray<id<TEUnique>> *)new fromArray:(NSArray<id<TEUnique>> *)old {
    
    NSMutableArray *substraction = [NSMutableArray new];
    [old enumerateObjectsUsingBlock:^(id <TEUnique> obj, NSUInteger idx, BOOL *stop) {
        id oldObj = [[new filter:^BOOL(id <TEUnique> o) {
            return [o.identifier isEqual:obj.identifier];
        }] firstObject];
        if (!oldObj) {
            [substraction addObject:obj];
        }
    }];

    return [substraction copy];
}

- (NSArray *)calculateDiffIndexesBySubstraction:(NSArray<id<TEUnique>> *)newArray from:(NSArray<id<TEUnique>> *)oldArray {
    NSArray *substraction = [self substractArray:newArray fromArray:oldArray];
    NSMutableArray *diffIndexes = [NSMutableArray arrayWithCapacity:substraction.count];

    [oldArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([substraction containsObject:obj]) {
            TEDiffIndex *diff = [TEDiffIndex diffWithIndex:idx];
            [diffIndexes addObject:diff];
        }
    }];

    return [diffIndexes copy];
    
}

- (NSArray *)calculateDeletions:(NSArray<id<TEUnique>> *)oldArray newArray:(NSArray<id<TEUnique>> *)newArray {
    return [self calculateDiffIndexesBySubstraction:newArray from:oldArray];
}

- (NSArray *)calculateInsertions:(NSArray<id<TEUnique>> *)oldArray newArray:(NSArray<id<TEUnique>> *)newArray {
    return [self calculateDiffIndexesBySubstraction:oldArray from:newArray];
}

- (NSArray *)calculateUpdates:(NSArray<id<TEUnique>> *)oldArray newArray:(NSArray<id<TEUnique>> *)newArray {
    NSMutableArray *mergedArray = [NSMutableArray arrayWithArray:oldArray];
    
    [[[self.deleted reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        if (obj.index >= mergedArray.count) {
            return;
        }
        [mergedArray removeObjectAtIndex:obj.index];
    }];
    
    [self.inserted enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        if (obj.index >= newArray.count) {
            return;
        }
        
        [mergedArray insertObject:newArray[obj.index] atIndex:obj.index];
    }];    
    
    [self.moved enumerateObjectsUsingBlock:^(TEDiffIndex *diffIndex, NSUInteger idx, BOOL *stop) {
        if (diffIndex.fromIndex >= mergedArray.count || diffIndex.index >= mergedArray.count) {
            return;
        }
        id tempObj = [mergedArray objectAtIndex:diffIndex.fromIndex];
        [mergedArray replaceObjectAtIndex:diffIndex.fromIndex withObject:[mergedArray objectAtIndex:diffIndex.index]];
        [mergedArray replaceObjectAtIndex:diffIndex.index withObject:tempObj];
    }];
    
    NSMutableArray *updatedDiffs = [NSMutableArray new];
    [mergedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx >= newArray.count) {
            return;
        }
        
        id object = newArray[idx];
        if (![object isEqual:obj]) {
            TEDiffIndex *diff = [TEDiffIndex diffWithIndex:[oldArray indexOfObject:obj]];
            [updatedDiffs addObject:diff];
        }
    }];

    return [NSArray arrayWithArray:updatedDiffs];
}

- (NSArray *)calculateMoves:(NSArray<id<TEUnique>> *)oldArray newArray:(NSArray<id<TEUnique>> *)newArray {
    NSMutableArray *mergedArray = [NSMutableArray arrayWithArray:oldArray];    
    
    [[[self.deleted reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        [mergedArray removeObjectAtIndex:obj.index];
    }];
    
    [self.inserted enumerateObjectsUsingBlock:^(TEDiffIndex *obj, NSUInteger idx, BOOL *stop) {
        [mergedArray insertObject:newArray[obj.index] atIndex:obj.index];
    }];

    NSMutableArray *result = [NSMutableArray new];
    for (int i = 0; i < mergedArray.count; i++) {
        id<TEUnique> oldObj = mergedArray[i];
        
        if (i >= newArray.count) {
            continue;
        }
        
        id<TEUnique> newObj = newArray[i];
        if (![oldObj.identifier isEqual:newObj.identifier]) {
            NSInteger fromIndex = i;
            NSInteger toIndex = [newArray te_indexOfObject:oldObj];
            [result addObject:[TEDiffIndex diffWithFromIndex:fromIndex toIndex:toIndex]];
            
            id tempObj = [mergedArray objectAtIndex:i];
            
            if (toIndex >= mergedArray.count) {
                continue;
            }
            
            [mergedArray replaceObjectAtIndex:i withObject:[mergedArray objectAtIndex:toIndex]];
            [mergedArray replaceObjectAtIndex:toIndex withObject:tempObj];            
        }
    }
    
    return [result copy];
}

@end
