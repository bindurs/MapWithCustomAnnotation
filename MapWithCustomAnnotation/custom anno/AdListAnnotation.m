//
//  MapViewPinPoint.m
//  aurak
//
//  Created by Shijin's Mac on 11/10/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "AdListAnnotation.h"

@implementation AdListAnnotation
@synthesize  title, coordinate,tag,subtitle;

- (id)initWithTitle:(NSString *)ttl subtitle: (NSString *)subttl coordinate:(CLLocationCoordinate2D)c2d andTag :(NSInteger) tg{
    self = [super init];
    if (self != nil) {
        coordinate = c2d;
        title = ttl;
        subtitle = subttl;
        tag = tg;
    }
    return self;
}


@end
