//
//  ABMinimalMenu.m
//  Test
//
//  Created by Alan Bouzek on 3/10/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import "ABMinimalMenu.h"
#import "ABMinimalMenuItem.h"

CGFloat const MENU_DEFAULT_ANIMATION_DURATION = 0.2;
CGFloat const MENU_DEFAULT_ANIMATION_DELAY = 0.05;

@interface ABMinimalMenu () <ABMinimalMenuItemDelegate>

@property (weak, nonatomic) id<ABMinimalMenuDelegate> delegate;

@property (nonatomic, setter=setOpen:, getter=isOpen) BOOL open;
@property (nonatomic) BOOL isAnimating;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) ABMinimalMenuMainItem *mainItem;
@property (nonatomic) CGPoint centerPoint;

@end


@implementation ABMinimalMenu

@synthesize open = _open;


#pragma mark - constructor

-(instancetype)initWithFrame:(CGRect)frame
                      center:(CGPoint)center
                    mainItem:(ABMinimalMenuMainItem *)mainItem
                       items:(NSArray *)items
                    delegate:(id<ABMinimalMenuDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.mainItem = mainItem;
        self.items = items;
        self.delegate = delegate;
        self.centerPoint = center;
        
        self.mainItem.delegate = self;
        self.mainItem.center = center;
        self.mainItem.alpha = 1;
        [self addSubview:self.mainItem];
    }
    return self;
}


#pragma mark - open/close

-(void)open {
    if (self.isAnimating || self.isOpen) {
        return;
    }
    self.open = YES;
}

-(void)close {
    if (self.isAnimating || !self.isOpen) {
        return;
    }
    self.open = NO;
}

-(BOOL)isOpen {
    return _open;
}

-(void)setOpen:(BOOL)open {
    if (open) {
        [self addItems];
        
        if ([self.delegate respondsToSelector:@selector(minimalMenuWillOpen:)]) {
            [self.delegate minimalMenuWillOpen:self];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(minimalMenuWillClose:)]) {
            [self.delegate minimalMenuWillClose:self];
        }
    }
    
    _open = open;
    
    self.isAnimating = YES;
    if (open) {
        [self animateOpen];
    }
    else {
        [self animateClose];
    }
}

-(void)addItems {
    NSInteger count = self.items.count;
    for (int i = 0; i < count; ++i) {
        ABMinimalMenuItem *item = self.items[i];
        item.delegate = self;
        item.center = self.mainItem.center;
        item.alpha = 0;
        item.label.alpha = 0;
        item.tag = [self tagForItemAtIndex:i];
        
        [self insertSubview:item belowSubview:self.mainItem];
    }
}


#pragma mark - open/close animation
#pragma mark - open animation
-(void)animateOpen {
    [self animateOpenForItemAtIndex:@(self.items.count - 1)];
}

-(void)animateOpenForItemAtIndex:(NSNumber *)indexNumber {
    // Animate each item's rollout
    
    NSInteger index = [indexNumber integerValue];
    if (index == -1) {
        [self.mainItem rotate];
        
        if ([self.delegate respondsToSelector:@selector(minimalMenuDidOpen:)]) {
            [self.delegate minimalMenuDidOpen:self];
        }
        
        self.isAnimating = NO;
        return;
    }
    
    ABMinimalMenuItem *item = self.items[index];
    item.transform = [self itemRolloutTransformForIndex:index];

    float y = (item.size.height + 20) * (index + 1);
    CGPoint endPoint = [self translatedPoint:self.mainItem.center
                                           x:0
                                           y:-y];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:MENU_DEFAULT_ANIMATION_DURATION animations:^{
            item.alpha = 1;
            item.label.alpha = 1;
            item.center = endPoint;
            item.transform = CGAffineTransformIdentity;
            [self performSelector:@selector(animateOpenForItemAtIndex:)
                       withObject:@(index - 1)
                       afterDelay:MENU_DEFAULT_ANIMATION_DELAY];
        }];
    });
}


#pragma mark - close animation

-(void)animateClose {
    [self animateCloseForItemAtIndex:0];
}

-(void)animateCloseForItemAtIndex:(NSNumber *)indexNumber {
    // Animate each item's rollup
    
    NSInteger index = [indexNumber integerValue];
    if (index == self.items.count) {
        [self.mainItem rotate];

        [self clearItemSubviews];
        
        if ([self.delegate respondsToSelector:@selector(minimalMenuDidClose:)]) {
            [self.delegate minimalMenuDidClose:self];
        }
        
        self.isAnimating = NO;
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ABMinimalMenuItem *item = self.items[index];
        [UIView animateWithDuration:MENU_DEFAULT_ANIMATION_DURATION animations:^{
            item.alpha = 0;
            item.label.alpha = 0;
            item.center = self.centerPoint;
            item.transform = [self itemRolloutTransformForIndex:[self indexForItem:item]];
            [self performSelector:@selector(animateCloseForItemAtIndex:)
                       withObject:@(index + 1)
                       afterDelay:MENU_DEFAULT_ANIMATION_DELAY];
        }];
    });
}


#pragma mark - touches

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isAnimating) {
        return NO;
    }
    else if (self.isOpen) {
        return YES;
    }
    return CGRectContainsPoint(self.mainItem.frame, point);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.open = !self.isOpen;
}


#pragma mark - ABMinimalMenuItemDelegate

-(void)minimalMenuItemTouchesBegan:(ABMinimalMenuItem *)item {
    if (item == self.mainItem) {        
        self.open = !self.isOpen;
        
        // Animate the main item selection
        CGAffineTransform oldTransform = item.transform;
        item.transform = CGAffineTransformConcat(oldTransform, [self mainItemSelectTransform]);
        [UIView animateWithDuration:MENU_DEFAULT_ANIMATION_DURATION
                         animations:^{
                             item.transform = oldTransform;
                         }
         ];
    }
}

-(void)minimalMenuItemTouchesEnded:(ABMinimalMenuItem *)item {
    if (item == self.mainItem) {
        return;
    }
    
    // Animate the item selection
    item.transform = [self itemSelectTransformForIndex:[self indexForItem:item]];
    [UIView animateWithDuration:MENU_DEFAULT_ANIMATION_DURATION
                     animations:^{
                         item.transform = CGAffineTransformIdentity;
                     }
     ];
    
    self.open = NO;
    
    if ([self.delegate respondsToSelector:@selector(minimalMenu:didSelectItemAtIndex:)]) {
        [self.delegate minimalMenu:self didSelectItemAtIndex:[self indexForItem:item]];
    }
}


#pragma mark - utility

-(void)clearItemSubviews {
    NSInteger count = self.items.count;
    for (int i = 0; i < count; ++i) {
        [[self viewWithTag:[self tagForItemAtIndex:i]] removeFromSuperview];
    }
}

-(NSInteger)tagForItemAtIndex:(NSInteger)index {
    return index + 1;
}

-(NSInteger)indexForItem:(ABMinimalMenuItem *)item {
    NSInteger count = self.items.count;
    for (int i = 0; i < count; ++i) {
        ABMinimalMenuItem *storedItem = self.items[i];
        if (storedItem == item) {
            return i;
        }
    }
    return -1;
}

-(CGPoint)translatedPoint:(CGPoint)point x:(CGFloat)x y:(CGFloat)y {
    return CGPointMake(point.x + x, point.y + y);
}


#pragma mark - transforms

-(CGAffineTransform)itemRolloutTransformForIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(minimalMenu:rolloutTransformForItemAtIndex:)]) {
        return [self.delegate minimalMenu:self rolloutTransformForItemAtIndex:index];
    }
    
    // Default transform
    CGAffineTransform scale = CGAffineTransformMakeScale(0.4, 0.4);
    CGAffineTransform rotate = CGAffineTransformMakeRotation(10 * M_PI / 180.0);
    return CGAffineTransformConcat(rotate, scale);
}

-(CGAffineTransform)itemSelectTransformForIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(minimalMenu:selectTransformForItemAtIndex:)]) {
        return [self.delegate minimalMenu:self selectTransformForItemAtIndex:index];
    }
    
    // Default transform
    return CGAffineTransformMakeScale(1.2, 1.2);
}

-(CGAffineTransform)mainItemSelectTransform {
    if ([self.delegate respondsToSelector:@selector(minimalMenuSelectTransformForMainItem:)]) {
        return [self.delegate minimalMenuSelectTransformForMainItem:self];
    }
    
    // Default transform
    return CGAffineTransformMakeScale(1.2, 1.2);
}

@end
