//
// Created by Tobias Mende on 08.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabItem;

@interface TMTTabViewDelegateProxy : NSObject
@property(weak, readonly) id <TMTTabViewDelegate> delegate;


- (bool)shouldRemoveItem:(nonnull TMTTabItem *)item;

- (nonnull instancetype)initWithController:(nonnull TMTTabViewController *)controller andDelegate:(nonnull id <TMTTabViewDelegate>)delegate;

- (bool)shouldDragToNewWindow:(nonnull TMTTabItem *)item;

- (bool)shouldBecomeFirstResponder:(nonnull TMTTabItem *)item;

- (bool)shouldCloseWindowIfLastTabIsRemoved;

- (void)informItemRemoved:(nonnull TMTTabItem *)item;

- (void)informItemChanged:(nonnull TMTTabItem *)item;

- (nonnull TMTTabItemStyle *)styleForItem:(nonnull TMTTabItem *)item;

- (nonnull TMTTabBarStyle *)styleForBar;

- (nonnull TMTTabItem *)createTab;
@end