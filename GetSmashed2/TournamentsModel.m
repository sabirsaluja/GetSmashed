//
//  TournamentsModel.m
//  GetSmashed
//
//  Created by Sabir Saluja on 12/2/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import "TournamentsModel.h"
#import "Tournament.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface TournamentsModel ()

// NSMutable Array for tournaments
@property (strong, nonatomic) NSString* accessToken;
@property NSString* filepath;
@end

@implementation TournamentsModel

- (instancetype) init {
    
    self = [super init];
    if (self) {
        self.tournaments = [[NSMutableArray alloc] init];
        self.currentTournament = [[Tournament alloc] init];
        self.attendedTournaments = [[NSMutableArray alloc] init];
        //NSLog(@"Test: init currentTournament.");
        
        // Attended tournaments data persistence
        NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _filepath = [NSString stringWithFormat: @"%@/%@", [filePaths objectAtIndex:0], @"AttendedTournamentPLIST.plist"];
        NSLog(@"filepath %@", _filepath);
        
        NSMutableArray *fileTournaments = [[NSMutableArray alloc] initWithContentsOfFile:self.filepath];
        if ([fileTournaments count] != 0) {
            NSMutableArray *fileTournaments = [NSMutableArray arrayWithContentsOfFile:self.filepath];
            NSDictionary* tournament;
            Tournament *addTournament;
            for (tournament in fileTournaments) {
                addTournament = [[Tournament alloc] initWithDictionary:tournament];
                [_attendedTournaments addObject:addTournament];
            }
        }
    
    }
    
    return self;
}

+ (instancetype) sharedModel {
    
    static TournamentsModel* _sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once, thread safe
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}


// Set the current tournament in the model
- (void) setCurrentTournament:(Tournament *)tournament {
    
    _currentTournament = tournament; 
}


// Add to the Mutable array of already attended tournaments
- (void) addToAttendedTournaments:(Tournament *)tournament {
    
    [_attendedTournaments addObject:tournament];
    [self save];
}

// Save it into the plist
- (void) save {
    NSMutableArray* tournaments = [[NSMutableArray alloc] init];
    Tournament* tournament;
    for (tournament in _attendedTournaments) {
        [tournaments addObject:[tournament dictionary]];
    }
    [tournaments writeToFile:self.filepath atomically:YES];
    NSLog(@"Dictionary: %@", [tournament dictionary]);
}


- (void) insertTournament:(Tournament*) tournament {
    
    Tournament* newTournament = [[Tournament alloc] init];
    newTournament = tournament;
    [self.tournaments addObject:tournament]; 
}

- (NSMutableArray* ) getTournamentsArray {
    
    return self.tournaments; 
}


- (Tournament* ) tournamentAtIndex:(NSUInteger) index {
    if ([self.tournaments count] > 0) {
        return [self.tournaments objectAtIndex:index];
    }
    else {
        NSLog(@"No tournament at index.");
        return nil;
    }
}


- (NSInteger) numberOfTournaments {
    
    return [self.tournaments count];
}

// Remove the last tournament in the NSMutableArray
- (void) removeTournament {
    if ([self.tournaments count] > 0) {
        [self.tournaments removeLastObject];
    }
}

- (void) removeTournamentAtIndex:(NSUInteger) index {
    
    if (index < [self.tournaments count]) {
        [self. tournaments removeObjectAtIndex:index];
    }
    else {
        NSLog(@"Index is greater than the number of tournaments.");
    }
}




@end
