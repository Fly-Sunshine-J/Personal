//
//  BeerDetails+CoreDataProperties.h
//  
//
//  Created by vcyber on 16/5/30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BeerDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface BeerDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSManagedObject *beer;

@end

NS_ASSUME_NONNULL_END
