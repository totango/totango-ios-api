Getting Started

Requirements

To integrate Totango tracking capabilities with your iOS app, you will need the following:
iOS developer SDK
Totango iOS SDK 

Setup
Open Xcode and create a new iPhone OS project. 
Drag Totango.h and Totango.m from the SDK's directory into your new project.

The Totango SDK should work with any iPhone or iPod Touch running iOS 2.0 or higher.

An example application is included with the SDK. 

Using the SDK

Initialize tracker by setting serviceID property on the tracker singleton obtained via [Totango sharedTracker]. It is often convenient to call this method directly in the applicationDidFinishLaunching method of your app's delegate. If you are using same account ID and user name for your calls it is also good place to set it. Use identify:userName: method to save this attributes in Totango object. For example:

#import "AppDelegate.h"
#import "ViewController.h"
#import "Totango.h"

static NSString* TOTANGO_SERVICE_ID = @"SP-18030-01";
static NSString* TOTANGO_ACCOUNT_ID = @"TestAccount";
static NSString* TOTANGO_USER_NAME  = @"TestUser";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //Setup Totango service-id
  [Totango sharedTracker].serviceID = TOTANGO_SERVICE_ID;
  [[Totango sharedTracker] identify:TOTANGO_ACCOUNT_ID userName:TOTANGO_USER_NAME];
  
  [window release];
  window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  UIViewController* viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  
  [rootNavigationController release];
  rootNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
  
  [viewController release];
  
  rootNavigationController.navigationBarHidden = YES;
  
  [window addSubview:rootNavigationController.view];
  [window makeKeyAndVisible];
  
  return YES;
}

- (void)dealloc
{
  [window                   release];
  [rootNavigationController release];
  
  [super dealloc];
}

@end

Tracking

To track user activity  simply call method track:module:error: if you want to use account ID and user name stored with previous call to identify:userName:. If you want to override stored account ID and user name - use track:module:accountID:userName:error: method. This methods are blocking, so with a slow network it may take some time. This methods returns operation result. Also if you are interested which error occurred you can optionally pass pointer to NSError which will be filled with error description in case of negative result. For example:

NSError* error = nil;
  
if (![[Totango sharedTracker] track:activityName module:moduleName error:&error])
  NSLog (@"Error while tracking: %@", error);


Setting Account Attributes

To update account attributes use method updateAttributes:error: which treats dictionary keys as attributes' names and values as attributes' values.

NSError* error = nil;
  
if (![[Totango sharedTracker] updateAttributes:[NSDictionary dictionaryWithObject:attributeValue forKey:attributeName] error:&error])
  NSLog (@"Error while updating attribute: %@", error);
