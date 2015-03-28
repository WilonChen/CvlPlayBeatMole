//
//  CvlBeatMoleView.m
//  CvlPlayBeatMole
//
//  Created by qianfeng on 15/3/15.
//  Copyright (c) 2015年 陈威. All rights reserved.
//

#import "CvlBeatMoleView.h"
#define MOVE_DISTANCE 80
@interface CvlBeatMoleView ()
{
    CGFloat _speed;
    CGFloat _currentDistance;
}
@end
@implementation CvlBeatMoleView

- (id)initWithCenter:(CGPoint)center {
    if (self = [super init]) {
        // 给老鼠一个默认图片 被打后动画停止时 显示
        UIImage *image = [UIImage imageNamed:@"Mole04"];
        // 设置位置
        self.center = center;
        // 设置大小
        self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        self.image = image;
        // 创建老鼠按钮
        [self createButton];
        self.userInteractionEnabled = YES;
        [self moleAnimation];
        _speed = 1;
    }
    
    return self;
}
- (void)moleAnimation {
    NSMutableArray *animatonImage = [NSMutableArray array];
    UIImage *moleImge = [[UIImage alloc] init];
    for (NSInteger i = 1; i <= 4; i++) {
        // 实现 连续播放 12321
        if (4 == i) {
            moleImge = [UIImage imageNamed:@"Mole02"];
        } else {
            NSString *string = [NSString stringWithFormat:@"Mole0%i",(int)i];
            moleImge = [UIImage imageNamed:string];
        }
        [animatonImage addObject:moleImge];
    }
    
    // 将老鼠动画数组 给  动画
    self.animationImages = animatonImage;
    // 动画持续时间
    self.animationDuration = 0.01;
    // 动画重复次数
    self.animationRepeatCount = 0;
    // 平时  播放动画
    [self startAnimating];
}
- (void)createButton {
    UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
    // 给按钮添加点击事件
    [button addTarget:self action:@selector(beatMole) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    
    [button release];
}
- (void)beatMole {
    if (self.isAnimating == NO) {
        return;
    }
    [self stopAnimating];
    // 如果超过高度自己回去
    if (_currentDistance >= MOVE_DISTANCE) {
        
    } else {
        //如果 在上升过程 让它跳到 下降过程
        _currentDistance = 2 * MOVE_DISTANCE - _currentDistance;
    }
}
- (void)bombleMove {
    if (_isJump == NO) {
        return;
    }
    CGPoint center = self.center;
    if (_currentDistance < MOVE_DISTANCE) {
        center.y -= _speed;
        _currentDistance += _speed;
    } else if (_currentDistance < 2 * MOVE_DISTANCE) {
        center.y += _speed;
        _currentDistance += _speed;
    } else {
        //老鼠进洞
        _currentDistance = 0;
        [self startAnimating];
    }
    self.center = center;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
