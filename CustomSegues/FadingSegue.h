//
//  FadingSegue.h
//  Prototypes
//
//  Created by Ryan Luas on 3/9/13.
//  Copyright (c) 2013 FAANG Interactive. All rights reserved.
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
