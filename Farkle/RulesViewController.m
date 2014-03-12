//
//  RulesViewController.m
//  Farkle
//
//  Created by Steve Hudson on 10/15/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "RulesViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

@synthesize okButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *btnLayer = [okButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

- (IBAction)okPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
