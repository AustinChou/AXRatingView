//
//  AXRatingView.h
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface AXRatingView : UIControl {
  CALayer *_starMaskLayer;
  CALayer *_highlightLayer;
  UIImage *_markImage;
}

@property (nonatomic) IBInspectable NSUInteger numberOfStar;
@property (copy, nonatomic) NSString *markCharacter;
@property (strong, nonatomic) UIFont *markFont;
@property (strong, nonatomic) UIImage *markImage;
@property (strong, nonatomic) IBInspectable UIColor *baseColor;
@property (strong, nonatomic) IBInspectable UIColor *highlightColor;
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat stepInterval;
@property (nonatomic) IBInspectable CGFloat minimumValue;

@end
