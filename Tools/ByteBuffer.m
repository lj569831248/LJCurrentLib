//
//  ByteBuffer.m
//  HBSkyeye
//
//  Created by Jon on 2019/5/16.
//  Copyright © 2019 jingyao. All rights reserved.
//

#import "ByteBuffer.h"


@interface ByteBuffer ()

@property (strong,nonatomic)NSData *originData;

@property (strong,nonatomic)NSMutableData *data;

@end
@implementation ByteBuffer

- (instancetype)initWithData:(NSData *)data{
    if (self = [super init]) {
        _data = [data mutableCopy];
        _originData = data;
    }
    return self;
}

- (uint32_t)getUint32{
    uint32_t value;
    [self getBytes:&value length:sizeof(value)];
    return value;
}

- (uint8_t)getUint8{
    uint8_t value;
    [self getBytes:&value length:sizeof(value)];
    return value;
}

- (NSData *)getData:(NSUInteger)length{
    NSData *data = [self.data subdataWithRange:NSMakeRange(0, length)];
    self.data = [self.data subdataWithRange:NSMakeRange(length, self.data.length - length)].mutableCopy;
    return data;
}

- (void)getBytes:(void *)data length:(NSUInteger)length{
    [self.data getBytes:data length:length];
    self.data = [self.data subdataWithRange:NSMakeRange(length, self.data.length - length)].mutableCopy;
}

@end
