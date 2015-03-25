# ABMinimalMenu

[![Version](https://img.shields.io/cocoapods/v/ABMinimalMenu.svg?style=flat)](http://cocoadocs.org/docsets/ABMinimalMenu)
[![License](https://img.shields.io/cocoapods/l/ABMinimalMenu.svg?style=flat)](http://cocoadocs.org/docsets/ABMinimalMenu)
[![Platform](https://img.shields.io/cocoapods/p/ABMinimalMenu.svg?style=flat)](http://cocoadocs.org/docsets/ABMinimalMenu)

## Description

A simple menu with easily customizable animations and an easy to use interface. ABMinimalMenu provides a simple form of menu navigation which can be tailored to many use cases.

## Example

![alt tag](https://www.github.com/abouzek/ABMinimalMenu/raw/master/example.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The main menu item will always be showing. Selecting this item will roll out the menu items. Currently, ABMinimalMenu will rotate the image specified in the constructor 180 degrees on ABMinimalMenu open and close. The main item should be created using the ABMinimalMenuMainItem initializer:

    -(instancetype)initWithSize:(CGSize)size
                          color:(UIColor *)color
                          image:(UIImage *)image;

Each menu item can either display a static image, just a background color, or both. Create each menu item with the ABMinimalMenuItem initializers specified in ABMinimalMenuItem.h. For example, to create an item with both an image and background color, use:

    -(instancetype)initWithSize:(CGSize)size
                          color:(UIColor *)color
                          title:(NSString *)title
                           font:(NSFont *)font
                      textColor:(UIColor *)textColor
                          image:(UIImage *)image;
where the title, font and textColor attributes control the appearance of the item's optional inline label.

An instance of ABMinimalMenu should be created using the initializer:

    -(instancetype)initWithFrame:(CGRect)frame
                          center:(CGPoint)center
                        mainItem:(ABMinimalMenuMainItem *)mainItem
                           items:(NSArray *)items
                        delegate:(id<ABMinimalMenuDelegate>)delegate;

* The items NSArray should contain instances of ABMinimalMenuItem.

* Center is the center point of the main menu item.


To respond to menu item selection, open and close events, and customize animations, implement the ABMinimalMenuDelegate protocol. For animation customization, use:

    -(CGAffineTransform)minimalMenu:(ABMinimalMenu *)menu rolloutTransformForItemAtIndex:(NSUInteger)index;
    -(CGAffineTransform)minimalMenu:(ABMinimalMenu *)menu selectTransformForItemAtIndex:(NSUInteger)index;
    -(CGAffineTransform)minimalMenuSelectTransformForMainItem:(ABMinimalMenu *)menu;

and for other events, see the protocol definition in ABMinimalMenu.h.

## Installation

ABMinimalMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ABMinimalMenu"

## Author

Alan Bouzek, github: abouzek, alan.bouzek@gmail.com

## License

ABMinimalMenu is available under the MIT license. See the LICENSE file for more info.
