//
//  AppDelegate.h
//  TMTTabBarDemo
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <TMTTabBar/TMTTabItemDelegate.h>
@class TMTTabBarView;


@interface AppDelegate : NSObject <NSApplicationDelegate, TMTTabViewDelegate>

@property int tabCounter;
@property (nonnull) TMTTabViewController *controller;
@property (nonnull) IBOutlet TMTTabBarView *tabBar;
@property (nonnull) IBOutlet NSBox *tabContainer;

@end

