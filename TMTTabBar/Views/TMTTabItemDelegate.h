//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabItem;

@protocol TMTTabItemDelegate <NSObject>
- (void)selectTab:(nonnull TMTTabItem *)item;
- (void)closeTab:(nonnull TMTTabItem *)item;
- (void)draggingSession:(nullable NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation forItem:(nonnull TMTTabItem *)item;
- (BOOL)removeTabItem:(nonnull TMTTabItem*)item;
@end