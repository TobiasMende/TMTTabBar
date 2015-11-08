//
// Created by Tobias Mende on 07.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabWindowFactory.h"
#import "TMTTabViewController.h"
#import "TMTTabbedWindow.h"
#import "TMTTabViewDelegate.h"
#import "NSWindow+TMTAppearance.h"


static NSMutableArray<TMTTabbedWindow*>* _windows;
@implementation TMTTabWindowFactory {
}

+ (void)initialize {
    _windows = [NSMutableArray new];
}

+ (nonnull TMTTabViewController *)createTabWindow:(id <TMTTabViewDelegate>)delegate atPosition:(NSPoint)position {
    TMTTabbedWindow *window = [[TMTTabbedWindow alloc] initWithTabDelegate:delegate];

    [window.window appearAtPosition:position];

    [_windows addObject:window];
    return window.controller;
}

+ (void)unregister:(TMTTabbedWindow *)window {
    [_windows removeObject:window];
}


@end