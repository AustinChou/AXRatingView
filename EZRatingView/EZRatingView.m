//
//  EZRatingView.m
//

#import "EZRatingView.h"
#import <QuartzCore/QuartzCore.h>

NSString *const EZMarkerTypeKey = @"EZMarkerTypeKey";

// EZMarkerTypeCharacter
NSString *const EZMarkerHighlightCharacterKey = @"EZMarkerHighlightCharacterKey";
NSString *const EZMarkerMaskCharacterKey = @"EZMarkerMaskCharacterKey";
NSString *const EZMarkerCharacterFontKey = @"EZMarkerCharacterFontKey";

// EZMarkerTypeImage
NSString *const EZMarkerHighlightImageKey = @"EZMarkerHighlightImageKey";
NSString *const EZMarkerMaskImageKey = @"EZMarkerMaskImageKey";

NSString *const EZMarkerBaseColorKey = @"EZMarkerBaseColorKey";
NSString *const EZMarkerHighlightColorKey = @"EZMarkerHighlightColorKey";

@implementation EZRatingView

- (void)ezRatingViewInit
{
    _continuous = YES;
    _numberOfStar = 5;
    _stepInterval = 0.0;
    _minimumValue = 0.0;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self ezRatingViewInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self ezRatingViewInit];
    }
    return self;
}

- (void)sizeToFit
{
    [super sizeToFit];
    self.frame = (CGRect){self.frame.origin, self.intrinsicContentSize};
}

- (CGSize)intrinsicContentSize
{
    return (CGSize){self.maskImage.size.width * _numberOfStar, self.maskImage.size.height};
}

- (void)drawRect:(CGRect)rect
{
    if (!_maskLayer) {
        _maskLayer = [self maskLayer];
        [self.layer addSublayer:_maskLayer];
    }

    if (!_highlightLayer) {
        _highlightLayer = [self highlightLayer];
        _highlightLayer.masksToBounds = YES;
        [self.layer addSublayer:_highlightLayer];
    }

    CGFloat selfWidth = (self.highlightImage.size.width * _numberOfStar);
    CGFloat selfHeight = (self.highlightImage.size.height);
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _highlightLayer.frame = (CGRect){CGPointZero, selfWidth * (_value / _numberOfStar), selfHeight};
    [CATransaction commit];
}

#pragma mark - Getters

- (NSString *)highlightCharacter
{
    return self.markerDict[EZMarkerHighlightCharacterKey] ?: self.maskCharacter;
}

- (NSString *)maskCharacter
{
    return self.markerDict[EZMarkerMaskCharacterKey] ?: @"\u2605";
}

- (UIFont *)markerFont
{
    return self.markerDict[EZMarkerCharacterFontKey] ?: [UIFont systemFontOfSize:22.0];
}

- (UIColor *)baseColor
{
    return self.markerDict[EZMarkerBaseColorKey] ?: [UIColor darkGrayColor];
}

- (UIColor *)highlightColor
{
    return self.markerDict[EZMarkerHighlightColorKey] ?: [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0];
}

- (UIImage *)maskImage
{
    if (self.markerDict[EZMarkerMaskImageKey]) {
        return self.markerDict[EZMarkerMaskImageKey];
    } else if (_maskImage) {
        return _maskImage;
    } else {
        CGSize size;
        if ([self.maskCharacter respondsToSelector:@selector(sizeWithAttributes:)]) {
            size = [self.maskCharacter sizeWithAttributes:@{NSFontAttributeName : self.markerFont}];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            size = [self.maskCharacter sizeWithFont:self.markerFont];
#pragma clang diagnostic pop
        }

        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [[UIColor clearColor] set];
        if ([self.maskCharacter respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
            [self.maskCharacter drawAtPoint:CGPointZero
                             withAttributes:@{NSFontAttributeName : self.markerFont, NSForegroundColorAttributeName : self.baseColor}];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [self.maskCharacter drawAtPoint:CGPointZero withFont:self.markerFont];
#pragma clang diagnostic pop
        }
        UIImage *markImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return _maskImage = markImage;
    }
}

- (UIImage *)highlightImage
{
    if (self.markerDict[EZMarkerHighlightImageKey]) {
        return self.markerDict[EZMarkerHighlightImageKey];
    } else if (self.markerDict[EZMarkerMaskImageKey]) {
        return self.markerDict[EZMarkerMaskImageKey];
    } else if (_highlightImage) {
        return _highlightImage;
    } else {
        CGSize size;
        if ([self.highlightCharacter respondsToSelector:@selector(sizeWithAttributes:)]) {
            size = [self.highlightCharacter sizeWithAttributes:@{NSFontAttributeName : self.markerFont}];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            size = [self.highlightCharacter sizeWithFont:self.markerFont];
#pragma clang diagnostic pop
        }

        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [[UIColor clearColor] set];
        if ([self.highlightCharacter respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
            [self.highlightCharacter drawAtPoint:CGPointZero
                                  withAttributes:@{NSFontAttributeName : self.markerFont, NSForegroundColorAttributeName : self.highlightColor}];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [self.highlightCharacter drawAtPoint:CGPointZero withFont:self.markerFont];
#pragma clang diagnostic pop
        }
        UIImage *markImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return _highlightImage = markImage;
    }
}

#pragma mark - Setters

- (void)setMarkerDict:(NSDictionary *)markerDict
{
    _markerDict = markerDict;
    _highlightImage = nil;
    _maskImage = nil;
    _highlightLayer = nil;
    _maskLayer = nil;
    [self setNeedsDisplay];
}

- (void)setStepInterval:(CGFloat)stepInterval
{
    _stepInterval = fmax(stepInterval, 0.0);
}

- (void)setValue:(CGFloat)value
{
    if (_value != value) {
        _value = fmin(fmax(value, 0.0), _numberOfStar);
        [self setNeedsDisplay];
    }
}

#pragma mark - Operation

- (CALayer *)maskLayer
{
    // Generate Mask Layer
    _maskImage = [self maskImage];
    CGFloat markWidth = _maskImage.size.width;
    CGFloat markHalfWidth = markWidth / 2;
    CGFloat markHeight = _maskImage.size.height;
    CGFloat markHalfHeight = markHeight / 2;

    CALayer *markerLayer = [CALayer layer];
    markerLayer.opaque = NO;
    for (int i = 0; i < _numberOfStar; i++) {
        CALayer *starLayer = [CALayer layer];
        starLayer.contents = (id)_maskImage.CGImage;
        starLayer.bounds = (CGRect){CGPointZero, _maskImage.size};
        starLayer.position = (CGPoint){markHalfWidth + markWidth * i, markHalfHeight};
        [markerLayer addSublayer:starLayer];
    }
    markerLayer.backgroundColor = [UIColor clearColor].CGColor;
    [markerLayer setFrame:(CGRect){CGPointZero, _maskImage.size.width * _numberOfStar, _maskImage.size.height}];
    return markerLayer;
}

- (CALayer *)highlightLayer
{
    // Generate Mask Layer
    _highlightImage = [self highlightImage];
    CGFloat markWidth = _highlightImage.size.width;
    CGFloat markHalfWidth = markWidth / 2;
    CGFloat markHeight = _highlightImage.size.height;
    CGFloat markHalfHeight = markHeight / 2;

    CALayer *markerLayer = [CALayer layer];
    markerLayer.opaque = NO;
    for (int i = 0; i < _numberOfStar; i++) {
        CALayer *starLayer = [CALayer layer];
        starLayer.contents = (id)_highlightImage.CGImage;
        starLayer.bounds = (CGRect){CGPointZero, _highlightImage.size};
        starLayer.position = (CGPoint){markHalfWidth + markWidth * i, markHalfHeight};
        [markerLayer addSublayer:starLayer];
    }
    markerLayer.backgroundColor = [UIColor clearColor].CGColor;
    [markerLayer setFrame:(CGRect){CGPointZero, _highlightImage.size.width * _numberOfStar, _highlightImage.size.height}];
    return markerLayer;
}

#pragma mark - Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.userInteractionEnabled) {
        [self touchesMoved:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    float value = location.x / (_maskImage.size.width * _numberOfStar) * _numberOfStar;
    if (_stepInterval != 0.0) {
        value = fmax(_minimumValue, ceilf(value / _stepInterval) * _stepInterval);
    } else {
        value = fmax(_minimumValue, value);
    }
    [self setValue:value];
    if (self.isContinuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
