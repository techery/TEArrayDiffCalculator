//
//  TEExampleTableViewCell.m
//  TEArrayDiffCalculator
//
//  Created by Anastasiya Gorban on 11/3/15.
//  Copyright © 2015 Anastasiya Gorban. All rights reserved.
//

#import "TEExampleTableViewCell.h"
#import "TEExampleModel.h"

@interface TEExampleTableViewCell()

@property (nonatomic, strong) UILabel *label;

@end


@implementation TEExampleTableViewCell

- (void)updateWithModel:(TEExampleModel *)model {
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    self.label.text = [model value];
}


@end
