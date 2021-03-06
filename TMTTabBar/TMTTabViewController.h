//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "TMTTabBarDelegate.h"
#import "TMTTabItemDelegate.h"
#import "TMTTabContainerDelegate.h"
#import "TMTTabDraggingDelegate.h"

@class TMTTabBarView;
@class TMTTabItem;
@class TMTTabViewContainerView;
@class TMTTabViewDelegateProxy;
@protocol TMTTabViewDelegate;

@interface TMTTabViewController : NSObject<TMTTabItemDelegate, TMTTabBarDelegate, TMTTabContainerDelegate, TMTTabDraggingDelegate>

- (nonnull instancetype)initWithTabBar:(nonnull TMTTabBarView *)tabBar container:(nonnull TMTTabViewContainerView *)container andDelegate:(nonnull id<TMTTabViewDelegate>)delegate;

- (void)addTabItem:(nonnull TMTTabItem*)item;
- (BOOL)removeTabItem:(nonnull TMTTabItem*)item;
- (void)beginWithItem:(nonnull TMTTabItem *)tabItem;
@end