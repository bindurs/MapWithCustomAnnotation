//
//  CustomAnnotation.m
//  Point
//
//  Created by XtronLabs.inc on 22/04/15.
//  Copyright (c) 2015 Xtron Labs. All rights reserved.
//

#import "AdAddAnnotation.h"

@implementation AdAddAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    coordinate=coord;
    return self;
}

-(CLLocationCoordinate2D)coord
{
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}



@end
