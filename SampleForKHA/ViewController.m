//
//  ViewController.m
//  SampleForKHA
//
//  Created by Webmob on 16/12/16.
//  Copyright © 2016 webmob. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
@interface ViewController ()
{
    AFHTTPRequestOperationManager *manager;
    
    NSDictionary *responseArr;
    
    int forCurrentUser,forFirstTime;
    
    CLLocation *newLocationCord,*oldLocationCord;
    
    double calculatedSpeed;
    
    BOOL ForLoctaionTimer;
    
    NSTimer *locationTimer;
    
    GMSMarker *finalMArker;
    
    
    GMSMutablePath *path;
    
    
    GMSPolyline *rectangle;
}
@end

@implementation ViewController

@synthesize mapView,locationManager,location;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    forFirstTime = 10;
    
    mapView.mapType = kGMSTypeNormal;
    mapView.settings.rotateGestures = NO;
    mapView.settings.tiltGestures = NO;
    
    
    //initializing a path object here
    path = [GMSMutablePath path];
    
    
    
    rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.strokeWidth = 5;
    rectangle.map = mapView;

    
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1;
    
    location.latitude = locationManager.location.coordinate.latitude;
    
    location.longitude = locationManager.location.coordinate.longitude;
    
    NSLog(@"%f,%f",location.latitude,location.longitude);
}

#pragma mark Location manager Delegate method

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    newLocationCord = newLocation;
    
    oldLocationCord = oldLocation;
    
    [path addCoordinate:CLLocationCoordinate2DMake(newLocationCord.coordinate.latitude,newLocationCord.coordinate.longitude)];
    
    NSLog(@"%@,%@",newLocationCord,oldLocationCord);
    
    [self setUpMarker];
    
}

-(void)setUpMarker
{
    if (forFirstTime == 10)
    {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocationCord.coordinate.latitude longitude:newLocationCord.coordinate.longitude zoom:15];
        
        [mapView animateToCameraPosition:camera];
        
        finalMArker = [[GMSMarker alloc]init];;
        
        finalMArker.position = CLLocationCoordinate2DMake(newLocationCord.coordinate.latitude,newLocationCord.coordinate.longitude);
        
        finalMArker.groundAnchor = CGPointMake(0.5, 0.5);
        
        finalMArker.map = mapView;
        
        forFirstTime = 20;
    }
    else
    {
        rectangle.path = path;
        
    }
}

@end
