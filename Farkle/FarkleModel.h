//
//  FarkleModel.h
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FarkleModel : NSObject

@property int playerScore;
@property int computerScore;
@property NSString *username;

- (id)initGame;
- (int)rollDice;
- (void)resetDice;
- (int)getDieValue:(int)d;
- (BOOL)isDieActive:(int)d;
- (int)countActiveDice;
- (void)loadOpponents;

@end
