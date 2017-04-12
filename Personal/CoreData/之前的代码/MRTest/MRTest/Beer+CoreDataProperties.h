//
//  Beer+CoreDataProperties.h
//  
//
//  Created by vcyber on 16/5/30.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Beer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Beer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) BeerDetails *beerDetails;

@end

NS_ASSUME_NONNULL_END
