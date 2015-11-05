//
// Created by Anastasiya Gorban on 9/7/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TEArrayDiff.h"
#import "TEMoveIndexPath.h"

@interface TEArrayDiff (NSIndexPath)

- (NSArray<NSIndexPath *> *)insertedIndexPaths;
- (NSArray<NSIndexPath *> *)deletedIndexPaths;
- (NSArray<NSIndexPath *> *)updatedIndexPaths;
- (NSArray<TEMoveIndexPath *> *)movedIndexPaths;

@end