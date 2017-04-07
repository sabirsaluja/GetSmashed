//
//  MainViewController.m
//  GetSmashed2
//
//  Created by Sabir Saluja on 12/14/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import "MainViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "TournamentsModel.h"

@interface MainViewController ()
@property (strong) TournamentsModel *model;
@property BOOL didFetchData;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the model, set the delegate
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.model = [TournamentsModel sharedModel];
    // NSLog(@"Loaded model.");
//    FBSDKAccessToken *token  = [FBSDKAccessToken alloc];
//    token = [FBSDKAccessToken currentAccessToken];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (self.didFetchData == NO) {
        [self doRequest];
    }
}

- (void)doRequest {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"368704663144095/events" parameters:@{ @"limit": @"10",}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSArray* data = result[@"data"];
                 for (int i = 0; i < [data count]; i++) {
                     NSDictionary* tournamentDict = data[i];
                     NSString* tournamentName = tournamentDict[@"name"];
                     NSDictionary* tournamentLocation = tournamentDict[@"place"][@"location"];
                     NSString* latitudeVal = tournamentLocation[@"latitude"];
                     NSString* longitudeVal = tournamentLocation[@"longitude"];
                     
                     Tournament *tournament = [[Tournament alloc] init:tournamentName latitude:latitudeVal longitude:longitudeVal attended:NO];
                     
                     [self.model insertTournament:tournament];
                     _didFetchData = YES;
                 }
                 NSLog(@"%ld tournaments added to the model.", (long)[self.model numberOfTournaments]);
                 [self.tableView reloadData];
             }
             else {
                 NSLog(@"There was an error.");
             }
         }];
    }
    else {
        NSLog(@"Not logged in.");
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.model numberOfTournaments];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"Calling cellForRowAtIndexPath");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tournamentCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tournamentCell"];
    }
    Tournament *newTournament = [[Tournament alloc] init];
    newTournament = [self.model tournamentAtIndex:indexPath.row];
    cell.textLabel.text = newTournament.name;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.7;
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    return cell;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        ;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // Add to attended tournaments
        Tournament *t = [[Tournament alloc] init];
        t = [self.model tournamentAtIndex:indexPath.row];
        [self.model addToAttendedTournaments:t];
//        NSLog(@"%@", [self.model attendedTournaments]);
        
        // Animation
        [UIView animateWithDuration:0.1 animations:^{
            self.detailLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.detailLabel.text = @"Maps and Tourney logging";
            [UIView animateWithDuration:0.1 animations:^{
                self.detailLabel.alpha = 1;
            }];
        }];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"reload_attended_TVC"
         object:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tournament *selectedTournament = [[Tournament alloc] init];
    selectedTournament = [self.model tournamentAtIndex:indexPath.row];
    [self.model setCurrentTournament:selectedTournament];
    [self performSegueWithIdentifier:@"showMap" sender:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
