//
//  ViewController.h
//  MapWithCustomAnnotation
//
//  Created by Bindu on 03/05/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyMapViewAnnotation.h"
#import "MyMapAnnotationView.h"
#import "DetailsViewController.h"
#import "AdListAnnotation.h"
#import "AdListAnnotationView.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>


@end

