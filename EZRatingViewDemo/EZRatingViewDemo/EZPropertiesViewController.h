//
//  EZPropertiesViewController.h
//  EZRatingViewDemo
//

#import <UIKit/UIKit.h>
#import "EZRatingView/EZRatingView.h"

@interface EZPropertiesViewController : UIViewController

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) EZRatingView *ratingView;
@property (strong, nonatomic) UISlider *slider;

@end
