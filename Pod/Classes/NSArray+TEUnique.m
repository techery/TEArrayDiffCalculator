//
// Created by Anastasiya Gorban on 10/6/15.
// Copyright (c) 2015 World Ventures. All rights reserved.
//

#import "NSArray+DCFunctional.h"
#import "TEUnique.h"

@implementation NSArray (TEUnique)

- (NSArray<id<TEUnique>> *)te_arrayByMutatingObject:(id <TEUnique>)listItem mutateBlock:(void(^)(id<TEUnique> object))mutateBlock {
    id<TEUnique> obj = [[self filter:^BOOL(id<TEUnique> o) {
        return [o.identifier isEqual:listItem.identifier];
    }] firstObject];

    mutateBlock(obj);

    return self;
}

- (NSArray<id<TEUnique>> *)te_arrayByRemovingObject:(id<TEUnique>)object {
    NSMutableArray *mutableSelf = [self mutableCopy];
    id<TEUnique> existingObj = [self existingObject:object];

    if (existingObj) {
        [mutableSelf removeObject:existingObj];
    }
    
    return [mutableSelf copy];
}

- (NSArray<id<TEUnique>> *)te_arrayByReplacingObject:(id<TEUnique>)object {
    NSMutableArray *mutableSelf = [self mutableCopy];
    id<TEUnique> existingObj = [self existingObject:object];

    if (existingObj) {
        [mutableSelf replaceObjectAtIndex:[mutableSelf indexOfObject:existingObj] withObject:object];
    }

    return [mutableSelf copy];
}


- (BOOL)te_containsObject:(id <TEUnique>)item {
    return [self te_existingObject:item] != nil;
}

- (id <TEUnique>)te_existingObject:(id <TEUnique>)object {
    id existingObject = [[self filter:^BOOL(id<TEUnique> o) {
        return [o.identifier isEqual:object.identifier];
    }] firstObject];
    
    return existingObject;
}

- (NSInteger)te_indexOfObject:(id <TEUnique>)object {
    return [self indexOfObject:[self te_existingObject:object]];
}

#pragma mark - Private

- (id<TEUnique>)existingObject:(id<TEUnique>)object {
    id<TEUnique> existingObj = [[self filter:^BOOL(id<TEUnique> o) {
        return [o.identifier isEqual:object.identifier];
    }] firstObject];
    return existingObj;
}

@end