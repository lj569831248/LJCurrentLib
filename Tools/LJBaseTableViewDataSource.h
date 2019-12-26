//
//  LJBaseTableViewDataSource.h
//  BLETest
//
//  Created by Jon on 2019/2/26.
//  Copyright © 2019 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
typedef void (^LJDataSourceConfigureBlock)(id cell,id model,NSIndexPath *indexPath);
typedef UIView * (^LJDataSourceHeaderFooterViewBlock)(UITableView *tableView,NSInteger section);
typedef CGFloat (^LJDataSourceHeaderFooterHeightBlock)(UITableView *tableView,NSInteger section);

@interface LJBaseTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) LJDataSourceHeaderFooterViewBlock headerViewBlock;
@property (copy, nonatomic)  LJDataSourceHeaderFooterHeightBlock headerHeightBlock;


- (instancetype)initWithTableView:(UITableView *) tableView
                       identifier:(NSString *)identifier
                   configureBlock:(LJDataSourceConfigureBlock)block;

- (instancetype)initWithTableView:(UITableView *) tableView
                       identifier:(NSString *)identifier
                   configureBlock:(LJDataSourceConfigureBlock)block
                    delegateBlock:(LJDataSourceConfigureBlock)delegateBlock;



@end
