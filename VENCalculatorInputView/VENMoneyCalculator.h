#import <Foundation/Foundation.h>

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

@interface VENMoneyCalculator : NSObject

@property (strong, nonatomic) NSLocale *locale;

/**
 * Evaluates a mathematical expression containing +, −, ×, and ÷.
 * @param expression The expression to evaluate
 * @return The evaluated expression. Returns nil if the expression is invalid.
 */
- (NSString *)evaluateExpression:(NSString *)expression;

@end
