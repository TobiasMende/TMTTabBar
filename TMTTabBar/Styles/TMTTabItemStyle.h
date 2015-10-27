//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMTTabItemStyle : NSObject

@property (nonnull) NSColor *inactiveBackgroundColor;
@property (nonnull) NSColor *activeBackgroundColor;

@property (nonnull) NSColor *inactiveBorderColor;
@property (nonnull) NSColor *activeBorderColor;

@property (nonnull) NSColor *inactiveTextColor;
@property (nonnull) NSColor *activeTextColor;

@property CGFloat rightMargin;
@property CGFloat leftMargin;

- (id _Nonnull) init;

@end
