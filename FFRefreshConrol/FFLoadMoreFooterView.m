//
//  tomRefreshControl.m
//  AppFactory
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFLoadMoreFooterView.h"

@interface FFLoadMoreFooterView()

@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UILabel *tipLabel;

@end


@implementation FFLoadMoreFooterView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        
        //
        {
            self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [self.activityView setFrame:CGRectMake(20, 0.5 * (height - 20), 20, 20)];
            [self addSubview:self.activityView];
        }
        
        //
        {
            self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, width - 50, height)];
            [self.tipLabel setBackgroundColor:[UIColor clearColor]];
            [self.tipLabel setFont:[UIFont systemFontOfSize:14.0]];
            [self.tipLabel setTextAlignment:NSTextAlignmentLeft];
            [self.tipLabel setTextColor:[UIColor grayColor]];
            [self addSubview:self.tipLabel];
        }
        
        //
        self.state = LoadMoreFooterViewStateNone;
    }
    
    return self;
}


- (void)setState:(eLoadMoreFooterViewState)state {
    
    if (_state != state) {
        
        _state = state;

        switch (state) {
            case LoadMoreFooterViewStateReload: {
                [self.activityView startAnimating];
                [self.tipLabel setText:@"加载中..."];
            }
                break;
            case LoadMoreFooterViewStateNormal:
            default: {
                [self.activityView stopAnimating];
                [self.tipLabel setText:@"上拉加载更多"];
            }
                break;
        }
    }
}

@end
