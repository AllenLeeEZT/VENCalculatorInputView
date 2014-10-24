//
//  EZCheckCalculatorInputTextField.h
//  VENCalculatorInputViewSample
//
//  Created by allenlee on 2014/10/22.
//  Copyright (c) 2014年 Venmo. All rights reserved.
//

#import "VENCalculatorInputTextField.h"
#import "EZCheckCalculatorInputView.h"

@interface EZCheckCalculatorInputTextField : VENCalculatorInputTextField

- (EZCheckCalculatorInputView *)getInputView;

@end


@interface EZCheckCalculatorInputTextFieldWithoutKeyboard : VENCalculatorInputTextField
@property (strong, nonatomic, setter=setCalculatorInputView:) UIView *calculatorInputView;

- (EZCheckCalculatorInputView *)getInputView;

@end
