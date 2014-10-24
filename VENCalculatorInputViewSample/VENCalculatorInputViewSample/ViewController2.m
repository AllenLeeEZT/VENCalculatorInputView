//
//  ViewController2.m
//  VENCalculatorInputViewSample
//
//  Created by allenlee on 2014/10/24.
//  Copyright (c) 2014年 Venmo. All rights reserved.
//

#import "ViewController2.h"
#import "EZCheckCalculatorInputView.h"
#import "EZCheckCalculatorInputTextField.h"

@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet EZCheckCalculatorInputTextFieldWithoutKeyboard *calculatorInputTextField;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculatorInputTextField.maxLength = 12;
    EZCheckCalculatorInputView *inputView = [self.calculatorInputTextField getInputView];
    [self.placeholderView addSubview:inputView];
}

@end
