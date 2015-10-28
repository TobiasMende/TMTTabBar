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

@interface TMTTabItemView : NSView

@property (nonnull) NSString* title;
@property (nonnull, readonly) NSBox *customView;

@property (nonnull) TMTTabItemStyle *style;
@property (weak) id<TMTTabItemDelegate> parent;

- (void)setActive:(BOOL)active;
@end
