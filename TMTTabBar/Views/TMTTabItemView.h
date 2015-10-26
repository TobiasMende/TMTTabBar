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
@property (nonnull) NSString *label;
@property (nonatomic) BOOL active;
@property (nonnull) TMTTabItemStyle *style;
@property (weak) id<TMTTabItemDelegate> parent;
@end
