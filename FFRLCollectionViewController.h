//
//  FFRLCollectionViewController.h
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFBaseCollectionViewController.h"
#import "FFDynamicRefreshControl.h"

/**
 *  提供下拉刷新和加载更多功能的FFRLCollectionViewController
 *  R Reload
 *  L Load more
 */
@interface FFRLCollectionViewController : FFBaseCollectionViewController

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) FFDynamicRefreshControl *aRefreshControl;

//Optional
- (void)setRefreshOriginalEdgeInsets:(UIEdgeInsets)edgeInsets;

//Override method
- (void)reloadViewControllerData;
- (void)loadMoreViewControllerData;

//outside call when load result back
- (void)endReloadData;

@end
