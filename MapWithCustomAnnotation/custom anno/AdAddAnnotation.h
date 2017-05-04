//
//  CustomAnnotation.h
//  Point
//
//  Created by XtronLabs.inc on 22/04/15.
//  Copyright (c) 2015 Xtron Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface AdAddAnnotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
