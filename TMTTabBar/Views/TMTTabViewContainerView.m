//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabViewContainerView.h"
#import "TMTTabContainerDelegate.h"
#import "TMTTabBar.h"
#import "TMTTabDraggingDelegate.h"


@implementation TMTTabViewContainerView {

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self initMember];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self initMember];
    }
    return self;
}

- (void)initMember {
    self.boxType = NSBoxCustom;
    self.borderType = NSNoBorder;
    [self registerForDraggedTypes:@[TMTTabItemDragType]];
}

- (void)performClose:(id)sender {
    [self.parent closeActiveTab];
}

- (void)performCloseAll:(id)sender {
    [self.parent closeAllTabs];
}

- (void)performCloseAllButActive:(id)sender {
    [self.parent closeAllButActive];

}

- (void)performAddNewTab:(id)sender {
    [self.parent createTab];
}


#pragma  mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationMove;
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return [self.parent performDrop:sender onView:self];
}

- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)sender {
    [self.parent updateDraggingItemsForDrag:sender forView:self];
}
@end