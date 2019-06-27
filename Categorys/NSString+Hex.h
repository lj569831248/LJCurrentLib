//
//  NSString+Hex.h
//  BLETest
//
//  Created by Jon on 2019/3/11.
//  Copyright © 2019 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)


//16位字符串数字转10进制值
- (NSInteger)decValue;

//转为16进制字符串
- (NSString *)hexString;

//转为字节数组
- (NSData*) hexToBytes;

//data 转16进制字符串
+(NSString *)HexStringWithData:(NSData *)data;

@end
