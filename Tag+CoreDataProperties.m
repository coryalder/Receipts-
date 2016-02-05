//
//  Tag+CoreDataProperties.m
//  Receipts++
//
//  Created by Adam DesLauriers on 2016-02-04.
//  Copyright © 2016 Adam DesLauriers. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

@dynamic tagName;
@dynamic receipts;

+ (instancetype)createAndSaveTagWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context];
    
    Tag *newTag = [[Tag alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    [context save:nil];
    
    return newTag;
}

@end


