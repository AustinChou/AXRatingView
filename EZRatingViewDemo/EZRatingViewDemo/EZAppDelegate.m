//
//  EZAppDelegate.m
//  EZRatingViewDemo
//

#import "EZAppDelegate.h"
#import "EZMenuViewController.h"

@implementation EZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  EZMenuViewController *menuViewCon = [[EZMenuViewController alloc] init];
  UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:menuViewCon];
  self.window.rootViewController = navCon;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
