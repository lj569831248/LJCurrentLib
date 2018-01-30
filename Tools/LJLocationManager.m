//
//  LJLocationManager.m
//  9WTemplate
//
//  Created by Jon on 2018/1/27.
//  Copyright © 2018年 jon. All rights reserved.
//

#import "LJLocationManager.h"

@interface LJLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic , strong)  CLLocationManager *locationManager;
@property (copy, nonatomic)LocationBlock locationBlock;

@end

@implementation LJLocationManager

static LJLocationManager *standardLocationManager = nil;
+ (instancetype)standardLocationManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standardLocationManager = [[self alloc] init];
    });
    return standardLocationManager;
}

- (id)init{
    if (self = [super init]) {
        self.locationManager =[[CLLocationManager alloc]init];
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务不可用!");
        }
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
            [self.locationManager requestWhenInUseAuthorization];
        }
        //设置代理
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        //定位频率,每隔多少米定位一次
        //        CLLocationDistance distance = 10.0;
        self.locationManager.distanceFilter = CLLocationDistanceMax;
    }
    return self;
}

- (void)getLocationCoordinate:(LocationBlock) locationBlock andAddress:(void(^)(CLPlacemark *placemark))placemarkBlock{
    [self getLocationCoordinate:^(CLLocation *currentLocation) {
        if (currentLocation) {
            SAFE_BLOCK(locationBlock,currentLocation);
            [self getLBSWithLocation:currentLocation withAddress:^(CLPlacemark *placemark) {
                if (placemark) {
                    SAFE_BLOCK(placemarkBlock,placemark);
                }
                else{
                    SAFE_BLOCK(placemarkBlock,nil);
                }
            }];
        }
        else{
            SAFE_BLOCK(locationBlock,nil);
            SAFE_BLOCK(placemarkBlock,nil);
        }
    }];
    
}


- (void)getLocationCoordinate:(LocationBlock) locationBlock{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        [self.locationManager requestLocation];
    }else{
        [self.locationManager startUpdatingLocation];
    }
    self.locationBlock = locationBlock;
}

- (void)getCity:(void(^)(NSString *cityInfo)) cityInfoBlock{
    [self getLocationCoordinate:^(CLLocation *currentLocation) {
        if (currentLocation) {
            [self getLBSWithLocation:currentLocation withAddress:^(CLPlacemark *placemark) {
                if (placemark) {
                    NSDictionary *addressDictionary = placemark.addressDictionary;
                    NSString *city = [addressDictionary objectForKey:@"City"];
                    SAFE_BLOCK(cityInfoBlock,city);
                }
                else{
                    SAFE_BLOCK(cityInfoBlock,nil);
                }
            }];
        }
        else{
            SAFE_BLOCK(cityInfoBlock,nil);
            
        }
        
    }];
}


- (void)getLBSWithLocation:(CLLocation *)location withAddress:(void(^)(CLPlacemark *placemark)) placemarkBlock{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            SAFE_BLOCK(placemarkBlock,placemark);
        }
        else{
            SAFE_BLOCK(placemarkBlock,nil);
        }
    }];
}
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CLGeocodeCompletionHandler)completionHandler{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressString completionHandler:completionHandler];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLLocation *newLocation = locations.lastObject;
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    if (newLocation.horizontalAccuracy < 0) return;
    SAFE_BLOCK(self.locationBlock,currentLocation);
}

/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    SAFE_BLOCK(self.locationBlock,nil);
    NSLog(@"获取定位失败");
}

- (void)stopUpdatingLocation{
    [self.locationManager stopUpdatingLocation];
}

@end

