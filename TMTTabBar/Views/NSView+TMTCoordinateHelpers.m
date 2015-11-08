//
// Created by Tobias Mende on 08.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSView+TMTCoordinateHelpers.h"


@implementation NSView (TMTCoordinateHelpers)

- (NSPoint)center {
    NSPoint origin = self.bounds.origin;
    NSSize size = self.bounds.size;
    CGFloat x = (origin.x + size.width)/2;
    CGFloat y = (origin.y + size.height)/2;
    return NSMakePoint(x, y);
}

- (bool)contains:(NSPoint)windowLocation {
    NSPoint location = [self convertPoint:windowLocation fromView:nil];
    return NSPointInRect(location, self.bounds);
}
@end