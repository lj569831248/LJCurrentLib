//
//  LJBaseTableViewDataSource.m
//  BLETest
//
//  Created by Jon on 2019/2/26.
//  Copyright © 2019 Jon. All rights reserved.
//

#import "LJBaseTableViewDataSource.h"
#import "Defines.h"
@interface LJBaseTableViewDataSource()
@property (copy,nonatomic)NSString *identifier;
@property (copy,nonatomic)LJDataSourceConfigureBlock configureBlock;
@property (copy,nonatomic)LJDataSourceConfigureBlock delegateBlock;

@end

@implementation LJBaseTableViewDataSource


- (instancetype)initWithTableView:(UITableView *) tableView
                       identifier:(NSString *)identifier
                   configureBlock:(LJDataSourceConfigureBlock)block{
    return [self initWithTableView:tableView identifier:identifier configureBlock:block delegateBlock:nil];
    
}

- (instancetype)initWithTableView:(UITableView *) tableView
                       identifier:(NSString *)identifier
                   configureBlock:(LJDataSourceConfigureBlock)block
                    delegateBlock:(LJDataSourceConfigureBlock)delegateBlock{
    if (self = [super init]) {
         self.identifier = identifier;
         self.configureBlock = block;
         self.delegateBlock = delegateBlock;
        tableView.dataSource = self;
        tableView.delegate = self;
     }
     return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
    if (self.configureBlock) {
        kWeakSelf(weakSelf)
        self.configureBlock(cell, weakSelf.dataArray[indexPath.row], indexPath);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegateBlock) {
        kWeakSelf(weakSelf)
        self.delegateBlock(nil,  weakSelf.dataArray[indexPath.row], indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.headerViewBlock) {
        return  self.headerViewBlock(tableView, section);
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headerHeightBlock) {
        return self.headerHeightBlock(tableView,section);
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"hb_no_data"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"数据为空";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:22.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
@end
