//
//  EZRatingView.h
//

#import <UIKit/UIKit.h>

// TODO: reserved
/*
typedef NS_ENUM(NSUInteger, EZMarkerType) { EZMarkerTypeCharacter = 0, EZMarkerTypeImage = 1 };

extern NSString *const EZMarkerTypeKey; // Required, EZMarkerTypeImage always has a higher priority than EZMarkerTypeCharacter
 */

// EZMarkerTypeCharacter
extern NSString *const EZMarkerHighlightCharacterKey; // Optional, will be used if provided
extern NSString *const EZMarkerMaskCharacterKey; // Required
extern NSString *const EZMarkerCharacterFontKey; // Optional, [UIFont systemFontOfSize:22.0] is used if not provided

// EZMarkerTypeImage
extern NSString *const EZMarkerHighlightImageKey; // Optional, will be used if provided
extern NSString *const EZMarkerMaskImageKey; // Required

extern NSString *const EZMarkerBaseColorKey; // Optional, [UIColor darkGrayColor] is used if not provided
extern NSString *const EZMarkerHighlightColorKey; // Optional, [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0] is used if not provided

IB_DESIGNABLE
@interface EZRatingView : UIControl {
    CALayer *_maskLayer;
    CALayer *_highlightLayer;
    UIImage *_maskImage;
    UIImage *_highlightImage;
}

@property (nonatomic) IBInspectable NSUInteger numberOfStar;

@property(nonatomic,getter=isContinuous) BOOL continuous; // if YES, value change events are sent any time the value changes during interaction. default = YES

// Configuration Dictionary
@property (copy, nonatomic) NSDictionary *markerDict;

// EZMarkerTypeCharacter
@property (readonly, nonatomic) NSString *highlightCharacter;
@property (readonly, nonatomic) NSString *maskCharacter;
@property (readonly, nonatomic) UIFont *markerFont;

// EZMarkerTypeImage
@property (readonly, nonatomic) UIImage *highlightImage;
@property (readonly, nonatomic) UIImage *maskImage;

@property (readonly, nonatomic) UIColor *baseColor;
@property (readonly, nonatomic) UIColor *highlightColor;

// Value
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat stepInterval;
@property (nonatomic) IBInspectable CGFloat minimumValue;

@end
