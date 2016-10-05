//
// Created by Anastasiya Gorban on 10/6/15.
// Copyright (c) 2015 World Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEUnique.h"

@interface NSArray (TEUnique)

- (NSArray<id<TEUnique>> *)te_arrayByMutatingObject:(id <TEUnique>)listItem mutateBlock:(void(^)(id<TEUnique> object))mutateBlock;
- (NSArray<id<TEUnique>> *)te_arrayByRemovingObject:(id<TEUnique>)object;
- (NSArray<id<TEUnique>> *)te_arrayByRemovingObjects:(NSArray<id<TEUnique>> *)objects;
- (NSArray<id<TEUnique>> *)te_arrayByReplacingObject:(id<TEUnique>)object;

/**
 *  Put object in array. If object exists it will replace it, else add it to array
 *
 *  @param object object confirming TEUnique protocol
 *
 *  @return updated array with new object(replaced or added)
 */
- (NSArray<id<TEUnique>> *)te_arrayByPuttingObject:(id<TEUnique>)object;

/**
 *  Get object from array by his unique id
 *
 *  @param uniqueId object identifier
 *
 *  @return images with provided unique id
 */
- (id <TEUnique>)te_objectWithUniqueId:(id)uniqueId;
- (BOOL)te_containsObject:(id <TEUnique>)object;
- (id <TEUnique>)te_existingObject:(id <TEUnique>)object;

@end
