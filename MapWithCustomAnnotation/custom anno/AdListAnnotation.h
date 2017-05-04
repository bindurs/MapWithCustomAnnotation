//
//  MapViewPinPoint.h
//  aurak
//
//  Created by Shijin's Mac on 11/10/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface AdListAnnotation : NSObject <MKAnnotation>{
    NSString *title;
    NSString *subtitle;
	CLLocationCoordinate2D coordinate;
    NSInteger tag;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSInteger tag;

- (id)initWithTitle:(NSString *)ttl subtitle: (NSString *)subttl coordinate:(CLLocationCoordinate2D)c2d andTag :(NSInteger) tg;
@end
