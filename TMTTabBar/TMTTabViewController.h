//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabBarView;


@interface TMTTabViewController : NSObject

@property (nonnull) TMTTabBarView *tabBar;
@property (nonnull) NSBox *tabContainer;

// TODO add methods for addition and removal of tab items (and add TMTTabItem as container for a view and a tab label ...)
@end