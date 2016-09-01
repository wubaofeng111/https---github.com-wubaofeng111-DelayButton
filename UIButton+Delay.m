//
//  UIView+Delay.m
//  ButtonDely
//
//  Created by friday on 16/9/1.
//  Copyright © 2016年 friday. All rights reserved.
//

#import "UIButton+Delay.h"
#import <objc/runtime.h>

const void * DelayKey = "DelayTimeKey";
const void * IsIgnore = "IsIgnore";
@implementation UIButton (Delay)
-(void)setIsIgnore:(BOOL)isIgnore
{
     objc_setAssociatedObject(self,IsIgnore, @(isIgnore), OBJC_ASSOCIATION_ASSIGN );
}
-(BOOL)isIgnore
{
    return [objc_getAssociatedObject(self, IsIgnore) boolValue];

}
-(void)setDelayTime:(NSTimeInterval)delayTime
{
    objc_setAssociatedObject(self,DelayKey, @(delayTime), OBJC_ASSOCIATION_ASSIGN );
}
-(NSTimeInterval)delayTime
{
       NSNumber*number =  objc_getAssociatedObject(self, DelayKey);
    return [number doubleValue];
}
+(void)load
{
    Method fromMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method toMethod = class_getInstanceMethod([self class], @selector(Delay_sendAction:to:forEvent:));
    method_exchangeImplementations(fromMethod, toMethod);
}
-(void)Delay_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.isIgnore) {
        return;
    }
    if (self.delayTime > 0) {
        self.isIgnore = YES;
       [self performSelector:@selector(setIsIgnore:) withObject:@(NO) afterDelay:self.delayTime];
    }
    [self Delay_sendAction:action to:target forEvent:event];
}
@end
