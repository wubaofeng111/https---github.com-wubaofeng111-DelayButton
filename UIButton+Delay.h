//
//  UIView+Delay.h
//  ButtonDely
//
//  Created by friday on 16/9/1.
//  Copyright © 2016年 friday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Delay)
@property(nonatomic,assign)NSTimeInterval delayTime;
@property(nonatomic,assign)BOOL           isIgnore;
@end
