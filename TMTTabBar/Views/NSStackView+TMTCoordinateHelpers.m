//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSStackView+TMTCoordinateHelpers.h"
#import "NSView+TMTCoordinateHelpers.h"


@implementation NSStackView (TMTCoordinateHelpers)

- (NSView *)subviewAtLocation:(NSPoint)windowLocation {
    for(NSView *view in self.arrangedSubviews) {
        if ([view contains:windowLocation]) {
            return view;
        }
    }
    return nil;
}

- (NSView *)subviewBeforeLocationX:(NSPoint)windowLocation {
    NSView *found = nil;
    NSPoint location = [self convertPoint:windowLocation fromView:nil];
    for(NSView *view in self.arrangedSubviews) {
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
    for(NSUInteger i = 0; i < self.arrangedSubviews.count; ++i) {
        NSView* current = self.arrangedSubviews[i];
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
        NSUInteger index = [self.arrangedSubviews indexOfObject:view] + 1;
        return index;
    } else {
        return 0;
    }
}

@end