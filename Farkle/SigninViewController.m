//
//  SigninViewController.m
//  Farkle
//
//  Created by Steve Hudson on 1/3/14.
//  Copyright (c) 2014 Steve Hudson. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController ()

@end

@implementation SigninViewController

@synthesize username;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)usernameEntered:(id)sender {
    [username resignFirstResponder];
}
- (IBAction)passwordEntered:(id)sender {
    [username resignFirstResponder];
}
- (IBAction)submitButtonPressed:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
