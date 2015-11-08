//
// Created by Tobias Mende on 08.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabViewDelegateProxy.h"
#import "TMTTabViewController.h"
#import "TMTTabItem.h"
#import "TMTTabViewDelegate.h"


@implementation TMTTabViewDelegateProxy
{
    __weak TMTTabViewController *_controller;
}

- (id)initWithController:(TMTTabViewController *)controller andDelegate:(id <TMTTabViewDelegate>)delegate {
    self = [super init];
    if(self) {
        _controller = controller;
        _delegate = delegate;
    }
    return self;
}

- (bool)shouldRemoveItem:(TMTTabItem *)item {
    return ![_delegate respondsToSelector:@selector(shouldRemoveTab:from:)] || [_delegate shouldRemoveTab:item from:_controller];
}

- (bool)shouldDragToNewWindow:(TMTTabItem *)item {
    if([_delegate respondsToSelector:@selector(shouldDragToNewWindow:from:)]) {
        return [_delegate shouldDragToNewWindow:item from:_controller];
    }
    return YES;
}

- (bool)shouldBecomeFirstResponder:(TMTTabItem*)item {
    if([_delegate respondsToSelector:@selector(shouldBecomeFirstResponder:from:)]) {
        return [_delegate shouldBecomeFirstResponder:item from:_controller];
    }
    return YES;
}

- (bool)shouldCloseWindowIfLastTabIsRemoved {
    if ([_delegate respondsToSelector:@selector(shouldCloseWindowIfLastTabIsRemoved:)]) {
        return [_delegate shouldCloseWindowIfLastTabIsRemoved:_controller];
    }
    return YES;
}

- (void)informItemRemoved:(TMTTabItem *)item {
    if ([_delegate respondsToSelector:@selector(didRemoveTab:from:)]) {
        [_delegate didRemoveTab:item from:_controller];
    }
}

- (void)informItemChanged:(TMTTabItem *)item {
    if (!item) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(tabChanged:from:)]) {
        [_delegate tabChanged:item from:_controller];
    }
}

- (TMTTabItemStyle *)styleForItem:(TMTTabItem *)item {
    if ([_delegate respondsToSelector:@selector(tabItemStyle:from:)]) {
        return [_delegate tabItemStyle:item from:_controller];
    }
    return [TMTTabItemStyle new];
}

- (TMTTabBarStyle *)styleForBar {
    if ([_delegate respondsToSelector:@selector(tabBarStyle:)]) {
        return [_delegate tabBarStyle:_controller];
    }
    return [TMTTabBarStyle new];
}

-(TMTTabItem *)createTab {
    return [_delegate createTab:_controller];
}

@end