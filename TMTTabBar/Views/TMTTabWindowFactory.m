//
// Created by Tobias Mende on 07.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabWindowFactory.h"
#import "TMTTabViewController.h"
#import "TMTTabbedWindow.h"


static NSMutableArray<TMTTabbedWindow*>* _windows;
@implementation TMTTabWindowFactory {
}

+ (void)initialize {
    _windows = [NSMutableArray new];
}

+ (TMTTabViewController *)createTabWindow {
    TMTTabbedWindow *window = [[TMTTabbedWindow alloc] initWithWindowNibName:@"TMTTabbedWindow"];
    [window showWindow:nil];
    [_windows addObject:window];
    return window.controller;
}

+ (void)unregister:(TMTTabbedWindow *)window {
    [_windows removeObject:window];
}


@end