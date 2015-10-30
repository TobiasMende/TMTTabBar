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
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _controller = [[TMTTabViewController alloc] initWithTabBar:self.tabBar container:self.tabContainer andDelegate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)addTab:(id)sender {
    NSLog(@"addTab");
}

- (TMTTabItem *)createTab:(TMTTabViewController *)sender {
    TMTTabItem *item = [TMTTabItem new];
    item.label = @"Test";
    item.view = [NSView new];
    return item;
}

@end
