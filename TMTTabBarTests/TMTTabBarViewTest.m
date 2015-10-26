//
//  TMTTabBarViewTest.m
//  TMTTabBar
//
//  Created by Tobias Mende on 26.10.15.
//  Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <XCTest/XCTest.h>

#include "TMTTabBarView.h"
#include "TMTTabView.h"

@interface TMTTabBarViewTest : XCTestCase

@end

@implementation TMTTabBarViewTest {
    TMTTabBarView *tabBar;
    TMTTabView *item1;
    TMTTabView *item2;
}

- (void)setUp {
    [super setUp];
    
    tabBar = [[TMTTabBarView alloc] initWithFrame:NSMakeRect(0, 0, 100, 10)];
    item1 = [TMTTabView new];
    item2 = [TMTTabView new];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialSubviewCountIsZero {
    XCTAssertEqual(tabBar.subviews.count, 0);
}

- (void)testThatAddingTabsIncreasesSubviewCount {
    [tabBar addTabView:item1];

    XCTAssertEqual(tabBar.subviews.count, 1);
}

- (void)testRemovingItemDecreasesSubviewCount {
    [tabBar addTabView:item1];
    [tabBar removeTabView:item1];

    XCTAssertEqual(tabBar.subviews.count, 0);
}

- (void)testAddingItemAffectsItemSize {
    [tabBar addTabView:item1];

    NSSize itemSize = item1.frame.size;
    NSSize wanted = NSMakeSize(100, 10);

    [self verifySize:itemSize equals:wanted];
}

- (void)testTwoAddedItemsHaveSameSize {
    [tabBar addTabView:item1];
    [tabBar addTabView:item2];

    NSSize wanted = NSMakeSize(50,10);

    [self verifySize:item1.frame.size equals:wanted];
    [self verifySize:item2.frame.size equals:wanted];
}

- (void)verifySize:(NSSize)actual equals:(NSSize)wanted {
    XCTAssertEqual(actual.height, wanted.height);
    XCTAssertEqual(actual.width, wanted.width);
}

@end
