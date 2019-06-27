//
//  NSString+UTI.h
//  ConvenientPrinter
//
//  Created by Jon on 2018/2/7.
//  Copyright © 2018年 jon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FileUTIType) {
    FileUTITypeUnKnow = 0,
    FileUTITypeImage,
    FileUTITypeWord,
    FileUTITypeExcel,
    FileUTITypePPT,
    FileUTITypePDF,
    FileUTITypeTxt,
    FileUTITypePages,
    FileUTITypeNumbers,
    FileUTITypeKeynote
};
@interface NSString (UTI)

- (FileUTIType)fileUTIType;

@end
