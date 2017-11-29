//
//  MyDBModel.h
//  FastThree
//
//  Created by Jon on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDBModelDelegate <NSObject>
@required
+ (NSString *)primaryKey;       //主键,model 中一个唯一且不能为 nil的属性, 返回属性名即可,如果不想自己实现,直接继承MyDBModel即可

@end

@interface MyDBModel : NSObject<MyDBModelDelegate>
@property (copy, nonatomic, readonly)NSString *objectId;
@end
