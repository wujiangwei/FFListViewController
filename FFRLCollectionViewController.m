//
//  FFRLCollectionViewController.m
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFRLCollectionViewController.h"
#import "FFLoadMoreFooterView.h"

#import "UIView+Frame.h"

@interface FFRLCollectionViewController()
<CusRefreshControlDelegate>

@property (nonatomic, strong) FFLoadMoreFooterView *loadMoreFooterView;

@property (nonatomic, assign) BOOL isDataSourceReload;

@end

@implementation FFRLCollectionViewController

@synthesize loadMoreFooterView = _loadMoreFooterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hasMore = NO;
    
    if (self.aRefreshControl == nil) {
        self.aRefreshControl = [[FFDynamicRefreshControl alloc] initWithFrame:CGRectZero];
        self.aRefreshControl.width = self.collectView.width;
        self.aRefreshControl.delegate = self;
        [self.collectView addSubview:self.aRefreshControl];
    }
    
    [self.collectView registerClass:[FFLoadMoreFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"kLoadMoreFooterIdentify"];
    
    [self modifyRefreshControlOriginalEdgeInsets];
}


- (void)modifyRefreshControlOriginalEdgeInsets {
    [self.aRefreshControl setOriginalEdgeInsets:[self originalContentInset]];
}

- (UIEdgeInsets)originalContentInset {
    CGFloat navHeight = ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? 64.0 : 0.0;
    return UIEdgeInsetsMake(navHeight, 0, 0, 0);
}

#pragma mark -
#pragma mark Property

- (void)setHasMore:(BOOL)hasMore {
    if (_hasMore != hasMore && hasMore) {
        self.flowLayout.footerReferenceSize = CGSizeMake(self.view.width, 44);
    }else{
        self.flowLayout.footerReferenceSize = CGSizeMake(0, 0);
    }
    _hasMore = hasMore;
}


#pragma mark -
#pragma mark Public Methods

- (void)setRefreshOriginalEdgeInsets:(UIEdgeInsets)edgeInsets {
    [self.aRefreshControl setOriginalEdgeInsets:edgeInsets];
}


- (void)beginReloadData {
}


- (void)endReloadData {
    [self doEndReloadData];
    // [self performSelector:@selector(doEndReloadData) withObject:nil afterDelay:0.0];
}


- (void)doEndReloadData {
    
    if (self.aRefreshControl != nil) {
        self.isDataSourceReload = NO;
        [self.aRefreshControl refreshControlScrollViewDataSourceDidFinishedLoading:self.collectView];
    }
    
    self.hasMore = NO;
}

#pragma mark - 
#pragma mark - collection footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
     if ([kind isEqualToString:UICollectionElementKindSectionFooter] && _hasMore){
         UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"kLoadMoreFooterIdentify" forIndexPath:indexPath];
         self.loadMoreFooterView = (FFLoadMoreFooterView *)view;
         [self.loadMoreFooterView setState:LoadMoreFooterViewStateNormal];
         return (UICollectionReusableView *)view;
     }
    
    return nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.collectView) {
        
        if (self.hasMore) {
            
            CGSize aSize = self.collectView.contentSize;
            
            // 加载更多
            CGFloat reloadRange = 10.0;
            
            if ((self.collectView.contentOffset.y + CGRectGetHeight(self.collectView.bounds) - self.collectView.contentInset.bottom) > (aSize.height + reloadRange)) {
                if (self.loadMoreFooterView && self.loadMoreFooterView.state != LoadMoreFooterViewStateReload) {
                    self.loadMoreFooterView.state = LoadMoreFooterViewStateReload;
                    [self reloadViewControllerData];
                }
            }
        }
        
        [self.aRefreshControl refreshControlScrollViewDidScroll:scrollView];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == self.collectView) {
        [self.aRefreshControl refreshControlScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark FFDynamicRefreshControlDelegate

- (BOOL)refreshControlDataSourceIsLoading:(FFDynamicRefreshControl *)refreshControl {
    return self.isDataSourceReload;
}


- (void)refreshControlDidTriggerRefresh:(FFDynamicRefreshControl *)refreshControl {
    
    self.isDataSourceReload = YES;
    [self reloadViewControllerData];
}


#pragma mark -
#pragma mark Override Point

- (void)reloadViewControllerData {
}

- (void)loadMoreViewControllerData {
}


@end
