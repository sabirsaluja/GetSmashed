//
//  Tournament.h
//  GetSmashed
//
//  Created by Sabir Saluja on 12/2/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import <Foundation/Foundation.h>

// constants
static NSString * const kNameKey = @"name";
static NSString * const kLatitudeKey = @"latitude";
static NSString * const kLongitudeKey = @"longitude";
static NSString * const kAttendedKey = @"attended";
static NSString * const kAttendedYES = @"YES"; 

@interface Tournament : NSObject

// Public properties

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* latitude;
@property (strong, nonatomic) NSString* longitude; 
@property BOOL* attended;

// Methods for initializing tournament
- (instancetype) init: (NSString* ) name
                 //date: (NSDate* ) date
             latitude: (NSString* ) latitude
            longitude: (NSString* ) longitude
             attended: (BOOL*) attended;

- (instancetype) initWithDictionary: (NSDictionary *) tournament;
- (NSDictionary *) dictionary;

@end
