//
//  AXRatingView.h
//

#import <UIKit/UIKit.h>

// TODO: reserved
/*
typedef NS_ENUM(NSUInteger, AXMarkerType) { AXMarkerTypeCharacter = 0, AXMarkerTypeImage = 1 };

extern NSString *const AXMarkerTypeKey; // Required, AXMarkerTypeImage always has a higher priority than AXMarkerTypeCharacter
 */

// AXMarkerTypeCharacter
extern NSString *const AXMarkerHighlightCharacterKey; // Optional, will be used if provided
extern NSString *const AXMarkerMaskCharacterKey; // Required
extern NSString *const AXMarkerCharacterFontKey; // Optional, [UIFont systemFontOfSize:22.0] is used if not provided

// AXMarkerTypeImage
extern NSString *const AXMarkerHighlightImageKey; // Optional, will be used if provided
extern NSString *const AXMarkerMaskImageKey; // Required

extern NSString *const AXMarkerBaseColorKey; // Optional, [UIColor darkGrayColor] is used if not provided
extern NSString *const AXMarkerHighlightColorKey; // Optional, [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0] is used if not provided

IB_DESIGNABLE
@interface AXRatingView : UIControl {
    CALayer *_maskLayer;
    CALayer *_highlightLayer;
    UIImage *_maskImage;
    UIImage *_highlightImage;
}

@property (nonatomic) IBInspectable NSUInteger numberOfStar;

@property(nonatomic,getter=isContinuous) BOOL continuous; // if YES, value change events are sent any time the value changes during interaction. default = YES

// Configuration Dictionary
@property (copy, nonatomic) NSDictionary *markerDict;

// AXMarkerTypeCharacter
@property (readonly, nonatomic) NSString *highlightCharacter;
@property (readonly, nonatomic) NSString *maskCharacter;
@property (readonly, nonatomic) UIFont *markerFont;

// AXMarkerTypeImage
@property (readonly, nonatomic) UIImage *highlightImage;
@property (readonly, nonatomic) UIImage *maskImage;

@property (readonly, nonatomic) UIColor *baseColor;
@property (readonly, nonatomic) UIColor *highlightColor;

// Value
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat stepInterval;
@property (nonatomic) IBInspectable CGFloat minimumValue;

@end
