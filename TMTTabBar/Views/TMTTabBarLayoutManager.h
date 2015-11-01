//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMTTabBarLayoutManager : NSObject

- (nonnull instancetype)initForView:(NSView *_Nonnull)view;


- (void)removeView:(NSView *)view;
- (void)addView:(NSView *)view;
- (void)insertView:(NSView *)view at:(NSUInteger)index;

- (void)updateLayout;
- (void)updateLayoutWithDropSpaceAt:(NSUInteger)dropPosition;
@end