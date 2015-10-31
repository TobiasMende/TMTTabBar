//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//


#import "TMTTabBarView.h"
#import "TMTTabViewController.h"
#import "TMTTabItemStack.h"
#import "TMTTabItemView.h"
#import "TMTTabItem.h"
#import "TMTTabViewDelegate.h"
#import "TMTTabItemStyle.h"
#import "TMTTabBarStyle.h"
#import "TMTTabViewContainerView.h"

@interface TMTTabViewController ()
- (void)addTabItem:(TMTTabItem *)item atPoint:(NSPoint)point;

- (TMTTabItemView *)insertTabForItem:(TMTTabItem *)item;
@end

@implementation TMTTabViewController {
    TMTTabBarView *_tabBar;
    TMTTabViewContainerView *_tabContainer;
    NSMutableDictionary<TMTTabItem *, TMTTabItemView *> *_tabs;
    TMTTabItemStack<TMTTabItem *> *_tabOrder;
}

- (instancetype)initWithTabBar:(TMTTabBarView *)tabBar container:(TMTTabViewContainerView *)container andDelegate:(id <TMTTabViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _tabBar = tabBar;
        _tabBar.parent = self;
        _tabBar.style = [self styleForBar];
        _tabContainer = container;
        _tabContainer.parent = self;
        _tabs = [NSMutableDictionary new];
        _tabOrder = [TMTTabItemStack new];
    }
    return self;
}

- (void)addTabItem:(TMTTabItem *_Nonnull)item {
    TMTTabItemView *tab = [self insertTabForItem:item];
    [_tabBar addTabView:tab];
    [self activateItem:item];
}

- (void)addTabItem:(TMTTabItem *)item atPoint:(NSPoint)point {
    TMTTabItemView *tab = [self insertTabForItem:item];
    [_tabBar addTabView:tab atPoint:point];
    [self activateItem:item];
}

- (TMTTabItemView *)insertTabForItem:(TMTTabItem *)item {
    [_tabOrder push:item];
    TMTTabItemStyle *tabStyle = [self styleForItem:item];
    TMTTabItemView *tab = [[TMTTabItemView alloc] initWithItem:item andStyle:tabStyle];
    tab.parent = self;
    _tabs[item] = tab;
    return tab;
}

- (BOOL)removeTabItem:(TMTTabItem *_Nonnull)item {
    if (![self shouldRemoveItem:item]) {
        return NO;
    }

    [_tabOrder remove:item];
    TMTTabItemView *tab = _tabs[item];
    tab.parent = nil;
    [_tabs removeObjectForKey:item];
    [_tabBar removeTabView:tab];
    [self informItemRemoved:item];

    TMTTabItem *activeItem = _tabOrder.peek;
    [self activateItem:activeItem];
    return YES;
}

- (void)activateItem:(TMTTabItem *)item {
    [_tabContainer setContentView:item.view];
    [_tabBar activateTabItem:_tabs[item]];
    [self informItemChanged:item];
}


#pragma mark - TMTTabItemDelegate

- (void)selectTab:(TMTTabItem *_Nonnull)actionedItem {
    [_tabOrder push:actionedItem];
    [self activateItem:actionedItem];
}

- (void)closeTab:(TMTTabItem *_Nonnull)item {
    if (![self removeTabItem:item]) {
        NSBeep();
    }
}

- (void)draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation forItem:(TMTTabItem *)item {
    NSLog(@"ended with operation %li", operation);
}

#pragma mark - TMTTabBarDelegate

- (void)createTab {
    if (!_tabBar.style.shouldShowAddButton) {
        NSBeep();
        return;
    }
    TMTTabItem *item = [self.delegate createTab:self];
    [self addTabItem:item];
}

- (bool)performDrop:(id <NSDraggingInfo>)sender {
    TMTTabItemView *itemView = sender.draggingSource;
    TMTTabItem *item = itemView.item;
    NSPoint windowLocation = sender.draggingLocation;
    if(itemView.parent == self) {
        [_tabBar removeTabView:itemView];
        [_tabBar addTabView:itemView atPoint:windowLocation];
        return YES;
    }
    if([itemView.parent removeTabItem:item]) {
        [self addTabItem:item atPoint:windowLocation];
        return YES;
    }

    return NO;
}

#pragma mark - TMTTabContainerDelegate

- (void)closeActiveTab {
    TMTTabItem *item = _tabOrder.peek;
    [self closeTab:item];
}

- (void)closeAllTabs {
    for (TMTTabItem *item in _tabs.allKeys) {
        [self removeTabItem:item];
    }
}

- (void)closeAllButActive {
    for (TMTTabItem *item in _tabs.allKeys) {
        if (item != _tabOrder.peek) {
            [self removeTabItem:item];
        }
    }
}

#pragma mark - TMTTabViewDelegate comfort methods

- (BOOL)shouldRemoveItem:(TMTTabItem *)item {
    return ![self.delegate respondsToSelector:@selector(shouldRemoveTab:from:)] || [self.delegate shouldRemoveTab:item from:self];
}

- (void)informItemRemoved:(TMTTabItem *)item {
    if ([self.delegate respondsToSelector:@selector(didRemoveTab:from:)]) {
        [self.delegate didRemoveTab:item from:self];
    }
}

- (void)informItemChanged:(TMTTabItem *)item {
    if (!item) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(tabChanged:from:)]) {
        [self.delegate tabChanged:item from:self];
    }
}

- (TMTTabItemStyle *)styleForItem:(TMTTabItem *)item {
    if ([self.delegate respondsToSelector:@selector(tabItemStyle:from:)]) {
        return [self.delegate tabItemStyle:item from:self];
    }
    return [TMTTabItemStyle new];
}


- (TMTTabBarStyle *)styleForBar {
    if ([self.delegate respondsToSelector:@selector(tabBarStyle:)]) {
        return [self.delegate tabBarStyle:self];
    }
    return [TMTTabBarStyle new];
}



@end