//
//  FFDynamicRefreshControl.h
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    RefreshControlStateNormal = 0,
    RefreshControlStatePulling,
    RefreshControlStateReload,
} RefreshControlState;

@class FFDynamicRefreshControl;

@protocol CusRefreshControlDelegate <NSObject>

@optional

- (void)refreshControlDidTriggerRefresh:(FFDynamicRefreshControl *)refreshControl;
- (BOOL)refreshControlDataSourceIsLoading:(FFDynamicRefreshControl *)refreshControl;

@end


@interface FFDynamicRefreshControl : UIView

@property (nonatomic, assign) id<CusRefreshControlDelegate> delegate;

@property (nonatomic, assign) RefreshControlState state;
@property (nonatomic, assign) UIEdgeInsets originalEdgeInsets;

- (void)refreshControlScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshControlScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshControlScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

