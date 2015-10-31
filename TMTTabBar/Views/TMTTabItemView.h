//
//  TMTTabItemView.h
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabItemStyle;
@protocol TMTTabItemDelegate;
@class TMTTabItem;

@interface TMTTabItemView : NSView<NSDraggingSource, NSPasteboardItemDataProvider>

@property (nonnull) TMTTabItem* item;
@property (nonnull) TMTTabItemStyle *style;
@property (weak) id<TMTTabItemDelegate> parent;

- (nonnull instancetype)initWithItem:(TMTTabItem *_Nonnull)item andStyle:(nonnull TMTTabItemStyle *)style;

- (void)setActive:(BOOL)active;

@end
