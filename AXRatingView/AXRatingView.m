//
//  AXRatingView.m
//

#import "AXRatingView.h"
#import <QuartzCore/QuartzCore.h>

NSString *const AXMarkerTypeKey = @"AXMarkerTypeKey";

// AXMarkerTypeCharacter
NSString *const AXMarkerHighlightCharacterKey = @"AXMarkerHighlightCharacterKey";
NSString *const AXMarkerMaskCharacterKey = @"AXMarkerMaskCharacterKey";
NSString *const AXMarkerCharacterFontKey = @"AXMarkerCharacterFontKey";

// AXMarkerTypeImage
NSString *const AXMarkerHighlightImageKey = @"AXMarkerHighlightImageKey";
NSString *const AXMarkerMaskImageKey = @"AXMarkerMaskImageKey";

NSString *const AXMarkerBaseColorKey = @"AXMarkerBaseColorKey";
NSString *const AXMarkerHighlightColorKey = @"AXMarkerHighlightColorKey";

@implementation AXRatingView

- (void)axRatingViewInit
{
    _numberOfStar = 5;
    _stepInterval = 0.0;
    _minimumValue = 0.0;
    self.userInteractionEnabled = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self axRatingViewInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self axRatingViewInit];
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
    return self.markerDict[AXMarkerHighlightCharacterKey] ?: self.maskCharacter;
}

- (NSString *)maskCharacter
{
    return self.markerDict[AXMarkerMaskCharacterKey] ?: @"\u2605";
}

- (UIFont *)markerFont
{
    return self.markerDict[AXMarkerCharacterFontKey] ?: [UIFont systemFontOfSize:22.0];
}

- (UIColor *)baseColor
{
    return self.markerDict[AXMarkerBaseColorKey] ?: [UIColor darkGrayColor];
}

- (UIColor *)highlightColor
{
    return self.markerDict[AXMarkerHighlightColorKey] ?: [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0];
}

- (UIImage *)maskImage
{
    if (self.markerDict[AXMarkerMaskImageKey]) {
        return self.markerDict[AXMarkerMaskImageKey];
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
    if (self.markerDict[AXMarkerHighlightImageKey]) {
        return self.markerDict[AXMarkerHighlightImageKey];
    } else if (self.markerDict[AXMarkerMaskImageKey]) {
        return self.markerDict[AXMarkerMaskImageKey];
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
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
