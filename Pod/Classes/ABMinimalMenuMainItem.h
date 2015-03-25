//
//  ABMinimalMenuMainItem.h
//
//  Created by Alan Bouzek on 3/25/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "ABMinimalMenuItem.h"

@protocol ABMinimalMenuMainItemDelegate;


@interface ABMinimalMenuMainItem : ABMinimalMenuItem

/**
 @param size - item size
 @param color - background color
 @param closedImage - image when menu is closed
 @param openImage - image when menu is open
 
 @return an instance of ABMinimalMenuMainItem
 */
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      image:(UIImage *)image;

-(void)rotate;

@end
