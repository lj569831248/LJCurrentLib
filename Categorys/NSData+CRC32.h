//
//  NSData+CRC32.h
//  HBSkyeye
//
//  Created by Jon on 2019/5/14.
//  Copyright © 2019 jingyao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC32)
- (int32_t)crc32;

@end

NS_ASSUME_NONNULL_END
