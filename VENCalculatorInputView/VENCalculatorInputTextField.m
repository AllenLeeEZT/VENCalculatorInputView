#import "VENCalculatorInputTextField.h"
#import "VENMoneyCalculator.h"
#import "UITextField+VENCalculatorInputView.h"

@interface VENCalculatorInputTextField ()
@property (strong, nonatomic) VENMoneyCalculator *moneyCalculator;
@end

@implementation VENCalculatorInputTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUpInit];
}

- (UIView *)createCalculatorInputView {
    return [VENCalculatorInputView new];
}

- (void)setUpInit {
    self.locale = [NSLocale currentLocale];

    [self setUpInputView];

    VENMoneyCalculator *moneyCalculator = [VENMoneyCalculator new];
    moneyCalculator.locale = self.locale;
    self.moneyCalculator = moneyCalculator;

    [self addTarget:self action:@selector(venCalculatorTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(venCalculatorTextFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)setUpInputView {
    VENCalculatorInputView *inputView = [self createCalculatorInputView];
    inputView.delegate = self;
    inputView.locale = self.locale;
    self.calculatorInputView = inputView;
    self.inputView = self.calculatorInputView;
}

#pragma mark - Properties

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    VENCalculatorInputView *inputView = self.calculatorInputView;
    inputView.locale = locale;
    self.moneyCalculator.locale = locale;
}

#pragma mark - UITextField

- (void)venCalculatorTextFieldDidChange {
    if (![self.text length]) return;

    BOOL shouldChange = YES;
    if (self.maxLength > 0
        && self.maxLength != NSNotFound
        && self.text.length >= self.maxLength) {
        shouldChange = NO;
    }
    
    NSString *lastCharacterString = [self.text substringFromIndex:[self.text length] - 1];
    NSString *subString = [self.text substringToIndex:self.text.length - 1];

    if (shouldChange) {
        if ([lastCharacterString isEqualToString:@"+"] ||
            [lastCharacterString isEqualToString:@"−"] ||
            [lastCharacterString isEqualToString:@"×"] ||
            [lastCharacterString isEqualToString:@"÷"]) {
            
            NSString *evaluatedString = [self.moneyCalculator evaluateExpression:subString];
            if (evaluatedString) {
                self.text = [NSString stringWithFormat:@"%@%@", evaluatedString, lastCharacterString];
            } else {
                self.text = subString;
            }
        } else if ([lastCharacterString isEqualToString:[self decimalSeparator]]) {
            if ([subString rangeOfString:[self decimalSeparator]].location != NSNotFound) {
                self.text = subString;
            }
        }
    }else {
        self.text = subString;
    }
    
    if ([lastCharacterString isEqualToString:@"="]) {
        NSString *evaluatedString = [self.moneyCalculator evaluateExpression:subString];
        if (evaluatedString) {
            self.text = evaluatedString;
        } else {
            self.text = subString;
        }
    } else if ([[lastCharacterString uppercaseString] isEqualToString:@"C"]) {
        self.text = @"";
    }
}

- (void)venCalculatorTextFieldDidEndEditing {
    NSString *textToEvaluate = [self trimExpressionString:self.text];
    NSString *evaluatedString = [self.moneyCalculator evaluateExpression:textToEvaluate];
    if (evaluatedString) {
        self.text = evaluatedString;
    }
}

#pragma mark - VENCalculatorInputViewDelegate

- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        NSRange range = [self selectedNSRange];
        if ([self.delegate textField:self shouldChangeCharactersInRange:range replacementString:key]) {
            if (!self.isEditing) {
                [self becomeFirstResponder];
            }
            [self insertText:key];
        }
    } else {
        if (!self.isEditing) {
            [self becomeFirstResponder];
        }
        [self insertText:key];
    }
}

- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView {
    if (!self.isEditing) {
        [self becomeFirstResponder];
    }
    [self deleteBackward];
}

#pragma mark - Helpers

/**
 * Removes any trailing operations and decimals.
 * @param expressionString The expression string to trim
 * @return The trimmed expression string
 */
- (NSString *)trimExpressionString:(NSString *)expressionString {
    if ([self.text length] > 0) {
        NSString *lastCharacterString = [self.text substringFromIndex:[self.text length] - 1];
        if ([lastCharacterString isEqualToString:@"+"] ||
        [lastCharacterString isEqualToString:@"−"] ||
        [lastCharacterString isEqualToString:@"×"] ||
        [lastCharacterString isEqualToString:@"÷"] ||
        [lastCharacterString isEqualToString:[self decimalSeparator]]) {
            return [self.text substringToIndex:self.text.length - 1];
        }
    }
    return expressionString;
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

@end
