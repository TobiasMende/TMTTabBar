//
// Created by Tobias Mende on 01.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabAreaView.h"
#import "NSView+TMTCoordinateHelpers.h"


@implementation TMTTabAreaView {
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerForDraggedTypes:@[TMTTabItemDragType]];
        self.spacing = 0;
        self.distribution = NSStackViewDistributionFillEqually;
    }
    return self;
}

- (void)viewDidMoveToSuperview {
    NSLayoutPriority horizontalPrio = [(NSStackView *) self.superview huggingPriorityForOrientation:NSLayoutConstraintOrientationHorizontal];
    NSLayoutPriority verticalPrio = [(NSStackView *) self.superview huggingPriorityForOrientation:NSLayoutConstraintOrientationVertical];
    [self setHuggingPriority:horizontalPrio - 10 forOrientation:NSLayoutConstraintOrientationHorizontal];
    [self setHuggingPriority:verticalPrio - 10 forOrientation:NSLayoutConstraintOrientationVertical];
}

- (void)addTabView:(TMTTabItemView *)tabView {
    [self addArrangedSubview:tabView];
}

- (void)addTabView:(TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation {
    NSUInteger index = [self dropPositionFor:windowLocation];

    if (index < self.subviews.count) {
        [self insertView:tabView atIndex:index inGravity:NSStackViewGravityCenter];
    } else {
        [self addTabView:tabView];
    }
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    [self removeView:tabView];
}


#pragma  mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationMove;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    NSPoint position = sender.draggingLocation;
    NSUInteger insertionIndex = [self dropPositionFor:position];
    // TODO
    return NSDragOperationMove;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    // TODO
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return [self.parent performDrop:sender];
}

- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)sender {
    [sender enumerateDraggingItemsWithOptions:0 forView:self classes:@[[NSImage class], [NSPasteboardItem class]] searchOptions:@{} usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
        if (![[draggingItem.item types] containsObject:TMTTabItemDragType]) {
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
    size.width /= (CGFloat) (self.subviews.count + 1);
    return size;
}


@end