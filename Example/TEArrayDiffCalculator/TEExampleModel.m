//
//  TEExampleModel.m
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/2/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import "TEExampleModel.h"

@interface TEExampleModel()

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *value;

@end

@implementation TEExampleModel

- (instancetype)initWithIdentifier:(NSNumber *)identifier value:(NSString *)value {
    if (self = [super init]) {
        _identifier = identifier;
        _value = value;
    }
    
    return self;
}

+ (instancetype)modelWithIdentifier:(NSNumber *)identifier value:(NSString *)value {
    return [[self alloc] initWithIdentifier:identifier value:value];
}

- (BOOL)isEqual:(TEExampleModel *)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [object.identifier isEqual:self.identifier] && [object.value isEqual:self.value];
}

@end
