//
//  HumanSelectViewController.h
//  Farkle
//
//  Created by Steve Hudson on 10/21/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumanSelectViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *jsonDict;
    NSArray *userlist;
    NSURL *url;
}

@property (weak, nonatomic) IBOutlet UITextField *playerName;
@property (weak, nonatomic) IBOutlet UITableView *opponentList;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
