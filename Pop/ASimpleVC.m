//
//  ASimpleVC.m
//  Prototypes
//
//  Created by Ryan Luas on 8/28/15.
//  Copyright (c) 2013 FAANG Interactive. All rights reserved.
//
#import "ViewController.h"
#import <POP/POP.h>
#import <POP/POPLayerExtras.h>

@interface ViewController ()
@property (nonatomic) CGFloat popAnimationProgress;
@end

@implementation ViewController

// popAnimation transition

- (void)togglePopAnimation:(BOOL)on {
  POPSpringAnimation *animation = [self pop_animationForKey:@"popAnimation"];
  
  if (!animation) {
    animation = [POPSpringAnimation animation];
    animation.springBounciness = 8;
    animation.springSpeed = 9;
    animation.property = [POPAnimatableProperty propertyWithName:@"popAnimationProgress" initializer:^(POPMutableAnimatableProperty *prop) {
      prop.readBlock = ^(ViewController *obj, CGFloat values[]) {
        values[0] = obj.popAnimationProgress;
      };
      prop.writeBlock = ^(ViewController *obj, const CGFloat values[]) {
        obj.popAnimationProgress = values[0];
      };
      prop.threshold = 0.001;
    }];
    
    [self pop_addAnimation:animation forKey:@"popAnimation"];
  }
  
  animation.toValue = on ? @(1.0) : @(0.0);
}

- (void)setPopAnimationProgress:(CGFloat)progress {
	_popAnimationProgress = progress;

	CGFloat transition = POPTransition(progress, 0, 1);
	POPLayerSetScaleXY(self.layer.layer, CGPointMake(transition, transition));
}

// Utilities

static inline CGFloat POPTransition(CGFloat progress, CGFloat startValue, CGFloat endValue) {
	return startValue + (progress * (endValue - startValue));
}

