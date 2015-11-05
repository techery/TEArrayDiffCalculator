//
// Created by Anastasiya Gorban on 9/8/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TEDiffIndex;

@interface TEArrayDiff : NSObject

@property(nonatomic, readonly) NSArray<TEDiffIndex *> *inserted;
@property(nonatomic, readonly) NSArray<TEDiffIndex *> *deleted;
@property(nonatomic, readonly) NSArray<TEDiffIndex *> *updated;
@property(nonatomic, readonly) NSArray<TEDiffIndex *> *moved;

- (instancetype)initWithInserted:(NSArray<TEDiffIndex *> *)inserted
                         deleted:(NSArray<TEDiffIndex *> *)deleted
                         updated:(NSArray<TEDiffIndex *> *)updated
                           moved:(NSArray<TEDiffIndex *> *)moved;

+ (instancetype)containerWithInserted:(NSArray<TEDiffIndex *> *)inserted
                              deleted:(NSArray<TEDiffIndex *> *)deleted
                              updated:(NSArray<TEDiffIndex *> *)updated
                                moved:(NSArray<TEDiffIndex *> *)moved;

@end