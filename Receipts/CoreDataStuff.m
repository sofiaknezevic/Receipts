//
//  CoreDataStuff.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "CoreDataStuff.h"

@interface CoreDataStuff()

@property (nonatomic) Tag *personal;
@property (nonatomic) Tag *business;
@property (nonatomic) Tag *family;

@end

@implementation CoreDataStuff

+ (instancetype)sharedInstance
{
    static CoreDataStuff *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataStuff alloc] init];
        
    });
    
    return sharedInstance;
}


-(NSArray *)fetchReceipts {
    
    NSArray *arrayOfReceipts;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    arrayOfReceipts = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.fetchedReceipts = arrayOfReceipts;
    
    return arrayOfReceipts;
    
}

-(NSArray *)fetchTags {
    
    NSArray *arrayOfTags = [[NSArray alloc] init];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    arrayOfTags = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

    if (arrayOfTags.count == 0 || arrayOfTags == nil) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        
        self.personal = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        self.personal.tagName = @"Personal";
        
        self.family = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        self.family.tagName = @"Family";
        
        self.business = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        self.business.tagName = @"Business";
        
        arrayOfTags = @[self.personal, self.family, self.business];
        
        
        [self.managedObjectContext save:nil];
    
    }
    
    self.fetchedTags = arrayOfTags;
    
    return arrayOfTags;
}


@end
