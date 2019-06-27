//
//  UIPDFPrintPageRenderer.m
//  ConvenientPrinter
//
//  Created by Jon on 2018/2/7.
//  Copyright © 2018年 jon. All rights reserved.
//

#import "UIPDFPrintPageRenderer.h"

@interface UIPDFPrintPageRenderer()
@property (assign ,nonatomic)BOOL generatingPdf;
@end
@implementation UIPDFPrintPageRenderer
- (CGRect) paperRect{
    if (!_generatingPdf)
        return [super paperRect];
    return UIGraphicsGetPDFContextBounds();
}

- (CGRect) printableRect{
    if (!_generatingPdf)
        return [super printableRect];
    
    return CGRectInset( self.paperRect, 20, 20 );
}

- (NSData*) printToPDF{
    _generatingPdf = YES;
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, CGRectMake(0, 0, 792, 612), nil );  // letter-size, landscape
    [self prepareForDrawingPages: NSMakeRange(0, 1)];
    CGRect bounds = UIGraphicsGetPDFContextBounds();
    for ( int i = 0 ; i < self.numberOfPages ; i++ ){
        UIGraphicsBeginPDFPage();
        [self drawPageAtIndex: i inRect: bounds];
    }
    UIGraphicsEndPDFContext();
    _generatingPdf = NO;
    return pdfData;
}
@end
