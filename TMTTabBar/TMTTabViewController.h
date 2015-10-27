//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabBarView;
@class TMTTabItem;


@interface TMTTabViewController : NSObject

@property (nonnull) TMTTabBarView *tabBar;
@property (nonnull) NSBox *tabContainer;


- (void)addTabItem:(TMTTabItem* _Nonnull)item;
- (void)removeTabItem:(TMTTabItem* _Nonnull)item;
@end