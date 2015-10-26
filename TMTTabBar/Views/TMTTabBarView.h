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

@interface TMTTabBarView : NSView <TMTTabItemDelegate>


- (void) addTabView:(nonnull TMTTabItemView *)tabView;
- (void) removeTabView:(nonnull TMTTabItemView *)tabView;

@end

