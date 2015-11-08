//
//  TMTTabbedWindow.m
//  TMTTabBar
//
//  Created by Tobias Mende on 31.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabbedWindow.h"
#import "TMTTabBarView.h"
#import "TMTTabViewContainerView.h"

@interface TMTTabbedWindow ()

@end

@implementation TMTTabbedWindow {
    NSUInteger _counter;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    _counter = 0;
    _controller = [[TMTTabViewController alloc] initWithTabBar:self.tabBar container:self.tabContainer andDelegate:self];
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

- (void)tabChanged:(TMTTabItem *)item from:(TMTTabViewController *)sender {
}
@end
