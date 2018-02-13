//
//  UIPDFPrintPageRenderer.h
//  ConvenientPrinter
//
//  Created by Jon on 2018/2/7.
//  Copyright © 2018年 jon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPDFPrintPageRenderer : UIPrintPageRenderer

- (NSData*) printToPDF;

@end
