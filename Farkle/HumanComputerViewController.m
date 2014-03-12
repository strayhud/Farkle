//
//  HumanComputerViewController.m
//  Farkle
//
//  Created by Steve Hudson on 10/15/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "HumanComputerViewController.h"

@interface HumanComputerViewController ()

@end

@implementation HumanComputerViewController

@synthesize backButton;
@synthesize humanButton;
@synthesize computerButton;

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
    CALayer *btnLayer = [backButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [humanButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [computerButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

- (IBAction)backPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
