//
//  CoreDataStuff.m
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "CoreDataStuff.h"

@interface CoreDataStuff()



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
    
    NSArray *arrayOfReceipts = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    arrayOfReceipts = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    

    self.fetchedReceipts = arrayOfReceipts;
    
    return arrayOfReceipts;
    
}

-(NSArray *)fetchTags {
    
    NSArray *arrayOfTags;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    arrayOfTags = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

    if (arrayOfTags.count == 0 || arrayOfTags == nil) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        
        Tag *personal = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        personal.tagName = @"Personal";
        
        Tag *family = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        family.tagName = @"Family";
        
        Tag *business = [[Tag alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        business.tagName = @"Business";
        
        arrayOfTags = @[personal, family, business];
        
        
        [self.managedObjectContext save:nil];
    
    }
    
    self.fetchedTags = arrayOfTags;
    
    return arrayOfTags;
}



@end
