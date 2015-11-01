//
// Created by Tobias Mende on 01.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TMTTabDraggingDelegate <NSObject>
- (bool)performDrop:(id<NSDraggingInfo>)info onView:(id)sender;
- (void)updateDraggingItemsForDrag:(id <NSDraggingInfo>)info forView:(id)sender;
@end