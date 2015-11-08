//
//  AppDelegate.m
//  TMTTabBarDemo
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabItemView.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property NSUInteger counter;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _windowController1 = [[TMTTabbedWindow alloc] initWithWindowNibName:@"TMTTabbedWindow"];
    _windowController2 = [[TMTTabbedWindow alloc] initWithWindowNibName:@"TMTTabbedWindow"];
    
    [self.windowController1 showWindow:self];
    [self.windowController2 showWindow:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
