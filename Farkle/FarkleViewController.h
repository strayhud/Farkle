//
//  FarkleViewController.h
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FarkleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *computerScore;
@property (weak, nonatomic) IBOutlet UILabel *turnTotalField;

@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop1;
@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop2;
@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop3;
@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop4;
@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop5;
@property (weak, nonatomic) IBOutlet UIImageView *dieImageDrop6;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;

@end
