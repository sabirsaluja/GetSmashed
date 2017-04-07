//
//  TournamentsModel.h
//  GetSmashed
//
//  Created by Sabir Saluja on 12/2/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import <Foundation/Foundation.h>
#import "Tournament.h"

@interface TournamentsModel : NSObject

@property (nonatomic, readonly) NSUInteger currentIndex;
@property (strong, nonatomic) NSMutableArray* tournaments;
@property (strong, nonatomic) NSMutableArray* attendedTournaments;
@property (strong, nonatomic) Tournament* currentTournament;

// Creating the model
+ (instancetype) sharedModel;

// Other methods
- (NSInteger) numberOfTournaments;

- (void) insertTournament: (Tournament* ) tournament; 

- (void) removeTournament;

- (void) removeTournamentAtIndex: (NSUInteger) index;

- (Tournament* ) tournamentAtIndex: (NSUInteger) index; 

- (void) setCurrentTournament:(Tournament* ) tournament;

- (void) addToAttendedTournaments:(Tournament* ) tournament;


@end
