//
//  NSString+Hex.m
//  BLETest
//
//  Created by Jon on 2019/3/11.
//  Copyright © 2019 Jon. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)


+(NSString *)HexStringWithData:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr uppercaseString];
    return hexStr;
}

- (NSInteger)decValue{
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    int hexNumber;
    sscanf(hexChar, "%x", &hexNumber);
    return (NSInteger)hexNumber;
}

- (NSString *)hexString{
    return [NSString stringWithFormat:@"%02x",self.intValue];
//    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *bytes = (Byte *)[myD bytes];
//    //下面是Byte转换为16进制。
//    NSString *hexStr=@"";
//    for(int i=0;i<[myD length];i++){
//        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
//        if([newHexStr length]==1)
//            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
//        else
//            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
//    }
//    return hexStr;
}

- (NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
        
    }
    return data;
}

@end
