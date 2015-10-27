//
//  AppDelegate.h
//  TMTTabBarDemo
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTTabBarView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property int tabCounter;
@property (weak) IBOutlet TMTTabBarView *tabBar;
- (IBAction)addTab:(id)sender;

@end

