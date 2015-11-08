//
//  TMTTabbedWindow.h
//  TMTTabBar
//
//  Created by Tobias Mende on 31.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabBarView;

@interface TMTTabbedWindow : NSWindowController<NSWindowDelegate>
@property (strong) IBOutlet TMTTabBarView *tabBar;
@property (strong) IBOutlet TMTTabViewContainerView *tabContainer;
@property (strong) TMTTabViewController *controller;
@property (weak) id<TMTTabViewDelegate> delegate;

- (id)initWithTabDelegate:(id <TMTTabViewDelegate>)delegate;
@end
