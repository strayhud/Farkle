//
//  FarkleViewController.m
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "FarkleViewController.h"
#import "FarkleModel.h"
#import "AVFoundation/AVAudioPlayer.h"

@interface FarkleViewController ()
@property (nonatomic,strong) FarkleModel *model;
@property (nonatomic,strong) NSArray *diceImages;
@property (nonatomic,strong) AVAudioPlayer *diceSound;
@property int turnTotal;
@end

@implementation FarkleViewController

@synthesize playerScore = _playerScore;
@synthesize computerScore = _computerScore;
@synthesize turnTotalField = _turnTotalField;
@synthesize dieImageDrop1;
@synthesize dieImageDrop2;
@synthesize dieImageDrop3;
@synthesize dieImageDrop4;
@synthesize dieImageDrop5;
@synthesize dieImageDrop6;
@synthesize rollButton;
@synthesize bankButton;
@synthesize turnTotal;
@synthesize quitButton;

int WINNING_SCORE = 10000;

// Farkle Data Model
@synthesize model = _model;
- (FarkleModel *) model
{
    if (!_model) _model = [[FarkleModel alloc]initGame];
    return _model;
}

// Images of Dice
@synthesize diceImages = _diceImages;
- (NSArray *) diceImages
{    
    if (!_diceImages)
         _diceImages =
            [NSArray arrayWithObjects:
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die1" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die2" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die3" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die4" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die5" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die6" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die7" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die8" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die9" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die10" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die11" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die12" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die13" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die14" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die15" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die16" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die17" ofType:@"png"]],
            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"die18" ofType:@"png"]],
            nil];
    return _diceImages;
}

@synthesize diceSound = _diceSound;
- (AVAudioPlayer *) diceSound
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DiceRoll" ofType:@"mp3"];
    _diceSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    return _diceSound;
}

// Use the following in viewDidLoad to fix issue with missing rounded buttons in iOS7.
- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *btnLayer = [rollButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [bankButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    btnLayer = [quitButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];

}

-(void)resetBoard
{
    [self.model resetDice];
    self.turnTotalField.text = @"";
    [self setDieImage:dieImageDrop1 :0 :0];
    [self setDieImage:dieImageDrop2 :1 :0];
    [self setDieImage:dieImageDrop3 :2 :0];
    [self setDieImage:dieImageDrop4 :3 :0];
    [self setDieImage:dieImageDrop5 :4 :0];
    [self setDieImage:dieImageDrop6 :5 :0];
}

-(void)pause
{
    // pause function used from performSelector with delay
}

-(void) computerTurn
{
    
    BOOL done = NO;

    NSLog(@"Computer Turn-------");
    
    while (done==NO) {
        [self rollPressed:self];
        if (turnTotal==0)
            done = YES;
        
        NSLog(@"TurnTotal=%d",turnTotal);
        
        int diceLeft = [self.model countActiveDice];
        int delta = self.model.playerScore-self.model.computerScore;
        
        switch (diceLeft) {
            case 1:
                done = YES;
                break;
            case 2:
                if (turnTotal>300)
                    done = YES;
                break;
            case 3:
                if (turnTotal>400)
                    done = YES;
                // The following can only occur after scoring all 6 dice at least once and cause the
                // computer to get cautious if he's built a big score.  Unless he's a long way behind
                // in which case he will go for it.  Comment these out for a hard computer brain and he
                // always goes for it.
            case 4:
                if (turnTotal>600 && turnTotal>delta/2)
                    done = YES;
            case 5:
                if (turnTotal>800 && turnTotal>delta/2)
                    done = YES;
            default:
                break;
        }
        
        // Pause to let display update between computer rolls...not really working
        [self performSelector:@selector(pause) withObject:nil afterDelay:2.0];
        
    }
    
    if (turnTotal==0)
        self.turnTotalField.text = @"Computer Farkled!";
    else
        self.turnTotalField.text = [NSString stringWithFormat:@"Computer Scored %i", turnTotal];
    
    self.model.computerScore += turnTotal;
    turnTotal = 0;
    
    self.computerScore.text = [NSString stringWithFormat:@"%i", self.model.computerScore];
  
    if (self.model.computerScore>=WINNING_SCORE) {
        self.turnTotalField.text = @"Computer Won!";
        self.model.playerScore = 0;
        self.model.computerScore = 0;
    } else {
        [self performSelector:@selector(resetBoard) withObject:nil afterDelay:2.0];
    }
  
}

- (void) setDieImage:(UIImageView*)drop : (int)dieIndex : (int)total
{
    int offset;
    if ([self.model isDieActive:dieIndex]) {
        offset = -1;
    }
    else {
        offset = 5;
        if (total==0) offset += 6;
    }
    drop.image = self.diceImages[[self.model getDieValue:dieIndex]+offset];
}

- (IBAction)quitPressed:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)rollPressed:(id)sender {    
    int t = [self.model rollDice];

    [self setDieImage:dieImageDrop1 :0 :t];
    [self setDieImage:dieImageDrop2 :1 :t];
    [self setDieImage:dieImageDrop3 :2 :t];
    [self setDieImage:dieImageDrop4 :3 :t];
    [self setDieImage:dieImageDrop5 :4 :t];
    [self setDieImage:dieImageDrop6 :5 :t];
    self.playerScore.text = [NSString stringWithFormat:@"%i", self.model.playerScore];
    self.computerScore.text = [NSString stringWithFormat:@"%i", self.model.computerScore];

    [self.diceSound play];

    if (t!=0) {
        turnTotal += t;
        self.turnTotalField.text = [NSString stringWithFormat:@"%i", turnTotal];
    } else {
        turnTotal = 0;
        [self.model resetDice];
        self.turnTotalField.text = @"";
        if (sender!=self) {
            self.turnTotalField.text = @"You Farkled!";
            [self performSelector:@selector(computerTurn) withObject:nil afterDelay:2.0];
        }
    }
        
}

- (IBAction)donePressed:(id)sender {
    self.model.playerScore += turnTotal;
    turnTotal = 0;

    self.playerScore.text = [NSString stringWithFormat:@"%i", self.model.playerScore];

    [self resetBoard];
    if (self.model.playerScore>=WINNING_SCORE) {
        self.turnTotalField.text = @"You Win!";
        self.model.playerScore = 0;
        self.model.computerScore = 0;
    } else {
        [self computerTurn];
    }
}

@end
