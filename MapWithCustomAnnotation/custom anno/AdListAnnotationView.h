//
//  CustomAnnotationView.h
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AdListAnnotationView : MKAnnotationView



- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event;

@end