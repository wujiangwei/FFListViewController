//
//  FFDynamicRefreshControl.m
//
//  Created by wujiangwei on 14-9-23.
//  Copyright (c) 2014年 Kevin.Wu. All rights reserved.
//

#import "FFDynamicRefreshControl.h"

@interface FFDynamicRefreshControl()

@property (nonatomic, retain) UIImageView *cSpinner;
@property (nonatomic, retain) UILabel *labelState;

@end

@implementation FFDynamicRefreshControl

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        _state = -1;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
        
        {
            self.cSpinner = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self.cSpinner setImage:[UIImage imageNamed:@"icon_refresh_normal.png"]];
            [self.cSpinner setAnimationImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"icon_refresh_1.png"], [UIImage imageNamed:@"icon_refresh_2.png"], nil]];
            [self.cSpinner setAnimationDuration:.5];
            [self addSubview:self.cSpinner];
        }
        
        {
            self.labelState = [[UILabel alloc] initWithFrame:CGRectZero];
            [self.labelState setTextColor:[UIColor grayColor]];
            [self.labelState setTextAlignment:NSTextAlignmentCenter];
            [self.labelState setFont:[UIFont systemFontOfSize:13.0]];
            [self.labelState setBackgroundColor:[UIColor clearColor]];
            [self addSubview:self.labelState];
        }
        
        self.state = RefreshControlStateNormal;
    }
    
    return self;
}


#pragma mark -
#pragma mark Override Methods

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor redColor];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    self.cSpinner.frame = CGRectMake(30, height - 50, 50, 50);
    self.labelState.frame = CGRectMake(0, height - 50, width, 50);
}


#pragma mark -
#pragma mark KVO


#pragma mark -
#pragma mark Property

- (void)setState:(RefreshControlState)state {
    
    if (_state != state) {
        
        _state = state;
        
        switch (state) {
            case RefreshControlStatePulling: {
                [self.labelState setText:@"释放即可刷新"];
                [self.cSpinner startAnimating];
            }
                break;
            case RefreshControlStateReload: {
                [self.labelState setText:@"努力加载中..."];
                [self.cSpinner startAnimating];
            }
                break;
            case RefreshControlStateNormal:
            default: {
                [self.labelState setText:@"下拉即可刷新"];
                [self.cSpinner stopAnimating];
            }
                break;
        }
    }
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)refreshControlScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.state == RefreshControlStateReload) {
        
        CGFloat offset = MAX([self realContentOffsetYForScrollView:scrollView] * -1, 0);
        offset = MIN(offset, 60);
        
        UIEdgeInsets inset = self.originalEdgeInsets;
        inset.top += offset;
        
        scrollView.contentInset = inset;
    }
    else if (scrollView.isDragging)
    {
        BOOL reload = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshControlDataSourceIsLoading:)]) {
            reload = [self.delegate refreshControlDataSourceIsLoading:self];
        }
        
        if (self.state == RefreshControlStatePulling && [self realContentOffsetYForScrollView:scrollView] > -65.0f && [self realContentOffsetYForScrollView:scrollView] < 0.0f && !reload) {
            self.state = RefreshControlStateNormal;
        } else if (_state == RefreshControlStateNormal && [self realContentOffsetYForScrollView:scrollView] < -65.0f && !reload) {
            self.state = RefreshControlStatePulling;
        }
        
        if (scrollView.contentInset.top - self.originalEdgeInsets.top != 0) {
            scrollView.contentInset = self.originalEdgeInsets;
        }
    }
}


- (void)refreshControlScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL reload = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshControlDataSourceIsLoading:)]) {
        reload = [self.delegate refreshControlDataSourceIsLoading:self];
    }
    
    if ([self realContentOffsetYForScrollView:scrollView] <= -65.0f && !reload) {
        
        UIEdgeInsets inset = self.originalEdgeInsets;
        inset.top += 60.0;
        
        [self setState:RefreshControlStateReload];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [scrollView setContentInset:inset];
        [UIView commitAnimations];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshControlDidTriggerRefresh:)]) {
            [self.delegate refreshControlDidTriggerRefresh:self];
        }
    }
}


- (void)refreshControlScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:self.originalEdgeInsets];
    [UIView commitAnimations];
    [self setState:RefreshControlStateNormal];
}


#pragma mark -
#pragma mark Private Methods

- (CGFloat)realContentOffsetYForScrollView:(UIScrollView *)scrollView {
    return scrollView.contentOffset.y + self.originalEdgeInsets.top;
}

@end
