//
//  MapViewController.m
//  GetSmashed2
//
//  Created by Sabir Saluja on 12/14/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import "MapViewController.h"
#import "TournamentsModel.h"
#define METERS_PER_MILE 1609.344

@interface MapViewController ()
@property (strong) TournamentsModel *model;
@end


@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [TournamentsModel sharedModel];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)singleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    //NSLog(@"Recognized tap.");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Get the tournament location data
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[self.model currentTournament].latitude floatValue];
    zoomLocation.longitude = [[self.model currentTournament].longitude floatValue];
    
    // Zoom into the location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    
    // Add annotation of the location
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = zoomLocation;
    [self.mapView addAnnotation:annotation];
    
    // Implement Core Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    } else {
        oldLocation = nil;
    }
    //NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
    // Compute distance
    CLLocation *tournamentLocation = [[CLLocation alloc] initWithLatitude:[[self.model currentTournament].latitude floatValue] longitude:[[self.model currentTournament].longitude floatValue]];
    
    CLLocationDistance distance = [newLocation distanceFromLocation:tournamentLocation];
    CLLocationDistance distanceInKilometers = distance/1000.0;
    CLLocationDistance distanceInMiles = distanceInKilometers*0.62137;
    //NSLog(@"%f", distanceInMiles);
    _distanceLabel.text = [NSString stringWithFormat:@"%@\n%f miles away", [self.model currentTournament].name, distanceInMiles];
    
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
