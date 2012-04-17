//
//  ViewController.m
//  TotangoTest
//
//  Copyright (c) 2012 Totango Inc. All rights reserved.
//

#import "Totango.h"
#import "ViewController.h"

typedef enum
{
  AlertViewMode_Login
} AlertViewMode;


@implementation ViewController

-(void)viewDidLoad
{
  self.title = @"Totango API Sample";
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Define serviceID"
                                                      message:@"Don't forget to define your serviceID: SP-xxxx-xx"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  
  [alertView show];
  [alertView release];
}

-(IBAction)login
{
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login"
                                                      message:@"\n\n\n"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Login", nil];
  
  UITextField *accountIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
  
  accountIdTextField.text = @"Zendesk";
  
  [accountIdTextField setBackgroundColor:[UIColor whiteColor]];
  
  accountIdTextField.tag = 100;
  
  UITextField *userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 80.0, 260.0, 25.0)];
  
  userNameTextField.text = @"mike@zendesk.com";
  
  [userNameTextField setBackgroundColor:[UIColor whiteColor]];
  
  userNameTextField.tag = 101;
  
  alertView.tag = AlertViewMode_Login;
  
  [alertView addSubview:accountIdTextField];
  [alertView addSubview:userNameTextField];
  [alertView show];
  [alertView release];

  [accountIdTextField release];  
  [userNameTextField release];  
}

-(IBAction)newProject
{
  [self trackActivity:@"New Project" module:@"Project Management"];
}

-(IBAction)newTask
{
  [self trackActivity:@"New Task" module:@"Project Management"];
}

-(IBAction)shareProject
{
  [self trackActivity:@"Share Project" module:@"Project Management"];
}

-(IBAction)setAccountAttributes
{
  if (!loggedIn)
  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please login first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
    return;
  }
  
  NSMutableDictionary* attributes = [[NSMutableDictionary alloc] init];
  
  [attributes setValue:@"Evon Barksdale" forKey:@"Sales Manager"];
  [attributes setValue:@"Adwords12345" forKey:@"Source Campaign"];
  [attributes setValue:@"Baltimore" forKey:@"Region"];
  
  NSError* error = nil;
  
  if (![[Totango sharedTracker] updateAttributes:attributes error:&error])
    NSLog (@"Error while updating attribute: %@", error);
  
  [attributes release];

  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Called method"
                                                      message:@"[[Totango sharedTracker] updateAtributes:error:]"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  
  [alertView show];
  [alertView release];
}

-(IBAction)addMilestone
{
  [self trackActivity:@"Add Milestone" module:@"Project Management"];
}

-(IBAction)addTimesheet
{
  [self trackActivity:@"Add Timesheet" module:@"Project Management"];
}

-(void)trackActivity:(NSString*)activity module:(NSString*)module
{
  if (!loggedIn)
  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please login first"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
  
    [alertView show];
    [alertView release];
    return;
  }
  
  NSError* error = nil;
  
  if (![[Totango sharedTracker] track:activity module:module error:&error])
    NSLog (@"Error while tracking: %@", error);
  
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Called method"
                                                      message:[NSString stringWithFormat:@"[[Totango sharedTracker] track:@\"%@\" module:@\"%@\" error:nil]", activity, module]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
  
  [alertView show];
  [alertView release];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (!buttonIndex)
    return;
  
  switch (alertView.tag)
  {
    case AlertViewMode_Login:
    {
      UITextField* accountIDTextField = (UITextField*)[alertView viewWithTag:100];
      UITextField* userNameTextField  = (UITextField*)[alertView viewWithTag:101];
     
      [[Totango sharedTracker] identify:accountIDTextField.text userName:userNameTextField.text];
      
      loggedIn = YES;
      
      [self trackActivity:@"Login" module:@"Project Management"];
      
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Called method"
                                                          message:[NSString stringWithFormat:@"[[Totango sharedTracker] identify:@\"%@\" userName:@\"%@\"]", accountIDTextField.text, userNameTextField.text]
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
      
      [alertView show];
      [alertView release];
    }
  }
}

@end
