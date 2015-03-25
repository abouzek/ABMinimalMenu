//
//  ABMinimalMenu.h
//  Test
//
//  Created by Alan Bouzek on 3/10/15.
//  Copyright (c) 2015 Alan Bouzek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMinimalMenuMainItem.h"

@protocol ABMinimalMenuDelegate;


@interface ABMinimalMenu : UIView

-(instancetype)initWithFrame:(CGRect)frame
                      center:(CGPoint)center
                    mainItem:(ABMinimalMenuMainItem *)mainItem
                       items:(NSArray *)items
                    delegate:(id<ABMinimalMenuDelegate>)delegate;
-(void)open;
-(void)close;

@end


@protocol ABMinimalMenuDelegate <NSObject>

-(void)minimalMenu:(ABMinimalMenu *)menu didSelectItemAtIndex:(NSUInteger)index;

@optional
-(void)minimalMenuWillOpen:(ABMinimalMenu *)menu;
-(void)minimalMenuWillClose:(ABMinimalMenu *)menu;
-(void)minimalMenuDidClose:(ABMinimalMenu *)menu;
-(void)minimalMenuDidOpen:(ABMinimalMenu *)menu;

// Specify transforms to use for menu roll out/up and item selection
-(CGAffineTransform)minimalMenu:(ABMinimalMenu *)menu rolloutTransformForItemAtIndex:(NSUInteger)index;
-(CGAffineTransform)minimalMenu:(ABMinimalMenu *)menu selectTransformForItemAtIndex:(NSUInteger)index;
-(CGAffineTransform)minimalMenuSelectTransformForMainItem:(ABMinimalMenu *)menu;

@end

