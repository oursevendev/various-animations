//
//  FadingSegue.m
//  Prototypes
//
//  Created by Ryan Luas on 3/9/13.
//  Copyright (c) 2013 FAANG Interactive. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FadingSegue.h"


@implementation FadingSegue
@synthesize fadeOut;
@synthesize delegate;


#define SAFE_PERFORM_WITH_ARG(THE_OBJECT,THE_SELECTOR,THE_ARG) (([THE_OBJECT respondsToSelector:THE_SELECTOR]) ? [THE_OBJECT performSelector:THE_SELECTOR withObject:THE_ARG] : nil)
#define kAnimationKey @"TransitionViewAnimation"

-(void)constructLayers
{
    UIViewController *source = (UIViewController *) super.sourceViewController;
    //UIViewController *dest = (UIViewController*) super.destinationViewController;
    hostView = source.view.superview;

    transformLayer = [CALayer layer];
    transformLayer.frame = hostView.bounds;
    transformLayer.anchorPoint = CGPointMake(0.5f,0.5f);
    CATransform3D sublayerTransform = CATransform3DIdentity;
    sublayerTransform.m34 = 1.0 / -5000;
    [transformLayer setSublayerTransform:sublayerTransform];
    [hostView.layer addSublayer:transformLayer];
}

 -(void)animateWithDuration:(CGFloat)aDuration
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = aDuration;
    
    float multiplier = fadeOut ? -1.0f : 1.0f;
    
    CABasicAnimation *opaqueLevels = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opaqueLevels setToValue:[NSNumber numberWithFloat:multiplier]];
    [opaqueLevels setDuration:0.2f];
     
    
    group.animations = [NSArray arrayWithObjects:opaqueLevels, nil];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [CATransaction flush];
    [transformLayer addAnimation:group forKey:kAnimationKey];
    //[transformLayer release];
}


-(void)animationDidStart:(CAAnimation*)animation
{
    UIViewController *source = (UIViewController*) super.sourceViewController;
    NSLog(@"source controller... %@",source);
    [source.view removeFromSuperview];
}
-(void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished
{
    UIViewController *dest = (UIViewController*) super.destinationViewController;
    [hostView addSubview:dest.view];
    [hostView bringSubviewToFront:dest.view];
    //[transformLayer release];
    //[transformLayer removeFromSuperlayer];
    if(delegate)
        SAFE_PERFORM_WITH_ARG(delegate,@selector(segueDidComplete),nil);

}

-(void)perform
{
    NSLog(@"performed");
    
    
    CATransition* transition = [CATransition animation];
     transition.duration = 0.3f;
     transition.type = kCATransitionFade;
     [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
     [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];

}
@end
