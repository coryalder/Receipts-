//
//  LHLCoreDataStack.h
//  Receipts++
//
//  Created by Adam DesLauriers on 2016-02-04.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LHLCoreDataStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *mom;
@property (nonatomic, strong) NSPersistentStoreCoordinator *psc;


@end
