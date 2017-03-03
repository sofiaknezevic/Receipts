//
//  ReceiptTableViewCell.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "ReceiptTableViewCell.h"

@interface ReceiptTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;


@end

@implementation ReceiptTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)configureCellWithReceipt:(Receipt *)receipt
{
    self.coreDataManager = [CoreDataStuff sharedInstance];
    
    NSString *dateToDisplay = [self formatDateWithReceiptDate:receipt];
    
    self.dateLabel.text = dateToDisplay;
    
    self.amountLabel.text = receipt.amount;
    
}

- (NSString *)formatDateWithReceiptDate:(Receipt *)receipt
{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *displayedDate = [dateFormatter stringFromDate:receipt.timeStamp];
    
    return displayedDate;
    
}
@end
