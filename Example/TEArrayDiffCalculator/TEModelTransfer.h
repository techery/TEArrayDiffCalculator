//
//  TEModelTransfer.h
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/2/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import "TEUnique.h"

@protocol TEModelTransfer

- (void)updateWithModel:(id<TEUnique>)model;

@end