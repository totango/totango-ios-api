//
//  Totango.h
//  Totango iOS SDK
//  Version 1.0
//
//  Copyright (c) 2012 Totango Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TotangoImpl;

@interface Totango : NSObject
{
  @private
    TotangoImpl* impl;
}

// Totango service ID (the string that begins with "SP-xxxx-xx")
@property (retain) NSString* serviceID; 

// Singleton instance of this class for convenience. You need to setup serviceID before calling any other methods.
+(Totango*)sharedTracker;

// Setup organization and user name for further requests.
-(void)identify:(NSString*)accountID
       userName:(NSString*)userName;

// Track a user activity. Returns TRUE on success, FALSE on failure. Throws exception if user name was not setted in identify call.
-(BOOL)track:(NSString*)activity
      module:(NSString*)module
      error:(NSError**)error;

// Track a user activity. Returns TRUE on success, FALSE on failure
-(BOOL)track:(NSString*)activity
      module:(NSString*)module
   accountID:(NSString*)accountID
    userName:(NSString*)userName
       error:(NSError**)error;

//Update attributes.
-(BOOL)updateAttributes:(NSDictionary*)attributes
                  error:(NSError**)error;

@end
