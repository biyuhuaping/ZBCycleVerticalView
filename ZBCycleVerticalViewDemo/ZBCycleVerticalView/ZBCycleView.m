//
//  ZBCycleView.m
//  CycleVerticalView
//
//  Created by 周博 on 2019/1/8.
//  Copyright © 2019 EL. All rights reserved.
//

#import "ZBCycleView.h"
@interface ZBCycleView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subLabel;

@end

@implementation ZBCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        _subLabel = [[UILabel alloc] init];
        _subLabel.font = [UIFont systemFontOfSize:14];
        _subLabel.textColor = [UIColor blackColor];
        _subLabel.numberOfLines = 0;
        [self addSubview:_subLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(15, 15, CGRectGetWidth(self.frame)-30, 25);
    _subLabel.frame = CGRectMake(15, CGRectGetMaxY(_titleLabel.frame)+2, CGRectGetWidth(self.frame)-30, 64);
}

- (void)setDicData:(NSDictionary *)dicData{
    _dicData = dicData;
    _titleLabel.text = dicData[@"TITLE"];
    _subLabel.text = dicData[@"BRIEF"];
}

@end
