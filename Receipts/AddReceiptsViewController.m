//
//  AddReceiptsViewController.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "AddReceiptsViewController.h"

@interface AddReceiptsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *noteTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *receiptDP;
@property (weak, nonatomic) IBOutlet UITableView *addTableView;


@end

@implementation AddReceiptsViewController

static NSString const *TagsIdentifier = @"tagCell";

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.coreDataManager = [CoreDataStuff sharedInstance];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard
{
    [self.noteTF resignFirstResponder];
}

- (IBAction)addButtonPressed:(id)sender {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    NSManagedObject *receiptObject = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
    
    [receiptObject setValue:self.amountTF.text forKey:@"amount"];
    [receiptObject setValue:self.noteTF.text forKey:@"note"];
    [receiptObject setValue:self.receiptDP.date forKey:@"timeStamp"];
    
    [self.coreDataManager.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coreDataManager.fetchedTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.addTableView dequeueReusableCellWithIdentifier:@"tagCell" forIndexPath:indexPath];
    
   
    Tag *thisTag = self.coreDataManager.fetchedTags[indexPath.row];
    
    cell.textLabel.text = thisTag.tagName;
    R
    return cell;
    
}


@end
