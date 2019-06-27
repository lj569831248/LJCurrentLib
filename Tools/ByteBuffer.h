//
//  ByteBuffer.h
//  HBSkyeye
//
//  Created by Jon on 2019/5/16.
//  Copyright © 2019 jingyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ByteBuffer : NSObject

- (instancetype)initWithData:(NSData *)data;

- (void)getBytes:(void *)data length:(NSUInteger)length;

- (uint32_t)getUint32;
- (uint8_t)getUint8;
- (NSData *)getData:(NSUInteger)length;

@end

NS_ASSUME_NONNULL_END
