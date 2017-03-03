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

@property (nonatomic) NSMutableSet *selectedRows;

@property (nonatomic) Receipt *receiptToAdd;
@property (nonatomic) Tag *tagToAdd;


@end

@implementation AddReceiptsViewController

static NSString const *TagsIdentifier = @"tagCell";

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.coreDataManager = [CoreDataStuff sharedInstance];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    self.selectedRows = [[NSMutableSet alloc] init];
    
    

}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)addButtonPressed:(id)sender {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    self.receiptToAdd = [[Receipt alloc] initWithEntity:entity insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
    
    [self.receiptToAdd setValue:self.amountTF.text forKey:@"amount"];
    [self.receiptToAdd setValue:self.noteTF.text forKey:@"note"];
    [self.receiptToAdd setValue:self.receiptDP.date forKey:@"timeStamp"];
    
    [self.receiptToAdd addReceiptToTag:self.selectedRows];
    
    [self.coreDataManager.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coreDataManager.fetchedTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell" forIndexPath:indexPath];
    Tag *thisTag = self.coreDataManager.fetchedTags[indexPath.row];
    
    cell.textLabel.text = thisTag.tagName;
    
    if ([self.selectedRows containsObject:thisTag]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    Tag *thisTag = self.coreDataManager.fetchedTags[indexPath.row];
    
    if ([self.selectedRows containsObject:thisTag]) {
        
        [self.selectedRows removeObject:thisTag];
 
    } else {
        
        [self.receiptToAdd addReceiptToTagObject:thisTag];
        
        [self.selectedRows addObject:thisTag];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}





@end
