//
//  ViewController.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *receiptsTableView;

@end

@implementation ViewController

- (IBAction)addReceiptButtonClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"addReceipts" sender:self];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.receiptsTableView dequeueReusableCellWithIdentifier:@"receiptCell" forIndexPath:indexPath];
    
    return cell;
    
    
}
@end
