//
//  ABMinimalMenuItem.m
//
//  Created by Alan Bouzek on 3/10/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "ABMinimalMenuItem.h"

int const DEFAULT_LABEL_PADDING = 10;

@interface ABMinimalMenuItem ()

@property (nonatomic, readwrite) CGSize size;

@end


@implementation ABMinimalMenuItem


#pragma mark - constructors

-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color {
    return [self initWithSize:size
                        color:color
                        title:nil
                         font:nil
                    textColor:nil];
}
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor {
    return [self initWithSize:size
                        color:color
                        title:title
                         font:font
                    textColor:textColor
                        image:nil];
}
-(instancetype)initWithSize:(CGSize)size
                      image:(UIImage *)image
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor {
    return [self initWithSize:size
                        color:nil
                        title:title
                         font:font
                    textColor:textColor
                        image:image];
}
-(instancetype)initWithSize:(CGSize)size
                      color:(UIColor *)color
                      title:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image {
    if (self = [super init]) {
        self.backgroundColor = color;
        self.size = size;
        self.userInteractionEnabled = YES;
        self.alpha = 0;
        [self layoutSubviews];
        [self setupLabelWithTitle:title
                             font:font
                        textColor:textColor];
        if (image) {
            [self setupImageViewWithImage:image];
        }
    }
    return self;
}


#pragma mark - layout

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, self.size.width, self.size.height);
}


#pragma mark - setup

-(void)setupLabelWithTitle:(NSString *)title
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor {
    self.label = [UILabel new];
    self.label.text = title;
    self.label.font = font;
    [self.label sizeToFit];
    
    CGRect labelFrame = self.label.frame;
    labelFrame.origin.x = -(labelFrame.size.width + DEFAULT_LABEL_PADDING);
    labelFrame.size.height = self.size.height;
    self.label.frame = labelFrame;
    
    self.label.textColor = textColor;
    self.label.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleLeftMargin);
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.alpha = 0;
    
    [self addSubview:self.label];
}

-(void)setupImageViewWithImage:(UIImage *)image {
    self.imageView = [UIImageView new];
    self.imageView.image = image;
    self.imageView.frame = self.bounds;
    if (image.size.width <= self.bounds.size.width &&
        image.size.height <= self.bounds.size.height) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    else {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    [self addSubview:self.imageView];
}


#pragma mark - touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate minimalMenuItemTouchesBegan:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        [self.delegate minimalMenuItemTouchesEnded:self];
    }
}

@end
