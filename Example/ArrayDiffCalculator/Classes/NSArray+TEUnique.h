//
// Created by Anastasiya Gorban on 10/6/15.
// Copyright (c) 2015 World Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEUnique;

@interface NSArray (TEUnique)

- (NSArray<id<TEUnique>> *)te_arrayByMutatingObject:(id <TEUnique>)listItem mutateBlock:(void(^)(id<TEUnique> object))mutateBlock;
- (NSArray<id<TEUnique>> *)te_arrayByRemovingObject:(id<TEUnique>)object;
- (NSArray<id<TEUnique>> *)te_arrayByReplacingObject:(id<TEUnique>)object;

- (BOOL)te_containsObject:(id <TEUnique>)object;
- (id <TEUnique>)te_existingObject:(id <TEUnique>)object;
- (NSInteger)te_indexOfObject:(id <TEUnique>)object;

@end