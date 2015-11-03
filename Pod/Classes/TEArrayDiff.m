//
// Created by Anastasiya Gorban on 9/8/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "TEArrayDiff.h"


@implementation TEArrayDiff {

}
- (instancetype)initWithInserted:(NSArray<TEDiffIndex *> *)inserted
                         deleted:(NSArray<TEDiffIndex *> *)deleted
                         updated:(NSArray<TEDiffIndex *> *)updated
                           moved:(NSArray<TEDiffIndex *> *)moved {
    self = [super init];
    if (self) {
        _inserted = inserted;
        _deleted = deleted;
        _updated = updated;
        _moved = moved;
    }

    return self;
}

+ (instancetype)containerWithInserted:(NSArray<TEDiffIndex *> *)inserted
                              deleted:(NSArray<TEDiffIndex *> *)deleted
                              updated:(NSArray<TEDiffIndex *> *)updated
                                moved:(NSArray<TEDiffIndex *> *)moved {
    return [[self alloc] initWithInserted:inserted deleted:deleted updated:updated moved:moved];
}

@end