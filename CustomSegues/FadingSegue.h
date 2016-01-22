//
//  FadingSegue.h
//  Toyo Products
//
//  Created by R7Dev on 3/9/13.
//  Copyright (c) 2013 SIM Media Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadingSegue : UIStoryboardSegue
{
    CALayer *transformLayer;
    UIView __weak *hostView;
}

@property (assign) BOOL fadeOut;

@property (assign) UIViewController *delegate;

@end
