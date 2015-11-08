//
// Created by Tobias Mende on 01.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabAreaView.h"
#import "NSStackView+TMTCoordinateHelpers.h"


@implementation TMTTabAreaView {
}

static const CGFloat DEFAULT_SPACING = -0.5;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerForDraggedTypes:@[TMTTabItemDragType]];
        self.spacing = DEFAULT_SPACING;
        self.distribution = NSStackViewDistributionFillEqually;
        self.wantsLayer = YES;
        self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    }
    return self;
}

- (void)viewDidMoveToSuperview {
    NSLayoutPriority verticalPrio = [(NSStackView *) self.superview huggingPriorityForOrientation:NSLayoutConstraintOrientationVertical];
    [self setHuggingPriority:verticalPrio - 10 forOrientation:NSLayoutConstraintOrientationVertical];
}

- (void)addTabView:(TMTTabItemView *)tabView {
    [self addArrangedSubview:tabView];
}

- (void)addTabView:(TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation {
    NSUInteger index = [self dropPositionFor:windowLocation];

    if (index < self.arrangedSubviews.count) {
        [self insertArrangedSubview:tabView atIndex:index];
    } else {
        [self addTabView:tabView];
    }
    self.needsDisplay = YES;
    self.needsLayout = YES;
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    [tabView removeFromSuperview];
    self.needsDisplay = YES;
    self.needsLayout = YES;
}


#pragma  mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationMove;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    NSPoint position = sender.draggingLocation;
    NSUInteger insertionIndex = [self dropPositionFor:position];
    [self updateDropSpace:insertionIndex];
    return NSDragOperationMove;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    [self updateDropSpace:NSNotFound];
}

- (void)updateDropSpace:(NSUInteger)dropPosition {
    if (self.arrangedSubviews.count == 0) {
        return;
    }
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.25;
        for (NSUInteger i = 0; i < self.arrangedSubviews.count-1; ++i) {
            CGFloat spacing = (i + 1 == dropPosition) ? self.sizeForDraggingItem.width : DEFAULT_SPACING;
            if ([self customSpacingAfterView:self.arrangedSubviews[i]] != spacing) {
                [self.animator setCustomSpacing:spacing afterView:self.arrangedSubviews[i]];
            }
        }

        CGFloat left = (dropPosition == 0) ? self.sizeForDraggingItem.width : 0;
        CGFloat right = (dropPosition == self.arrangedSubviews.count) ? self.sizeForDraggingItem.width : 0;

        if (self.edgeInsets.left != left || self.edgeInsets.right != right) {
            NSEdgeInsets p = self.edgeInsets;
            self.animator.edgeInsets = NSEdgeInsetsMake(p.top, left, p.bottom, right);
        }

    }                   completionHandler:^{
        self.needsLayout = YES;
    }];

}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    [self updateDropSpace:NSNotFound];
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return [self.parent performDrop:sender onView:self];
}

- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)sender {
    [self.parent updateDraggingItemsForDrag:sender forView:self];
}

- (NSRect)boundsForDraggingItem {
    NSSize size = [self sizeForDraggingItem];
    return NSMakeRect(0, 0, size.width, size.height);
}

- (NSSize)sizeForDraggingItem {
    NSSize size = self.bounds.size;
    size.width /= (CGFloat) (self.arrangedSubviews.count + 1);
    return size;
}


@end