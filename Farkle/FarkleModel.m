//
//  FarkleModel.m
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "FarkleModel.h"
#import "DieObject.h"

@interface FarkleModel()
@end

@implementation FarkleModel

@synthesize playerScore;
@synthesize computerScore;
@synthesize username;

DieObject *die[6];
int tripleCounts[6];

- (id)initGame
{
    self = [self init];
    for (int i=0; i<6; i++) {
        die[i] = [[DieObject alloc] init];
        [die[i] setActive:YES];
    }
    
    username = NULL;
    
    return self;
}

- (void)resetTripleCounts
{
    for (int i=0; i<6; i++)
        tripleCounts[i] = 0;
}

- (int)countActiveDice
{
    int count = 0;
    for (int i=0; i<6; i++) {
       if (die[i].active==YES)
           count++;
    }
    return count;
}

- (void)resetDice
{
    for (int i=0; i<6; i++) {
        [die[i] setActive:YES];
    }
    
}
- (int)getDieValue:(int)d
{
    return die[d].value;
}

- (BOOL)isDieActive:(int)d
{
    return die[d].active==YES;
}

- (int) calcScore
{
    int total=0;
    NSLog(@"------------");
    // First see if there are any triples
    for (int i=0; i<6; i++) {

        if (tripleCounts[i]>2) {
            NSLog(@"TripleCount[%d]=%d",i+1,tripleCounts[i]);
            
            if (i==0)
                total=1000;  // Score 1000 for 3 1's
            else
                total += ((i+1)*100);  // Score 100 x the number for everything else
            
            // 2x for 4 of a kind, 4x for 5 of a kind, 8x for 6 of a kind
            if (tripleCounts[i]>3)
                total *=2;
            if (tripleCounts[i]>4)
                total *=2;
            if (tripleCounts[i]>5)
                total *=2;
            
            for (int j=0; j<6; j++) {
                if (die[j].active) {
                    if (die[j].value==i+1) {
                        [die[j] setActive:NO];
                    }
                }
            }
        }
    }
    
    // Add any remaining 1's and 5's
    for (int i=0; i<6; i++) {
        if (die[i].active) {
            if (die[i].value==1 || die[i].value==5) {
                NSLog(@"adding single %d",die[i].value);
                [die[i] setActive:NO];
                if (die[i].value==1) total+=100;
                if (die[i].value==5) total+=50;
            }
        }
    }
    return total;
}


- (int)rollDice
{
    if ([self countActiveDice]==0)
        [self resetDice];
    [self resetTripleCounts];
    for (int i=0; i<6; i++) {
        if (die[i].active) {
            [die[i] roll];
            tripleCounts[die[i].value-1]++;
        }
    }
    return [self calcScore];
}

- (void)loadOpponents
{
    
}


@end
