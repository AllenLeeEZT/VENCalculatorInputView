//
//  EZCheckCalculatorInputTextField.m
//  VENCalculatorInputViewSample
//
//  Created by allenlee on 2014/10/22.
//  Copyright (c) 2014年 Venmo. All rights reserved.
//

#import "EZCheckCalculatorInputTextField.h"

@implementation EZCheckCalculatorInputTextField

- (UIView *)createCalculatorInputView {
    return [EZCheckCalculatorInputView new];
}

- (void)setUpInputView {
    [super setUpInputView];
}

- (EZCheckCalculatorInputView *)getInputView {
    return (EZCheckCalculatorInputView *)self.calculatorInputView;
}

@end

@implementation EZCheckCalculatorInputTextFieldWithoutKeyboard
@synthesize calculatorInputView = _calculatorInputView;

- (UIView *)createCalculatorInputView {
    return [EZCheckCalculatorInputViewWithoutKeyboard new];
}

- (void)setCalculatorInputView:(VENCalculatorInputView *)calculatorInputView {
    if (_calculatorInputView == calculatorInputView) {
        return;
    }

    VENCalculatorInputView *inputView = calculatorInputView;
    inputView.delegate = self;
    inputView.locale = self.locale;
    _calculatorInputView = inputView;
    UIView *zeroView = [[UIView alloc] init];
    self.inputView = zeroView;
}

- (void)setUpInputView {
    //Do Nothing...
    //Use self.calculatorInputView
}

- (EZCheckCalculatorInputView *)getInputView {
    id inputView = self.calculatorInputView;
    if (inputView == nil) {
        inputView = [self createCalculatorInputView];
        self.calculatorInputView = inputView;
    }
    return inputView;
}

@end
