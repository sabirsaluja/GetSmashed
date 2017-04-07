//
//  MapViewController.h
//  GetSmashed2
//
//  Created by Sabir Saluja on 12/14/16.
//  Copyright © 2016 Sabir Saluja. All rights reserved.
//  email: sabirsal@usc.edu

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Tournament.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
