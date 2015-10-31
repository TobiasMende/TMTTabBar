//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMTTabBarStyle : NSObject

@property NSColor* backgroundColor;
@property CGFloat addButtonSpacing;
@property BOOL shouldShowAddButton;

- (instancetype)init;

@end