//
//  LJLocationManager.h
//  9WTemplate
//
//  Created by Jon on 2018/1/27.
//  Copyright © 2018年 jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlock)(CLLocation *currentLocation);

@interface LJLocationManager : NSObject

+ (instancetype)standardLocationManager;
- (void)getLocationCoordinate:(LocationBlock) locationCoordinateBlock;
- (void)getCity:(void(^)(NSString *cityInfo)) cityInfoBlock;
- (void)getLocationCoordinate:(LocationBlock) locationBlock andAddress:(void(^)(CLPlacemark *placemark))placemarkBlock;
- (void)stopUpdatingLocation;
@end
