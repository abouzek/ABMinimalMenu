//
//  ABMinimalMenuMainItem.m
//
//  Created by Alan Bouzek on 3/25/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "ABMinimalMenuMainItem.h"

CGFloat const MAIN_ITEM_DEFAULT_ANIMATION_DURATION = 0.25;


@implementation ABMinimalMenuMainItem


#pragma mark - constructor

-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      image:(UIImage *)image {
    return [super initWithSize:size
                         color:color
                         title:nil
                          font:nil
                     textColor:nil
                         image:image];
}


#pragma mark - open/close animation

-(void)rotate {
    // Animate the imageView's rotation on open/close
    
    CGAffineTransform transform;
    if (CGAffineTransformIsIdentity(self.imageView.transform)) {
        CGFloat radians = 180 * M_PI / 180.0;
        transform = CGAffineTransformMakeRotation(radians);
    }
    else {
        transform = CGAffineTransformIdentity;
    }
    
    [UIView animateWithDuration:MAIN_ITEM_DEFAULT_ANIMATION_DURATION
                     animations:^{
                         self.imageView.transform = transform;
                     }
     ];
}

@end
