//
//  ZBCycleVerticalView.h
//  DeRong
//
//  Created by 周博 on 2019/1/7.
//  Copyright © 2019 周博. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ZBCycleVerticalViewScrollDirection) {
    ZBCycleVerticalViewScrollDirectionUp = 0,
    ZBCycleVerticalViewScrollDirectionDown
};

typedef void(^ClickBlock)(NSInteger index);

@interface ZBCycleVerticalView : UIView

@property (assign, nonatomic) ZBCycleVerticalViewScrollDirection direction;
@property (strong, nonatomic) NSArray *dataArray;  // 数据源
@property (copy, nonatomic) ClickBlock block;

- (void)configureShowTime:(double)showTime
            animationTime:(double)animationTime
                direction:(ZBCycleVerticalViewScrollDirection)direction
          backgroundColor:(UIColor *)backgroundColor
                textColor:(UIColor *)textColor font:(UIFont *)font
            textAlignment:(NSTextAlignment)textAlignment;
@end

NS_ASSUME_NONNULL_END
