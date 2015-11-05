//
//  TEExampleModel.h
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/2/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEUnique.h"

@interface TEExampleModel : NSObject <TEUnique>

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *value;

+ (instancetype)modelWithIdentifier:(NSNumber *)identifier value:(NSString *)value;

@end
