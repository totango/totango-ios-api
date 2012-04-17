//
//  ViewController.h
//  TotangoTest
//
//  Copyright (c) 2012 Totango Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
  @private
    BOOL loggedIn;
}

-(IBAction)login;
-(IBAction)newProject;
-(IBAction)newTask;
-(IBAction)shareProject;
-(IBAction)setAccountAttributes;
-(IBAction)addMilestone;
-(IBAction)addTimesheet;

@end
