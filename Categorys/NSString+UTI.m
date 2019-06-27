//
//  NSString+UTI.m
//  ConvenientPrinter
//
//  Created by Jon on 2018/2/7.
//  Copyright © 2018年 jon. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSString+UTI.h"

@implementation NSString (UTI)

- (FileUTIType)fileUTIType{
    if ([self isFileUTITypeImage]) {
        return FileUTITypeImage;
    }
    if ([self isFileUTITypeWord]) {
        return FileUTITypeWord;
    }
    if ([self isFileUTITypeExcel]) {
        return FileUTITypeExcel;
    }
    if ([self isFileUTITypePPT]) {
        return FileUTITypePPT;
    }
    if ([self isFileUTITypePDF]) {
        return FileUTITypePDF;
    }
    if ([self isFileUTITypeTxt]) {
        return FileUTITypeTxt;
    }
    if ([self isFileUTITypePages]) {
        return FileUTITypePages;
    }
    if ([self isFileUTITypeNumbers]) {
        return FileUTITypeNumbers;
    }
    if ([self isFileUTITypeKeynote]) {
        return FileUTITypeKeynote;
    }
    return FileUTITypeUnKnow;
}

- (BOOL)isFileUTITypeImage{
    NSArray *UTIs = @[@"public.image"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypeWord{
    NSArray *UTIs = @[@"com.microsoft.word.doc",
                      @"com.microsoft.word.wordml",
                      @"org.openxmlformats.wordprocessingml.document"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypeExcel{
    NSArray *UTIs = @[@"com.microsoft.excel.xls",
                      @"org.openxmlformats.spreadsheetml.sheet"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypePPT{
    NSArray *UTIs = @[@"com.microsoft.powerpoint.ppt",
                      @"org.openxmlformats.presentationml.presentation"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypePDF{
    NSArray *UTIs = @[@"com.adobe.pdf"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypeTxt{
    NSArray *UTIs = @[@"public.text"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypePages{
    NSArray *UTIs = @[@"com.apple.iwork.pages.sffpages"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypeNumbers{
    NSArray *UTIs = @[@"com.apple.iwork.numbers.sffnumbers"];
    return [self UTTypeConforms:UTIs];
}

- (BOOL)isFileUTITypeKeynote{
    NSArray *UTIs = @[@"com.apple.iwork.keynote.sffkey"];
    return [self UTTypeConforms:UTIs];
}


- (BOOL)UTTypeConforms:(NSArray *)UTIs{
    for (NSString *uti in UTIs) {
        BOOL result = UTTypeConformsTo((__bridge CFStringRef)self,(__bridge CFStringRef)uti);
        if (result) {
            return YES;
        }
    }
    return NO;
}

@end
