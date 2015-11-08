//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//


#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabBarView.h"
#import "TMTTabViewController.h"
#import "TMTTabItemStack.h"
#import "TMTTabItemView.h"
#import "TMTTabItem.h"
#import "TMTTabViewDelegate.h"
#import "TMTTabItemStyle.h"
#import "TMTTabBarStyle.h"
#import "TMTTabViewContainerView.h"
#import "TMTTabWindowFactory.h"
#import "TMTTabViewDelegateProxy.h"

@interface TMTTabViewController ()
- (void)addTabItem:(TMTTabItem *)item atPoint:(NSPoint)point;

- (TMTTabItemView *)insertTabForItem:(TMTTabItem *)item;
@end

@implementation TMTTabViewController {
    TMTTabBarView *_tabBar;
    TMTTabViewContainerView *_tabContainer;
    NSMutableDictionary<TMTTabItem *, TMTTabItemView *> *_tabs;
    TMTTabItemStack<TMTTabItem *> *_tabOrder;
    TMTTabViewDelegateProxy *_delegate;
}

- (instancetype)initWithTabBar:(TMTTabBarView *)tabBar container:(TMTTabViewContainerView *)container andDelegate:(id <TMTTabViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = [[TMTTabViewDelegateProxy alloc] initWithController:self andDelegate:delegate];
        _tabBar = tabBar;
        _tabBar.parent = self;
        _tabBar.style = [_delegate styleForBar];
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
    TMTTabItemStyle *tabStyle = [_delegate styleForItem:item];
    TMTTabItemView *tab = [[TMTTabItemView alloc] initWithItem:item andStyle:tabStyle];
    tab.parent = self;
    _tabs[item] = tab;
    return tab;
}

- (BOOL)removeTabItem:(TMTTabItem *_Nonnull)item {
    if (![_delegate shouldRemoveItem:item]) {
        return NO;
    }

    [_tabOrder remove:item];
    TMTTabItemView *tab = _tabs[item];
    tab.parent = nil;
    [_tabs removeObjectForKey:item];
    [_tabBar removeTabView:tab];
    [_delegate informItemRemoved:item];

    TMTTabItem *activeItem = _tabOrder.peek;
    if(activeItem) {
        [self activateItem:activeItem];
    } else if(_delegate.shouldCloseWindowIfLastTabIsRemoved) {
        [_tabBar.window performClose:self];
    }
    return YES;
}

- (void)activateItem:(TMTTabItem *)item {
    [_tabContainer setContentView:item.view];
    [_tabBar activateTabItem:_tabs[item]];
    if([_delegate shouldBecomeFirstResponder:item]) {
        if([_tabContainer.window isKeyWindow]) {
            [_tabContainer.window makeFirstResponder:_tabContainer.contentView];
        }
    }
    [_delegate informItemChanged:item];
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
    if (operation == NSDragOperationNone && [_delegate shouldDragToNewWindow:item]) {
        [self removeTabItem:item];
        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
        TMTTabViewController *newController = [TMTTabWindowFactory createTabWindow:_delegate.delegate];
        [newController beginWithItem:item];
    }
}

- (void)beginWithItem:(TMTTabItem *)tabItem {
    [self addTabItem:tabItem];
    [_tabContainer.window makeKeyAndOrderFront:self];
    [self activateItem:tabItem];

}

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context forItem:(TMTTabItem *)item {
    session.animatesToStartingPositionsOnCancelOrFail = ![_delegate shouldDragToNewWindow:item];
    return NSDragOperationMove;
}

#pragma mark - TMTTabBarDelegate

- (void)createTab {
    if (!_tabBar.style.shouldShowAddButton) {
        NSBeep();
        return;
    }
    TMTTabItem *item = [_delegate createTab];
    [self addTabItem:item];
}

#pragma mark - TMTTabDraggingDelegate

- (bool)performDrop:(id <NSDraggingInfo>)info onView:(id)sender {
    TMTTabItemView *itemView = info.draggingSource;
    TMTTabItem *item = itemView.item;
    NSPoint windowLocation = info.draggingLocation;

    if (sender == _tabContainer) {
        if (itemView.parent == self) {
            return NO;
        }
        [self addTabItem:item];
        return YES;
    }

    if (itemView.parent == self) {
        [_tabBar addTabView:itemView atPoint:windowLocation];
        return YES;
    }
    if ([itemView.parent removeTabItem:item]) {
        [self addTabItem:item atPoint:windowLocation];
        return YES;
    }

    return NO;
}

- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)info forView:(id)sender {
    [info enumerateDraggingItemsWithOptions:0 forView:sender classes:@[[NSImage class], [NSPasteboardItem class]] searchOptions:@{} usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
        if (![[draggingItem.item types] containsObject:TMTTabItemDragType]) {
            *stop = YES;
        } else {
            if(sender == _tabContainer) {
                TMTTabItemView *itemView = info.draggingSource;
                TMTTabItem *item = itemView.item;
                if([_tabs.allKeys containsObject:item]) {
                    return;
                }
            }
            [draggingItem setDraggingFrame:_tabBar.boundsForDraggingItem contents:[[draggingItem.imageComponents firstObject] contents]];
        }
    }];
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

@end