//
// Created by Tobias Mende on 30.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabViewController;
@class TMTTabItem;

@protocol TMTTabViewDelegate <NSObject>

- (nonnull TMTTabItem*)createTab:(nonnull TMTTabViewController *)sender;

@optional

#pragma mark - Permissions
- (bool) shouldRemoveTab:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;
- (bool) shouldDragToNewWindow:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController *)sender;
- (bool) shouldBecomeFirstResponder:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController *)sender;

#pragma mark - State Change
- (void) didRemoveTab:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;
- (void) tabChanged:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;

#pragma mark - Styling
- (nonnull TMTTabItemStyle *)tabItemStyle:(nonnull  TMTTabItem*)item from:(nonnull  TMTTabViewController *)sender;
- (nonnull TMTTabBarStyle *)tabBarStyle:(nonnull  TMTTabViewController *)sender;

@end