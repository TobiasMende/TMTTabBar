//
// Created by Tobias Mende on 01.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabAreaView.h"
#import "TMTTabItemView.h"
#import "TMTTabBarLayoutManager.h"
#import "NSView+TMTCoordinateHelpers.h"
#import "TMTTabViewController.h"


@implementation TMTTabAreaView {

    TMTTabBarLayoutManager *_layoutManager;

}
- (instancetype)init {
    self = [super init];
    if (self) {
        _layoutManager = [[TMTTabBarLayoutManager alloc] initForView:self];
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
        [self registerForDraggedTypes:@[TMTTabItemDragType]];
    }
    return self;
}

- (void)addTabView:(TMTTabItemView *)tabView {
    [self addSubview:tabView];
    [_layoutManager updateLayout];
}

- (void)addTabView:(TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation {
    NSUInteger index = [self dropPositionFor:windowLocation];

    if (index < self.subviews.count) {
        NSView *viewForLocation = self.subviews[index];
        [self insertTabView:tabView relativeTo:viewForLocation atLocation:windowLocation];
    } else {
        [self addTabView:tabView];
    }
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    [tabView removeFromSuperview];
    [_layoutManager updateLayout];
}


- (void)insertTabView:(TMTTabItemView *)tabView relativeTo:(NSView *)viewForLocation atLocation:(NSPoint)windowLocation {
    NSPoint locationInView = [viewForLocation convertPoint:windowLocation fromView:nil];


    if (locationInView.x < viewForLocation.center.x) {
        [self addSubview:tabView positioned:NSWindowBelow relativeTo:viewForLocation];
    } else {
        [self addSubview:tabView positioned:NSWindowAbove relativeTo:viewForLocation];
    }

    [_layoutManager updateLayout];
}


#pragma  mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSSize imageSize = sender.draggedImage.size;


    return NSDragOperationMove;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    NSPoint position = sender.draggingLocation;
    NSUInteger insertionIndex = [self dropPositionFor:position];
    [_layoutManager updateLayoutWithDropSpaceAt:insertionIndex];
    return NSDragOperationMove;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    [_layoutManager updateLayout];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return [self.parent performDrop:sender];
}

- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)sender {
    [sender enumerateDraggingItemsWithOptions:nil forView:self classes:@[[NSImage class], [NSPasteboardItem class]] searchOptions:nil usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
        if(![[draggingItem.item types] containsObject:TMTTabItemDragType]) {
            *stop = YES;
        } else {
            [draggingItem setDraggingFrame:self.boundsForDraggingItem contents:[[draggingItem.imageComponents firstObject] contents]];
        }
    }];
}

- (NSRect)boundsForDraggingItem {
    NSSize size = [self sizeForDraggingItem];
    return NSMakeRect(0, 0, size.width, size.height);
}

- (NSSize)sizeForDraggingItem {
    NSSize size = self.bounds.size;
    size.width /= (CGFloat )(self.subviews.count + 1);
    return size;
}


@end