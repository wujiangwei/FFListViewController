//
//  FFDynamicRefreshControl.h
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoadMoreFooterViewStateNone,
    LoadMoreFooterViewStateNormal,
    LoadMoreFooterViewStateReload,
} eLoadMoreFooterViewState;

/**
 *  加载更多View
 *  UICollectionReusableView for collectionViewController
 */
@interface FFLoadMoreFooterView : UICollectionReusableView

@property (nonatomic, assign) eLoadMoreFooterViewState state;

@end
