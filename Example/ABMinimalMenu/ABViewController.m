//
//  ABViewController.m
//  ABMinimalMenu
//
//  Created by abouzek on 03/25/2015.
//  Copyright (c) 2014 abouzek. All rights reserved.
//

#import "ABViewController.h"
#import "ABMinimalMenu.h"
#import "ABMinimalMenuItem.h"
#import "ABMinimalMenuMainItem.h"

@interface ABViewController () <ABMinimalMenuDelegate>

@property (strong, nonatomic) ABMinimalMenu *menu;

@end


@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGPoint center = CGPointMake(250.0, 500.0);
    CGSize itemSize = CGSizeMake(50, 50);
    UIFont *font = [UIFont systemFontOfSize:42.0];
    UIColor *textColor = [UIColor lightGrayColor];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.png"];
    UIImage *arrowImage = [UIImage imageNamed:@"arrow.png"];
    
    // Create main item
    ABMinimalMenuMainItem *mainItem = [[ABMinimalMenuMainItem alloc] initWithSize:itemSize
                                                                            color:[UIColor cyanColor]
                                                                            image:arrowImage];
    // Create all other items
    ABMinimalMenuItem *itemOne = [[ABMinimalMenuItem alloc] initWithSize:itemSize
                                                                   color:[UIColor greenColor]
                                                                   title:@"Item 1"
                                                                    font:font
                                                               textColor:textColor];
    ABMinimalMenuItem *itemTwo = [[ABMinimalMenuItem alloc] initWithSize:itemSize
                                                                   color:[UIColor magentaColor]
                                                                   title:@"Item 2"
                                                                    font:font
                                                               textColor:textColor];
    ABMinimalMenuItem *itemThree = [[ABMinimalMenuItem alloc] initWithSize:itemSize
                                                                     color:[UIColor yellowColor]
                                                                     title:@"Item 3"
                                                                      font:font
                                                                 textColor:textColor];
    // Two items have an image instead of a color
    ABMinimalMenuItem *itemFour = [[ABMinimalMenuItem alloc] initWithSize:itemSize
                                                                    image:placeholderImage
                                                                    title:@"Item 4"
                                                                     font:font
                                                                textColor:textColor];
    ABMinimalMenuItem *itemFive = [[ABMinimalMenuItem alloc] initWithSize:itemSize
                                                                    image:placeholderImage
                                                                    title:@"Item 5"
                                                                     font:font
                                                                textColor:textColor];
    self.menu = [[ABMinimalMenu alloc] initWithFrame:[UIScreen mainScreen].bounds
                                              center:center
                                            mainItem:mainItem
                                               items:@[itemOne,
                                                       itemTwo,
                                                       itemThree,
                                                       itemFour,
                                                       itemFive]
                                            delegate:self];
    
    [self.view addSubview:self.menu];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - ABMinimalMenuDelegate

-(void)minimalMenu:(ABMinimalMenu *)menu didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"Did select index %lu", index);
}

-(void)minimalMenuDidOpen:(ABMinimalMenu *)menu {
    NSLog(@"Did open");
}

-(void)minimalMenuDidClose:(ABMinimalMenu *)menu {
    NSLog(@"Did close");
}

-(void)minimalMenuWillOpen:(ABMinimalMenu *)menu {
    NSLog(@"Will open");
}

-(void)minimalMenuWillClose:(ABMinimalMenu *)menu {
    NSLog(@"Will close");
}

@end
