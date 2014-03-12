//
//  ScoreViewController.m
//  Farkle
//
//  Created by Steve Hudson on 10/14/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

@synthesize okButton;


- (IBAction)okPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *btnLayer = [okButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}


@end
