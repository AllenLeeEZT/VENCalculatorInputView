//
//  EZCheckCalculatorInputView.m
//  VENCalculatorInputViewSample
//
//  Created by allenlee on 2014/10/22.
//  Copyright (c) 2014年 Venmo. All rights reserved.
//

#import "EZCheckCalculatorInputView.h"

@implementation EZCheckCalculatorInputView

+ (NSString *)nibName {
    return @"EZCheckCalculatorInputView";
}

@end

@implementation EZCheckCalculatorInputViewWithoutKeyboard

+ (NSString *)nibName {
    return @"EZCheckCalculatorInputViewWithoutKeyboard";
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set customizable properties
        [self setNumberButtonBackgroundColor:[UIColor colorWithRed:202/255.0f green:203/255.0f blue:205/255.0f alpha:1]];
        [self setNumberButtonBorderColor:[UIColor colorWithRed:0.505 green:0.509 blue:0.513 alpha:1.000]];
        [self setOperationButtonBackgroundColor:[UIColor colorWithRed:0.980 green:0.543 blue:0.152 alpha:1.000]];
        [self setOperationButtonBorderColor:[UIColor colorWithRed:0.505 green:0.509 blue:0.513 alpha:1.000]];
        [self setButtonHighlightedColor:[UIColor grayColor]];
        [self setButtonTitleColor:[UIColor colorWithRed:0.092 green:0.087 blue:0.087 alpha:1.000]];
    }
    return self;
}

@end
