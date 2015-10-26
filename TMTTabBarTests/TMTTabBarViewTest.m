//
//  TMTTabBarViewTest.m
//  TMTTabBar
//
//  Created by Tobias Mende on 26.10.15.
//  Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <XCTest/XCTest.h>

#include <TMTTabBar/TMTTabBarView.h>
#include "TMTTabItemView.h"

@interface TMTTabBarViewTest : XCTestCase

@end

@implementation TMTTabBarViewTest {
    TMTTabBarView *tabBar1;
    TMTTabBarView *tabBar2;
    TMTTabItemView *item1;
    TMTTabItemView *item2;
}

- (void)setUp {
    [super setUp];

    tabBar1 = [[TMTTabBarView alloc] initWithFrame:NSMakeRect(0, 0, 100, 10)];
    tabBar2 = [[TMTTabBarView alloc] initWithFrame:NSMakeRect(200, 200, 100, 10)];
    item1 = [TMTTabItemView new];
    item2 = [TMTTabItemView new];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialSubviewCountIsZero {
    XCTAssertEqual(tabBar1.subviews.count, 0);
}

- (void)testThatAddingTabsIncreasesSubviewCount {
    [tabBar1 addTabView:item1];

    XCTAssertEqual(tabBar1.subviews.count, 1);
}

- (void)testRemovingItemDecreasesSubviewCount {
    [tabBar1 addTabView:item1];
    [tabBar1 removeTabView:item1];

    XCTAssertEqual(tabBar1.subviews.count, 0);
}

- (void)testAddingItemAffectsItemSize {
    [tabBar1 addTabView:item1];

    NSSize itemSize = item1.frame.size;
    NSSize wanted = NSMakeSize(100, 10);

    [self verifySize:itemSize equals:wanted];
}

- (void)testTwoAddedItemsHaveSameSize {
    [tabBar1 addTabView:item1];
    [tabBar1 addTabView:item2];

    NSSize wanted = NSMakeSize(50,10);

    [self verifySize:item1.frame.size equals:wanted];
    [self verifySize:item2.frame.size equals:wanted];
}

- (void)testClickingTabTrickersActiveState {
    [tabBar1 addTabView:item1];
    [tabBar1 addTabView:item2];

    [self clickOnTab:item1];
    XCTAssertTrue(item1.active);
    
    [self clickOnTab:item2];
    XCTAssertTrue(item2.active);
    XCTAssertFalse(item1.active);
    
}

- (void)testTabBarSetsAsParentWhenAddingTab {
    [tabBar1 addTabView:item1];
    XCTAssertEqualObjects(item1.parent, tabBar1);
}

- (void)testTabBarSetsParentToNilWhenRemovingTab {
    [tabBar1 addTabView:item1];
    [tabBar1 removeTabView:item1];
    XCTAssertNil(item1.parent);
}

- (void)testTabBarRemovesTabItemOnlyIfItIsParent {
    [self testTabBarSetsAsParentWhenAddingTab];
    [tabBar2 removeTabView:item1];
    XCTAssertEqualObjects(item1.parent, tabBar1);
}

- (void)verifySize:(NSSize)actual equals:(NSSize)wanted {
    XCTAssertEqual(actual.height, wanted.height);
    XCTAssertEqual(actual.width, wanted.width);
}

- (void)clickOnTab:(TMTTabItemView *)item {
    CGPoint location = item.bounds.origin;
    location.x += item.bounds.size.width/2.0;
    location.y += item.bounds.size.height/2.0;
    NSEvent *event = [NSEvent mouseEventWithType:NSLeftMouseDown location:location modifierFlags:0 timestamp:0 windowNumber:0 context:nil eventNumber:0 clickCount:1 pressure:0];
    [item mouseDown:event];
}

@end
