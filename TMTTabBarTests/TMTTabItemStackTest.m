//
//  TMTTabItemStackTest.m
//  TMTTabBar
//
//  Created by Tobias Mende on 26.10.15.
//  Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TMTTabItemStack.h"
#import "TMTTabItem.h"

@interface TMTTabItemStackTest : XCTestCase


@end



@implementation TMTTabItemStackTest {
    TMTTabItemStack<TMTTabItem *> *stack;

    TMTTabItem *item1;
    TMTTabItem *item2;
    TMTTabItem *item3;
}

- (void)setUp {
    [super setUp];

    stack = [TMTTabItemStack new];
    item1 = [TMTTabItem new];
    item2 = [TMTTabItem new];
    item3 = [TMTTabItem new];
}

- (void)testNewStackIsEmpty {
    XCTAssertTrue(stack.isEmpty);
}

- (void)testStackWithAddedItemIsNotEmpty {
    [stack push:item1];
    XCTAssertFalse(stack.isEmpty);
}

- (void)testPushOfContainedItemDoesNotChangeStackSize {
    [self testStackCountIsOneIfOneItemAdded];
    [self testStackCountIsOneIfOneItemAdded];
}

- (void)testPushOfContainedItemMovesItemToTop {
    [stack push:item1];
    [stack push:item2];
    [stack push:item3];
    XCTAssertEqualObjects(stack.peek, item3);

    [stack push:item1];
    XCTAssertEqualObjects(stack.peek, item1);
}

- (void)testStackCountIsOneIfOneItemAdded {
    [stack push:item1];
    XCTAssertEqual(stack.size, 1);
}

- (void)testPopEmptyStackReturnsNil {
    XCTAssertNil(stack.pop);
}

- (void)testPopNonEmptyStackReturnsAddedItem {
    [stack push:item1];
    XCTAssertEqualObjects(stack.pop, item1);
}

- (void)testPopNonEmptyStackDecreasesSize {
    [self testPopNonEmptyStackReturnsAddedItem];
    XCTAssertEqual(stack.size, 0);
}

- (void)testPopReturnsElementsInReversedPushOrder {
    [stack push:item1];
    [stack push:item2];
    [stack push:item3];

    XCTAssertEqualObjects(stack.pop, item3);
    XCTAssertEqualObjects(stack.pop, item2);
    XCTAssertEqualObjects(stack.pop, item1);
}

- (void)testPeekEmptyStackReturnsNil {
    XCTAssertNil(stack.peek);
}

- (void)testPeekReturnsPreviouslyPushedItem {
    [stack push:item1];
    XCTAssertEqualObjects(stack.peek, item1);
}

- (void)testPeekDoesNotRemoveItem {
    [stack push:item1];
    [stack push:item2];

    XCTAssertEqualObjects(stack.peek, item2);
    XCTAssertEqual(stack.size, 2);
}

@end
