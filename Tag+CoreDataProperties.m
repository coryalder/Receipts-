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
    
    
    // check if it exists already
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"tagName == %@", name];
    
    NSArray *existingTags = [context executeFetchRequest:fetchRequest error:NULL];
    
    if (existingTags.count > 0) {
        
        Tag *oldTag = [existingTags firstObject];
        // modify old tag if needed
        return oldTag;
    }
    
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context];
    
    Tag *newTag = [[Tag alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:context];
    
    newTag.tagName = name;
    
    [context save:nil];
    
    return newTag;
}

@end


