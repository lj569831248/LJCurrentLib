//
//  Defines.h
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//
#pragma mark - override

#pragma mark - getter / setter

#pragma mark - UI

#pragma mark - notification

#pragma mark - delegate dataSource protocol

#pragma mark - private


#ifndef Defines_h
#define Defines_h

#define DebugLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

//#ifdef DEBUG
//#define MyString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
//#define NSLog(...) printf("%s 第%d行: %s\n\n",[MyString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(...)
//#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif



//DB 相关
#define USER_DB [MyDB standardUserDataBase]
#define CACHES_DB [MyDB standardCachesDataBase]

//safe 相关
#define SAFE_BLOCK(block,...) if(block){block(__VA_ARGS__);}  //宏定义
#define SAFE_SET_VALUE(Object,Str) (Object==nil || [Object length] == 0 ?Str:Object)

#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//系统 相关
#define L(key) NSLocalizedString(key, nil)
#define INFO_PLIST [[NSBundle mainBundle] infoDictionary]
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define MY_DEFAULTS [MyDefaults standardDefaults]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125,2436),[[UIScreen mainScreen] currentMode].size):NO)

#define ROOT_VC [[UIApplication sharedApplication] visibleViewController]

#define ROOT_NAV [[UIApplication sharedApplication] visibleNavigationController]

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//iPhoneX / iPhoneXS
#define  kIsIphoneX_XS     (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  kIsIphoneXR_XSMax    (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define   kIsXScreen    (kIsIphoneX_XS || kIsIphoneXR_XSMax) 


#define kStatusBarHeight (kIsXScreen?44.0:20.0)
#define kNavigationBarHeight (kStatusBarHeight + 44.0)
#define kTabbarHeight   (kIsXScreen?83:49.0)


//定义UIImage对象
#define IMAGE(A)  [UIImage imageNamed:A]

//这种url方法可以防止含中文的地址报错的情况
#define URL(A) [NSURL URLWithString:[A stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]

#define FILE_URL(A) [NSURL fileURLWithPath:A]
//color相关
#define kRandomColor [UIColor colorWithRed:(arc4random()% 255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]

#define kColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]

#define kBaseColor kColorFromHex(0X1296db)

#define kColorFromHexA(s, a) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:a]
#define kColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kColorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//默认时间格式
#define kDefaultDateFormat @"yyyyMMdd HH:mm:ss"

#define RANDOM(x,y) (arc4random()%(y-x+1)+x)

#define kClearBackTitle  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];

#define kDeallocLog -(void)dealloc{NSLog(@"%@ dealloc",self.class);}
#endif /* Defines_h */
