//
// Created by Tobias Mende on 01.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabItemView;
@class TMTTabViewController;


@interface TMTTabAreaView : NSStackView<NSDraggingDestination>
@property (weak) id<TMTTabDraggingDelegate, TMTTabBarDelegate> parent;

- (nonnull instancetype)init;
- (void)addTabView:(nonnull TMTTabItemView *)tabView;
- (void)addTabView:(nonnull TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation;
- (void)removeTabView:(nonnull TMTTabItemView *)tabView;

- (NSRect)boundsForDraggingItem;
@end