//
//  FFRLTableViewController.m
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFRLTableViewController.h"
#import "FFLoadMoreFooterView.h"

@interface FFRLTableViewController ()
<
CusRefreshControlDelegate
>

@property (nonatomic, strong) FFDynamicRefreshControl *aRefreshControl;
@property (nonatomic, strong) FFLoadMoreFooterView *loadMoreFooterView;

@property (nonatomic, assign) BOOL isDataSourceReload;

@end

@implementation FFRLTableViewController

- (id)initWithTableViewStyle:(UITableViewStyle)style {
    
    if (self = [super initWithStyle:style]) {
       
    }
    
    return self;
}

- (id)initDefaultTableView
{
    return [self initWithTableViewStyle:UITableViewStylePlain];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.hasMore = NO;
    
    if (self.aRefreshControl == nil) {
        self.aRefreshControl = [[FFDynamicRefreshControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0)];
        self.aRefreshControl.delegate = self;
        [self.tableView addSubview:self.aRefreshControl];
    }
    
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

- (FFLoadMoreFooterView *)loadMoreFooterView {
    if (_loadMoreFooterView == nil) {
        _loadMoreFooterView = [[FFLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44.0)];
    }
    return _loadMoreFooterView;
}


- (void)setHasMore:(BOOL)hasMore {
    
    _hasMore = hasMore;
    
    if (hasMore) {
        [self.loadMoreFooterView setState:LoadMoreFooterViewStateNormal];
        [self.tableView setTableFooterView:self.loadMoreFooterView];
    } else {
        [self.tableView setTableFooterView:nil];
    }
}


#pragma mark -
#pragma mark Public Methods

- (void)setRefreshOriginalEdgeInsets:(UIEdgeInsets)edgeInsets {
    [self.aRefreshControl setOriginalEdgeInsets:edgeInsets];
}


- (void)beginReloadData {
}


- (void)endReloadData {
    if (self.aRefreshControl != nil) {
        self.isDataSourceReload = NO;
        [self.aRefreshControl refreshControlScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    
    if (self.loadMoreFooterView != nil) {
        [self.loadMoreFooterView setState:LoadMoreFooterViewStateNormal];
    }

}

#pragma mark -
#pragma mark tableView delegate, dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        if (self.hasMore) {
            
            CGSize aSize = self.tableView.contentSize;
            
            // 加载更多
            CGFloat reloadRange = 10.0;
            
            if ((self.tableView.contentOffset.y + CGRectGetHeight(self.tableView.bounds) - self.tableView.contentInset.bottom) > (aSize.height + reloadRange)) {
                if (self.loadMoreFooterView.state != LoadMoreFooterViewStateReload) {
                    self.loadMoreFooterView.state = LoadMoreFooterViewStateReload;
                    [self loadMoreViewControllerData];
                }
            }
        }
        
        [self.aRefreshControl refreshControlScrollViewDidScroll:scrollView];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == self.tableView) {
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
