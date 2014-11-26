#import "VENMoneyCalculator.h"
#import "NSString+VENCalculatorInputView.h"

@interface VENMoneyCalculator ()
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

- (NSString *)evaluateExpression:(NSString *)expression forceCurrencyStyle:(BOOL)usingCurrencyStyle;
@end

@implementation VENMoneyCalculator

- (void)setMaximumFractionDigits:(NSUInteger)maximumFractionDigits {
    static NSString * const key = @"maximumFractionDigits";
    [self willChangeValueForKey:key];
    _maximumFractionDigits = maximumFractionDigits;
    self.numberFormatter.maximumFractionDigits = maximumFractionDigits;
    [self didChangeValueForKey:key];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locale = [NSLocale currentLocale];
    }
    return self;
}

- (NSString *)evaluateExpression:(NSString *)expressionString {
    return [self evaluateExpression:expressionString forceCurrencyStyle:NO];
}

- (NSString *)evaluateExpressionForceCurrencyStyle:(NSString *)expressionString {
    return [self evaluateExpression:expressionString forceCurrencyStyle:YES];
}

- (NSString *)evaluateExpression:(NSString *)expressionString forceCurrencyStyle:(BOOL)forceCurrencyStyle {
    if (!expressionString) {
        return nil;
    }
    NSString *floatString = [NSString stringWithFormat:@"1.0*%@", expressionString];
    NSString *sanitizedString = [self sanitizedString:floatString];
    NSExpression *expression;
    id result;
    @try {
        expression = [NSExpression expressionWithFormat:sanitizedString];
        result = [expression expressionValueWithObject:nil context:nil];
    }
    @catch (NSException *exception) {
        if ([[exception name] isEqualToString:NSInvalidArgumentException]) {
            return nil;
        } else {
            [exception raise];
        }
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        unsigned long integerExpression = [(NSNumber *)result unsignedLongValue];
        double floatExpression = [(NSNumber *)result doubleValue];
        if (fequal(integerExpression, floatExpression)) {
            if (forceCurrencyStyle) {
                NSString *moneyFormattedNumber = [[self numberFormatter] stringFromNumber:@(integerExpression)];
                return [moneyFormattedNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else {
                return [(NSNumber *)result stringValue];
            }
        } else if (floatExpression >= CGFLOAT_MAX || floatExpression <= CGFLOAT_MIN || isnan(floatExpression)) {
            return @"0";
        } else {
            if (forceCurrencyStyle) {
                NSString *moneyFormattedNumber = [[self numberFormatter] stringFromNumber:@(floatExpression)];
                return [moneyFormattedNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }else {
                return [(NSNumber *)result stringValue];
            }
        }
    } else {
        return nil;
    }
}

#pragma mark - Private

- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        [_numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_numberFormatter setCurrencySymbol:@""];
        [_numberFormatter setCurrencyDecimalSeparator:[self decimalSeparator]];
    }
    return _numberFormatter;
}

- (NSString *)sanitizedString:(NSString *)string {
    return [[self replaceOperandsInString:string] stringByReplacingCharactersInSet:[self illegalCharacters] withString:@""];
}

- (NSString *)replaceOperandsInString:(NSString *)string {
    NSString *subtractReplaced = [string stringByReplacingOccurrencesOfString:@"−" withString:@"-"];
    NSString *divideReplaced = [subtractReplaced stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    NSString *multiplyReplaced = [divideReplaced stringByReplacingOccurrencesOfString:@"×" withString:@"*"];

    return [multiplyReplaced stringByReplacingOccurrencesOfString:[self decimalSeparator] withString:@"."];
}

- (NSCharacterSet *)illegalCharacters {
    return [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-/*.+Cc"] invertedSet];
}

- (NSString *)decimalSeparator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

@end
