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

- (NSView *)subviewAtLocation:(NSPoint)windowLocation {
    for(NSView *view in self.subviews) {
        if ([view contains:windowLocation]) {
            return view;
        }
    }
    return nil;
}

- (NSView *)subviewBeforeLocationX:(NSPoint)windowLocation {
    NSView *found = nil;
    NSPoint location = [self convertPoint:windowLocation fromView:nil];
    for(NSView *view in self.subviews) {
        CGFloat maxX = NSMaxX(view.frame);
        if(maxX < location.x) {
            found = view;
        } else {
            break;
        }
    }
    return found;
}

- (NSUInteger)dropPositionFor:(NSPoint)windowLocation {
    for(NSUInteger i = 0; i < self.subviews.count; ++i) {
        NSView* current = self.subviews[i];
        if([current contains:windowLocation]) {
            NSPoint viewLocation = [current convertPoint:windowLocation fromView:nil];
            if(current.center.x >= viewLocation.x) {
                return i;
            } else {
                return i + 1;
            }
        }
    }

    NSView *view = [self subviewBeforeLocationX:windowLocation];
    if(view) {
        NSUInteger index = [self.subviews indexOfObject:view] + 1;
        return index;
    } else {
        return 0;
    }
}

- (NSPoint)center {
    NSPoint origin = self.bounds.origin;
    NSSize size = self.bounds.size;
    CGFloat x = (origin.x + size.width)/2;
    CGFloat y = (origin.y + size.height)/2;
    return NSMakePoint(x, y);
}


@end