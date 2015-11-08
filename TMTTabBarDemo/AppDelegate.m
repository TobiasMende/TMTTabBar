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
    _windowController1 = [[TMTTabbedWindow alloc] initWithTabDelegate:self];

    [self.windowController1 showWindow:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (TMTTabItem *)createTab:(TMTTabViewController *)sender {
    TMTTabItem *item = [TMTTabItem new];
    item.label = [NSString stringWithFormat:@"Tab %li", _counter++];
    NSTextField *label = [NSTextField new];
    [label setStringValue:item.label];
    item.view = label;

    NSImageView *customView = [NSImageView new];
    customView.image = [NSImage imageNamed:NSImageNameTrashFull];
    item.customView = customView;
    return item;
}

@end
