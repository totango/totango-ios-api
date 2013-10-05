//
//  Totango.h
//  Totango iOS SDK
//  Version 1.0
//
//  Copyright (c) 2013 Totango Inc. All rights reserved.
//

#import "Totango.h"

static NSString* TOTANGO_BASE_URL = @"https://sdr.totango.com/pixel.gif/?";

static Totango* sharedTracker = nil;

@interface TotangoImpl : NSObject
{
  @private
    NSString* serviceID;
    NSString* accountID;
    NSString* userName;
}

@property (retain) NSString* serviceID;
@property (retain) NSString* accountID;
@property (retain) NSString* userName;

@end

@implementation TotangoImpl

@synthesize serviceID, accountID, userName;

-(void)dealloc
{
  self.serviceID = nil;
  self.accountID = nil;
  self.userName  = nil;
  
  [super dealloc];
}

@end

@implementation Totango

-(void)dealloc
{
  [impl release];
  
  [super dealloc];
}

-(id)init
{
  self = [super init];
  
  if (!self)
    return nil;

  impl = [[TotangoImpl alloc] init];
  
  if (!impl)
  {
    [self release];
    return nil;
  }
  
  return self;
}

-(void)setServiceID:(NSString*)serviceID
{
  impl.serviceID = serviceID;
}

-(NSString*)serviceID
{
  return impl.serviceID;
}

// Singleton instance of this class for convenience.
+(Totango*)sharedTracker
{
  @synchronized(self) 
  {
    if (!sharedTracker) 
    {
      sharedTracker = [[Totango alloc] init];
    }
  }
  
  return sharedTracker;
}

// Setup organization and user name for further requests.
-(void)identify:(NSString*)accountID
       userName:(NSString*)userName
{
  impl.accountID = accountID;
  impl.userName  = userName;
}

// Track a user activity. Returns TRUE on success, FALSE on failure.
-(BOOL)track:(NSString*)activity
      module:(NSString*)module
       error:(NSError**)error
{
  if (!impl.serviceID)
    [NSException raise:@"Invalid operation" format:@"ServiceID not setted"];

  if (!impl.userName)
  {
    if (error)
      *error = [NSError errorWithDomain:@"userName not setted with identify:userName:" code:1 userInfo:nil];
    
    return NO;
  }
  
  NSString* URLString = [NSString stringWithFormat:@"%@sdr_s=%@&sdr_o=%@&sdr_u=%@&sdr_a=%@&sdr_m=%@", 
                         TOTANGO_BASE_URL, impl.serviceID, impl.accountID ? impl.accountID : @"", 
                         impl.userName, activity, module];
  NSURL* URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  return [NSData dataWithContentsOfURL:URL options:0 error:error] != nil;
}

// Track a user activity. Returns TRUE on success, FALSE on failure
-(BOOL)track:(NSString*)activity
      module:(NSString*)module
   accountID:(NSString*)accountID
    userName:(NSString*)userName
       error:(NSError**)error
{
  if (!impl.serviceID)
    [NSException raise:@"Invalid operation" format:@"ServiceID not setted"];

  NSString* URLString = [NSString stringWithFormat:@"%@sdr_s=%@&sdr_o=%@&sdr_u=%@&sdr_a=%@&sdr_m=%@", 
                         TOTANGO_BASE_URL, impl.serviceID, accountID, userName, activity, module];
  NSURL* URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

  return [NSData dataWithContentsOfURL:URL options:0 error:error] != nil;
}

//Update attributes.
-(BOOL)updateAttributes:(NSDictionary*)attributes
                  error:(NSError**)error
{
  if (!impl.serviceID)
    [NSException raise:@"Invalid operation" format:@"ServiceID not setted"];
  
  if (![attributes count])
    [NSException raise:@"Invalid argument" format:@"Empty attributes dictionary"];
  
  NSMutableString* URLString = [NSMutableString stringWithCapacity:64];
  
  [URLString appendFormat:@"%@sdr_s=%@", TOTANGO_BASE_URL, impl.serviceID];
  [URLString appendFormat:@"&sdr_o=%@", [impl.accountID length] ? impl.accountID : @""];
  
  NSEnumerator *enumerator = [attributes keyEnumerator];
  id key;
  
  while ((key = [enumerator nextObject]))
    [URLString appendFormat:@"&sdr_o.%@=%@", key, [attributes valueForKey:key]];
  
  NSURL* URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  return [NSData dataWithContentsOfURL:URL options:0 error:error] != nil;
}

@end
