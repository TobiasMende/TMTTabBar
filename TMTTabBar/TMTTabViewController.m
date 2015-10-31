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

@implementation TMTTabViewController {
    TMTTabBarView *_tabBar;
    NSBox *_tabContainer;
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
        _tabs = [NSMutableDictionary new];
        _tabOrder = [TMTTabItemStack new];
    }
    return self;
}

- (void)addTabItem:(TMTTabItem *_Nonnull)item {
    [_tabOrder push:item];
    TMTTabItemStyle *tabStyle = [self styleForItem:item];
    TMTTabItemView *tab = [[TMTTabItemView alloc] initWithItem:item andStyle:tabStyle];
    tab.parent = self;
    _tabs[item] = tab;
    [_tabBar addTabView:tab];
    [self activateItem:item];
}

- (void)removeTabItem:(TMTTabItem *_Nonnull)item {
    if (![self shouldRemoveItem:item]) {
        return;
    }

    [_tabOrder remove:item];
    TMTTabItemView *tab = _tabs[item];
    tab.parent = nil;
    [_tabs removeObjectForKey:item];
    [_tabBar removeTabView:tab];
    [self informItemRemoved:item];

    TMTTabItem *activeItem = _tabOrder.peek;
    [self activateItem:activeItem];
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
    [self removeTabItem:item];
}

#pragma mark - TMTTabBarDelegate

- (void)createTabItem {
    TMTTabItem *item = [self.delegate createTab:self];
    [self addTabItem:item];
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

- (TMTTabItemStyle *)styleForItem:(TMTTabItem*)item {
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