//
//  EZCheckCalculatorInputTextField.m
//  VENCalculatorInputViewSample
//
//  Created by allenlee on 2014/10/22.
//  Copyright (c) 2014年 Venmo. All rights reserved.
//

#import "EZCheckCalculatorInputTextField.h"
#import "EZCheckCalculatorInputView.h"

@implementation EZCheckCalculatorInputTextField

- (UIView<UIInputViewAudioFeedback> *)createCalculatorInputView {
    return [EZCheckCalculatorInputView new];
}

@end
