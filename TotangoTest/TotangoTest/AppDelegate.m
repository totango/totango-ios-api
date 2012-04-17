//
//  AppDelegate.m
//  TotangoTest
//
//  Copyright (c) 2012 Totango Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Totango.h"

// Replace to your Service_ID
static NSString* TOTANGO_SERVICE_ID = @"SP-xxxx-xx";

@implementation AppDelegate

- (void)dealloc
{
  [window                   release];
  [rootNavigationController release];
  
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Setup Totango service-id
  [Totango sharedTracker].serviceID = TOTANGO_SERVICE_ID;
    
  [window release];
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  UIViewController* viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  
  [rootNavigationController release];
  rootNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  
  [viewController release];
  
  [window addSubview:rootNavigationController.view];
  [window makeKeyAndVisible];
  
  return YES;
}

@end
