//
//  CoreDataStuff.h
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Receipts+CoreDataModel.h"

@interface CoreDataStuff : NSObject

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) NSArray *fetchedTags;
@property (nonatomic) NSArray *fetchedReceipts;

+(instancetype)sharedInstance;
-(NSArray *)fetchReceipts;
-(NSArray *)fetchTags;



@end
