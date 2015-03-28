//
//  CvlBeatMoleView.h
//  CvlPlayBeatMole
//
//  Created by qianfeng on 15/3/15.
//  Copyright (c) 2015年 陈威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CvlBeatMoleView : UIImageView
@property (nonatomic, assign) BOOL isJump;
- (id)initWithCenter:(CGPoint)center;
- (void)bombleMove;
@end
