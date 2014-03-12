//
//  ScoreTableView.m
//  Farkle
//
//  Created by Steve Hudson on 10/14/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "ScoreTableView.h"

@implementation ScoreTableView

NSArray *tableData = Nil;

- (void)awakeFromNib
{
    NSLog(@"Awaking from NIB");
    tableData = [NSArray arrayWithObjects:@"Steve Hudson", @"Nate Isley", @"Abishek Goswami", @"Ankur Somani", @"Tim Hoover", @"David Yu", @"Bill Fried", @"Ryan Vesley", @"Seth Schwartzman", @"Michael Sage",@"Steve Hudson", @"Nate Isley", @"Abishek Goswami", @"Ankur Somani", @"Tim Hoover", @"David Yu", @"Bill Fried", @"Ryan Vesley", @"Seth Schwartzman", @"Michael Sage",
                 nil];
    
    self.delegate = self;
    self.dataSource = self;
    [self reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    nameLabel.text = [tableData objectAtIndex:indexPath.row];
    
    UILabel *scoreLabel = (UILabel *)[cell viewWithTag:101];
    scoreLabel.text = @"100";
    
    return cell;
}

@end
