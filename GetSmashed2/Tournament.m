//
//  Tournament.m
//  GetSmashed
//
//  Created by Sabir Saluja on 12/2/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import "Tournament.h"

@implementation Tournament


- (instancetype) init:(NSString *)name latitude:(NSString *)latitude longitude:(NSString *)longitude attended:(BOOL *)attended {
    
    self = [super init];
    if (self) {
        
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
        self.attended = attended;
    }
    
    return self;
}

- (instancetype) initWithDictionary: (NSDictionary *) tournament {
    
    self = [super init];
    if (self) {
        _name = [tournament valueForKey:kNameKey];
        _latitude = [tournament valueForKey:kLatitudeKey];
        _longitude = [tournament valueForKey:kLongitudeKey];
        NSString* attendedString = [tournament valueForKey:kAttendedKey];
        if ([attendedString isEqualToString:kAttendedYES]) {
            _attended = YES;
        }
    }
    return self;
}

- (NSDictionary *) dictionary {
    
    NSString* attended = @"NO";
    if (self.attended) {
        attended = kAttendedYES;
    }
    
    NSDictionary *tournament = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.name, kNameKey,
                          self.latitude, kLatitudeKey,
                          self.longitude, kLongitudeKey,
                          attended, kAttendedKey, nil];
    
    for(NSString *key in [tournament allKeys]) {
        NSLog(@"%@:%@",key, [tournament objectForKey:key]);
    }
    return tournament;
}

@end

