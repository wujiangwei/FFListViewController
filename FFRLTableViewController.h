//
//  FFRLTableViewController.h
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFDynamicRefreshControl.h"

/**
 *  提供下拉刷新和加载更多功能的FFRLTableViewController
 *  R Reload
 *  L Load more
 */
@interface FFRLTableViewController : UITableViewController

//did you have more data to load
@property (nonatomic, assign) BOOL hasMore;

//Optional
- (void)setRefreshOriginalEdgeInsets:(UIEdgeInsets)edgeInsets;

//Override method
- (void)reloadViewControllerData;
- (void)loadMoreViewControllerData;

//outside call when load result back
- (void)endReloadData;

@end
