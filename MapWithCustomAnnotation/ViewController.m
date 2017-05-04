//
//  ViewController.m
//  MapWithCustomAnnotation
//
//  Created by Bindu on 03/05/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *customView;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@end
#pragma mark Map Config


#define METERS_PER_MILE 1609.344
#define ZOOM_TO_PIN 2
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360

@implementation ViewController {
    NSMutableArray *arrLocation;
    NSArray *locationArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self;
    arrLocation = [[NSMutableArray alloc] init];
    [self setMap];
}
- (IBAction)locationClicked:(UIButton *)sender {
    
    DetailsViewController *vc = [[DetailsViewController alloc] init];
    vc.name = [arrLocation objectAtIndex:sender.tag];
    vc.location = [locationArray objectAtIndex:sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MapView methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        
        view.canShowCallout = NO;
        
    }else{
        
        [view addSubview:self.customView];
        _locationButton.tag = ((AdListAnnotation *)view.annotation).tag;
        self.customView.center = CGPointMake(self.customView.bounds.size.width*0.1f, -self.customView.bounds.size.height*0.5f);
        CGRect frame = self.customView.frame ;
        frame.origin.x+=60;
        frame.origin.y+=10;
        self.customView.frame = frame;
        //_locationLabel.frame = _locationButton.imageView.bounds;
       _locationLabel.text = [arrLocation objectAtIndex:_locationButton.tag];
        
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    NSArray *viewsToRemove = [view subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    AdListAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation) {
        
        static NSString *defaultPinID = @"mapPin";
        pinView = (AdListAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[AdListAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.image = [UIImage imageNamed:@"map_marker.png"];
        return pinView;
        
        
    } else {
        [mapView.userLocation setTitle:@"hlo"];
        
        return nil;
    }
}


-(void)setMap {
    
    self.mapView.showsUserLocation = YES;
    
    locationArray = @[
                               @{@"lat":@"45.44073",@"lng":@"-73.73998"},
                               @{@"lat":@"45.44229",@"lng":@"-73.6563"},
                               @{@"lat":@"45.44527000000001",@"lng":@"-73.64261"},
                               @{@"lat":@"45.47117999999999",@"lng":@"-73.60565"},
                               @{@"lat":@"45.47339000000001",@"lng":@"-73.6103"},
                               @{@"lat":@"45.48517",@"lng":@"-73.59635"}
                               ];
    
    [self removeAllPinsButUserLocation2];
    
    for(int i=0;i< [locationArray count];i++){
        
        NSDictionary *locationDict = [locationArray objectAtIndex:i];
        
        CLLocationCoordinate2D myCoordinate = {.latitude =[[locationDict valueForKey:@"lat"] doubleValue] , .longitude = [[locationDict valueForKey:@"lng"] doubleValue]};
        
        MKCoordinateSpan span = {.latitudeDelta= 1, .longitudeDelta =  1};
        MKCoordinateRegion region = {myCoordinate, span};
        [self.mapView setRegion:region];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setLocale:enUSPOSIXLocale];
        [formatter setDateFormat:@"d'th 'MMM"];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[[locationDict valueForKey:@"lat"] doubleValue] longitude:[[locationDict valueForKey:@"lng"] doubleValue]];
        
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
              NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            NSString *strAdd = nil;
            if (error == nil && [placemarks count] > 0) {
                
                CLPlacemark *placemark = [placemarks lastObject];
                
                // strAdd -> take bydefault value nil
                
                
                if ([placemark.subThoroughfare length] != 0)
                    strAdd = placemark.subThoroughfare;
                
                if ([placemark.thoroughfare length] != 0) {
                    // strAdd -> store value of current location
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                    else
                        // strAdd -> store only this value,which is not null
                        strAdd = placemark.thoroughfare;
                }
                
                if ([placemark.postalCode length] != 0) {
                    
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                    else
                        strAdd = placemark.postalCode;
                }
                
                if ([placemark.locality length] != 0) {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                    else
                        strAdd = placemark.locality;
                }
                
                if ([placemark.administrativeArea length] != 0) {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                    else
                        strAdd = placemark.administrativeArea;
                }
                
                if ([placemark.country length] != 0)  {
                    
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                    else
                        strAdd = placemark.country;
                }
            }
            NSLog(@"%@",strAdd);
            [arrLocation addObject:strAdd];
        }];

        
        AdListAnnotation *pinLoc = [[AdListAnnotation alloc] initWithTitle:@"title" subtitle: [formatter stringFromDate:[NSDate date]]  coordinate:myCoordinate andTag:i];
        [self.mapView addAnnotation:pinLoc];
    }
    [self zoomMapViewToFitAnnotations:self.mapView animated:YES];
    
}

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    NSArray *annotations = mapView.annotations;
    int count = [mapView.annotations count];
    if ( count == 1 || count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapView setRegion:region animated:animated];
}



- (void)removeAllPinsButUserLocation2
{
    id userLocation = [self.mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.mapView annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [self.mapView removeAnnotations:pins];
    pins = nil;
}
//- (void)mapView:(MKMapView *)mpview didAddAnnotationViews:(NSArray *)views
//{
//
//    for (MKAnnotationView *view in views)
//    {
//        if ([[view annotation] isKindOfClass:[MKUserLocation class]])
//        {
//            [[view superview] bringSubviewToFront:view];
//        }
//        else
//        {
//            [[view superview] sendSubviewToBack:view];
//        }
//    }
//}

@end
