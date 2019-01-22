//
//  ZBCycleVerticalView.m
//  DeRong
//
//  Created by 周博 on 2019/1/7.
//  Copyright © 2019 周博. All rights reserved.
//

#import "ZBCycleVerticalView.h"
#import "ZBCycleView.h"

#define kScreenWidth     CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight    CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ZBCycleVerticalView ()
{
    CGRect          _topRect;
    CGRect          _middleRect;
    CGRect          _btmRect;
    NSInteger       _indexNow;
    
    double          _showTime;
    double          _animationTime;
    
    UIButton        *_button;
    NSTimer         *_timer;
}

@property (strong, nonatomic) ZBCycleView *view1;
@property (strong, nonatomic) ZBCycleView *view2;

@property (strong, nonatomic) ZBCycleView *tmpTopView;
@property (strong, nonatomic) ZBCycleView *tmpMiddleView;
@property (strong, nonatomic) ZBCycleView *tmpBtmView;

@end

@implementation ZBCycleVerticalView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _showTime = 3;
        _animationTime = 0.3;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _showTime = 3;
        _animationTime = 0.3;
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _middleRect = self.bounds;
    _topRect = CGRectMake(0, -CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _btmRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    self.view1.frame = _middleRect;
    self.view2.frame = self.direction == ZBCycleVerticalViewScrollDirectionDown ? self->_topRect : self->_btmRect;
    _button.frame = _middleRect;
}

- (void)initUI{
    self.view1 = [[ZBCycleView alloc]init];
//    self.view1.backgroundColor = [UIColor clearColor];

    self.view2 = [[ZBCycleView alloc]init];
//    self.view2.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.view1];
    [self addSubview:self.view2];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor clearColor];
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    self.clipsToBounds = YES;
}

- (void)configureShowTime:(double)showTime
            animationTime:(double)animationTime
                direction:(ZBCycleVerticalViewScrollDirection)direction
          backgroundColor:(UIColor *)backgroundColor
                textColor:(UIColor *)textColor font:(UIFont *)font
            textAlignment:(NSTextAlignment)textAlignment{
    _showTime = showTime;
    _animationTime = animationTime;
    _direction = direction;
    self.view1.backgroundColor = self.view2.backgroundColor = backgroundColor;
}

// 执行动画
- (void)executeAnimation{
    [self setViewInfo];
    [UIView animateWithDuration:_animationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tmpMiddleView.frame = self.direction == ZBCycleVerticalViewScrollDirectionDown ? self->_btmRect : self->_topRect;
        if (self->_direction == ZBCycleVerticalViewScrollDirectionDown) {
            self.tmpTopView.frame = self->_middleRect;
        } else {
            self.tmpBtmView.frame = self->_middleRect;
        }
    }completion:^(BOOL finished) {
        self.tmpMiddleView.frame = self->_direction == ZBCycleVerticalViewScrollDirectionDown ? self->_topRect : self->_btmRect;
        if (self->_indexNow < self.dataArray.count - 1) {
            self->_indexNow ++;
        }else{
            self->_indexNow = 0;
        }
    }];
}

#pragma mark - set
- (void)setDirection:(ZBCycleVerticalViewScrollDirection)direction{
    _direction = direction;
    self.view2.frame = _direction == ZBCycleVerticalViewScrollDirectionDown ? _topRect : _btmRect;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (![_timer isValid]) {
        _indexNow = 0;
        [self startAnimation];
    }
}

- (void)setViewInfo{
    if (_direction == ZBCycleVerticalViewScrollDirectionDown) {
        if (self.view1.frame.origin.y == 0) {
            _tmpMiddleView = self.view1;
            _tmpTopView = self.view2;
        } else {
            _tmpMiddleView = self.view2;
            _tmpTopView = self.view1;
        }
    } else {
        if (self.view1.frame.origin.y == 0) {
            _tmpMiddleView = self.view1;
            _tmpBtmView = self.view2;
        } else {
            _tmpMiddleView = self.view2;
            _tmpBtmView = self.view1;
        }
    }
    _tmpMiddleView.dicData = _dataArray[_indexNow%(_dataArray.count)];
    if(_dataArray.count > 1){
        if (_direction == ZBCycleVerticalViewScrollDirectionDown) {
            _tmpTopView.dicData = _dataArray[(_indexNow+1)%(_dataArray.count)];
        } else {
            _tmpBtmView.dicData = _dataArray[(_indexNow+1)%(_dataArray.count)];
        }
    }
}

- (void)startAnimation{
    [self setViewInfo];
    if (_dataArray.count > 1) {
        [self stopTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_showTime target:self selector:@selector(executeAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
}

- (void)stopAnimation{
    [self stopTimer];
    [self.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
- (void)stopTimer{
    if(_timer){
        if([_timer isValid]){
            [_timer invalidate];
        }
        _timer = nil;
    }
}

- (void)btnClick{
    if (self.block) {
        self.block(_indexNow);
    }
}

@end
