//
//  ViewController.h
//  SampleForKHA
//
//  Created by Webmob on 16/12/16.
//  Copyright © 2016 webmob. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic) CLLocationCoordinate2D location;

@end

