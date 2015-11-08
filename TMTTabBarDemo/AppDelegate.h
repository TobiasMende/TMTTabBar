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
@class TMTTabbedWindow;

@interface AppDelegate : NSObject <NSApplicationDelegate, TMTTabViewDelegate>
@property (strong) TMTTabbedWindow *windowController1;

@end

