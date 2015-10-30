//
// Created by Tobias Mende on 30.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabViewController;
@class TMTTabItem;

@protocol TMTTabViewDelegate <NSObject>

- (nonnull TMTTabItem*)createTab:(nonnull TMTTabViewController *)sender;

@optional

- (BOOL) shouldRemoveTab:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;
- (void) didRemoveTab:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;
- (void) tabChanged:(nonnull TMTTabItem*)item from:(nonnull TMTTabViewController*)sender;
@end