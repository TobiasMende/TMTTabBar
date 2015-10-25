//
//  TMTTabBarView.h
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#include <Cocoa/Cocoa.h>

@class TMTTabView;

@interface TMTTabBarView : NSView


- (void) addTabView:(nonnull TMTTabView *)tabView;
- (void) removeTabView:(nonnull TMTTabView *)tabView;

@end

