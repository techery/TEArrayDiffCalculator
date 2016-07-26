//
// Created by Anastasiya Gorban on 9/7/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TEArrayDiff.h"
#import "TEMoveIndexPath.h"

@interface TEArrayDiff (NSIndexPath)

/**
 *  Transform inserted diffs to NSIndexPaths for section 0
 *
 *  @return array of inserted NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)insertedIndexPaths;

/**
 *  Transform deleted diffs to NSIndexPaths for section 0
 *
 *  @return array of deleted NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)deletedIndexPaths;

/**
 *  Transform updated diffs to NSIndexPaths for section 0
 *
 *  @return array of updated NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)updatedIndexPaths;

/**
 *  Transform moved diffs to TEMoveIndexPaths for section 0
 *
 *  @return array of TEMoveIndexPath objects
 */
- (NSArray<TEMoveIndexPath *> *)movedIndexPaths;

/**
 *  Transform inserted diffs to NSIndexPaths for provided section
 *
 *  @param section section number
 *
 *  @return array of inserted NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)insertedIndexPathsForSection:(NSUInteger)section;

/**
 *  Transform deleted diffs to NSIndexPaths for provided section
 *
 *  @param section section number
 *
 *  @return array of deleted NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)deletedIndexPathsForSection:(NSUInteger)section;

/**
 *  Transform updated diffs to NSIndexPaths for provided section
 *
 *  @param section section number
 *
 *  @return array of updated NSIndexPaths
 */
- (NSArray<NSIndexPath *> *)updatedIndexPathsForSection:(NSUInteger)section;

/**
 *  Transform moved diffs to TEMoveIndexPath objects for provided section
 *
 *  @param section section number
 *
 *  @return array of TEMoveIndexPath objects
 */
- (NSArray<TEMoveIndexPath *> *)movedIndexPathsForSection:(NSUInteger)section;

@end