FFListViewController
====================

UITableViewController/UICollectionViewController with reload and loadmore

********  Refresh 和 Loadmore 控件 *********
RefreshControl 支持动态图片loading
Loadmore  activity + lable

********  UIViewController 封装  **********

1.提供支持 下拉刷新R和上拉加载更多L的  UITableViewController

2.提供支持 下拉刷新R和上拉加载更多L的  UICollectionController

你需要重写以下2个方法

    //Override method
    (下拉刷新时，会调用到该方法)
    - (void)reloadViewControllerData;
    （列表页拉倒底部时，会调用该方法）
    - (void)loadMoreViewControllerData;
    
    @property (nonatomic, assign) BOOL hasMore;
    设置该变量，来控制是否需要加载更多数据
    
    //outside call when load result back
    （加载数据结束后，调用该方法）
    - (void)endReloadData;
    
