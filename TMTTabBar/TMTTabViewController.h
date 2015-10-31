//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "TMTTabBarDelegate.h"
#import "TMTTabItemDelegate.h"

@class TMTTabBarView;
@class TMTTabItem;
@protocol TMTTabViewDelegate;

@interface TMTTabViewController : NSObject<TMTTabItemDelegate, TMTTabBarDelegate>

@property (weak) id<TMTTabViewDelegate>delegate;

- (nonnull instancetype)initWithTabBar:(nonnull TMTTabBarView *)tabBar container:(nonnull NSBox *)container andDelegate:(nonnull id<TMTTabViewDelegate>)delegate;

- (void)addTabItem:(nonnull TMTTabItem*)item;
- (void)removeTabItem:(nonnull TMTTabItem*)item;
@end