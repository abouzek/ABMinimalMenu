//
//  ABMinimalMenuItem.h
//
//  Created by Alan Bouzek on 3/10/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABMinimalMenuItemDelegate;


@interface ABMinimalMenuItem : UIView

@property (nonatomic, readonly) CGSize size;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;
@property (weak, nonatomic) id<ABMinimalMenuItemDelegate> delegate;

/**
 @param size      - size of the element
 @param color     - background color
 @param title     - side label text
 @param font      - side label font
 @param textColor - side label text color
 @param image - image to use instead of background color
 
 @return an instance of ABMinimalMenuItem
 */

-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color;
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor;
-(instancetype)initWithSize:(CGSize)size
                      image:(UIImage *)image
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor;
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image;

@end


@protocol ABMinimalMenuItemDelegate <NSObject>

-(void)minimalMenuItemTouchesBegan:(ABMinimalMenuItem *)item;
-(void)minimalMenuItemTouchesEnded:(ABMinimalMenuItem *)item;

@end
