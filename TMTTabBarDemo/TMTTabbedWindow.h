//
//  TMTTabbedWindow.h
//  TMTTabBar
//
//  Created by Tobias Mende on 31.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabBarView;

@interface TMTTabbedWindow : NSWindowController<TMTTabViewDelegate>
@property (strong) IBOutlet TMTTabBarView *tabBar;
@property (strong) IBOutlet TMTTabViewContainerView *tabContainer;
@property (strong) TMTTabViewController *controller;
@end
