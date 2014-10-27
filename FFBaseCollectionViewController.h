//
//  FFBaseCollectionViewController.h
//  AppModule
//
//  Created by wujiangwei on 14-9-22.
//  Copyright (c) 2014年 JiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFBaseCollectionViewController : UIViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

- (id)initVerCollectionViewController;
- (id)initHorCollectionViewController;

@end
