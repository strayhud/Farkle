//
//  MainViewController.m
//  Farkle
//
//  Created by Steve Hudson on 10/14/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize rulesButton;
@synthesize highScoreButton;
@synthesize gameButton;

// Use the following in viewDidLoad to fix issue with missing rounded buttons in iOS7.
- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *btnLayer = [gameButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [highScoreButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [rulesButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    //[self performSegueWithIdentifier:@"signin-segue" sender:self];
}
    
@end


