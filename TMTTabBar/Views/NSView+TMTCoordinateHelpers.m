//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSView+TMTCoordinateHelpers.h"


@implementation NSView (TMTCoordinateHelpers)
- (bool)contains:(NSPoint)windowLocation {
    NSPoint location = [self convertPoint:windowLocation fromView:nil];
    return NSPointInRect(location, self.bounds);
}

- (NSView *)viewForPoint:(NSPoint)windowLocation {
    for(NSView *view in self.subviews) {
        if ([view contains:windowLocation]) {
            return view;
        }
    }
    return nil;
}

- (NSPoint)center {
    NSPoint origin = self.bounds.origin;
    NSSize size = self.bounds.size;
    CGFloat x = (origin.x + size.width)/2;
    CGFloat y = (origin.y + size.height)/2;
    return NSMakePoint(x, y);
}


@end