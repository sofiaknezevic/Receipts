//
//  ViewController.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "ViewController.h"
#import "AddReceiptsViewController.h"

#import "ReceiptTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *receiptsTableView;


@end

@implementation ViewController

static NSString *const AddReceiptSegue = @"addReceipts";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.coreDataManager = [CoreDataStuff sharedInstance];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.receiptsTableView reloadData];
}

- (IBAction)addReceiptButtonClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"addReceipts" sender:self];
    
}

#pragma mark - TableView -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.coreDataManager fetchReceipts]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReceiptTableViewCell *cell = [self.receiptsTableView dequeueReusableCellWithIdentifier:@"receiptCell" forIndexPath:indexPath];
    Receipt *newReceipt = [[self.coreDataManager fetchReceipts]objectAtIndex:indexPath.row];
    
    [cell configureCellWithReceipt:newReceipt];
    
    return cell;
    
    
}


#pragma mark - Segues -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:AddReceiptSegue]) {
        
        AddReceiptsViewController *addVC = [AddReceiptsViewController new];
        addVC = segue.destinationViewController;
        [self.receiptsTableView reloadData];
        
        
    }
    
}

@end
