//
//  TMTTabViewControllerTest.m
//  TMTTabBar
//
//  Created by Tobias Mende on 30.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabViewController.h"
#import "TMTTabBarView.h"
#import "TMTTabItemView.h"
#import "TMTTabItem.h"
#import "TMTTabViewDelegate.h"

@interface TMTTabViewControllerTest : XCTestCase

@end

@implementation TMTTabViewControllerTest {
    TMTTabViewController *controller;
    id delegate;
    id tabBar;
    id tabContainer;
    TMTTabItem *item;
    TMTTabItem *item2;
}

- (void)setUp {
    [super setUp];
    tabBar = [OCMockObject niceMockForClass:[TMTTabBarView class]];
    tabContainer = [OCMockObject niceMockForClass:[NSBox class]];
    delegate = [OCMockObject niceMockForProtocol:@protocol(TMTTabViewDelegate)];
    controller = [[TMTTabViewController alloc] initWithTabBar:tabBar container:tabContainer andDelegate:delegate];

    item = [TMTTabItem new];
    item.view = [NSView new];
    item.label = @"Label";
    item2 = [TMTTabItem new];
    item2.view = [NSView new];
    item2.label = @"Label 2";
    
}

- (void)testAddingItemUpdatesTabBar{
    [[tabBar expect] addTabView:[OCMArg checkWithBlock:^BOOL(id obj) {
        if(![obj isKindOfClass:[TMTTabItemView class]]) {
            return NO;
        }
        TMTTabItemView *view = (TMTTabItemView*)obj;
        bool isValid = true;
        isValid &= view.parent == controller;
        isValid &= view.item == item;
        return isValid;
    }]];

    
    [controller addTabItem:item];
    
    [tabBar verify];
}

- (void)testAddingItemUpdatesTabContainer {
    [[tabContainer expect] setContentView:item.view];

    [controller addTabItem:item];

    [tabContainer verify];
}

- (void)testAddingItemInformsDelegateAboutTabChange {
    [[delegate expect] tabChanged:item from:controller];

    [controller addTabItem:item];

    [delegate verify];
}

- (void)testRemovingItemUpdatesTabBar {
    [controller addTabItem:item];
    [controller addTabItem:item2];
    [[[delegate stub] andReturnValue:@YES]shouldRemoveTab:item2 from:controller];

    [[tabBar expect] removeTabView:[OCMArg checkWithBlock:^BOOL(id obj) {
        if(![obj isKindOfClass:[TMTTabItemView class]]) {
            return NO;
        }
        TMTTabItemView *view = (TMTTabItemView*)obj;
        bool isValid = true;
        isValid &= view.parent == nil;
        isValid &= view.item == item2;
        return isValid;
    }]];

    [controller removeTabItem:item2];
    
    [tabBar verify];
}

- (void)testRemovingItemUpdatesTabContainer {
    [controller addTabItem:item];
    [controller addTabItem:item2];
    [[[delegate stub] andReturnValue:@YES]shouldRemoveTab:item2 from:controller];

    [[tabContainer expect] setContentView:item.view];

    [controller removeTabItem:item2];

    [tabContainer verify];
}

- (void)testRemovingItemAsksForPermission {
    [controller addTabItem:item];
    [controller addTabItem:item2];

    [[delegate expect] shouldRemoveTab:item2 from:controller];

    [controller removeTabItem:item2];

    [delegate verify];
}

- (void)testRemovingItemInformesAboutRemoval {
    [controller addTabItem:item];
    [controller addTabItem:item2];
    [[[delegate stub] andReturnValue:@YES]shouldRemoveTab:item2 from:controller];

    [[delegate expect] didRemoveTab:item2 from:controller];

    [controller removeTabItem:item2];

    [delegate verify];
}

- (void)testRemovingItemInformesAboutTabChangedIfTabLeft {
    [controller addTabItem:item];
    [controller addTabItem:item2];
    [[[delegate stub] andReturnValue:@YES]shouldRemoveTab:item2 from:controller];

    [[delegate expect] tabChanged:item from:controller];

    [controller removeTabItem:item2];

    [delegate verify];
}

- (void)testRemovingItemDoesNotInformAboutTabChangeIfNoItemsLeft {
    [controller addTabItem:item2];
    [[[delegate stub] andReturnValue:@YES]shouldRemoveTab:item2 from:controller];

    [[delegate reject] tabChanged:[OCMArg any] from:[OCMArg any]];

    [controller removeTabItem:item2];

    [delegate verify];
}


@end