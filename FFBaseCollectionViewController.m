//
//  FFBaseCollectionViewController.m
//  AppModule
//
//  Created by wujiangwei on 14-9-22.
//  Copyright (c) 2014年 JiSheng. All rights reserved.
//

#import "FFBaseCollectionViewController.h"

@implementation FFBaseCollectionViewController

@synthesize flowLayout = _flowLayout;
@synthesize collectView = _collectView;

- (id)init
{
    if (self = [super init]) {
        self.flowLayout.minimumLineSpacing = 0;
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    
    return self;
}

- (id)initVerCollectionViewController
{
    if (self = [super init]) {
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    
    return self;
}

- (id)initHorCollectionViewController
{
    if (self = [super init]) {
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_collectView.superview == nil) {
        self.collectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
        _collectView.allowsMultipleSelection = NO;
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.delegate = self;
        _collectView.dataSource = self;
        
        _collectView.frame = self.view.bounds;
        [self.view addSubview:_collectView];
    }
}

#pragma mark - Layout

- (void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout
{
    _flowLayout = flowLayout;
    self.collectView.collectionViewLayout = flowLayout;
    [self.collectView reloadData];
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //default is zero
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    
    return _flowLayout;
}

#pragma mark - UICollectionViewDelegate

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(0, 0);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //do something...
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
