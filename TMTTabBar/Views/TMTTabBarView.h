//
//  TMTTabBarView.h
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#include <Cocoa/Cocoa.h>
#import "TMTTabItemDelegate.h"

@class TMTTabItemView;
@class TMTTabBarStyle;
@protocol TMTTabBarDelegate;

@interface TMTTabBarView : NSView<NSDraggingDestination>

@property (nonnull, nonatomic) TMTTabBarStyle *style;
@property (weak) id<TMTTabBarDelegate> parent;

- (void)addTabView:(nonnull TMTTabItemView *)tabView;

- (void)addTabView:(nonnull TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation;

- (void)removeTabView:(nonnull TMTTabItemView *)tabView;
- (void)activateTabItem:(nonnull TMTTabItemView *)actionedItem;


@end

