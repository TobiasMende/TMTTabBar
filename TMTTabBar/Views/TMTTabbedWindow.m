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
#import "TMTTabWindowFactory.h"

@interface TMTTabbedWindow ()

@end

@implementation TMTTabbedWindow {
}

- (id)initWithTabDelegate:(id <TMTTabViewDelegate>)delegate {
    self = [super initWithWindowNibName:@"TMTTabbedWindow"];
    if(self) {
        _delegate = delegate;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    _controller = [[TMTTabViewController alloc] initWithTabBar:self.tabBar container:self.tabContainer andDelegate:self.delegate];
}

- (void)windowWillClose:(NSNotification *)notification {
    [TMTTabWindowFactory unregister:self];
}
@end
