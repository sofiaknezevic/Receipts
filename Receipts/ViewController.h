//
//  ViewController.h
//  Receipts
//
//  Created by Sofia Knezevic on 2017-03-02.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipts+CoreDataModel.h"
#import "CoreDataStuff.h"

@interface ViewController : UIViewController

@property (nonatomic) CoreDataStuff *coreDataManager;

@end

