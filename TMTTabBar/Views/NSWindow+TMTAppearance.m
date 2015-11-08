//
// Created by Tobias Mende on 08.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSWindow+TMTAppearance.h"


@implementation NSWindow (TMTAppearance)
- (void)appearAtPosition:(NSPoint)screenPoint {
    NSRect finalFrame = [self calculateFrameWithCenter:screenPoint];
    [self setInitialFrame:screenPoint];
    [self setFinalFrame:finalFrame];
}

- (NSRect)calculateFrameWithCenter:(NSPoint)point {
    NSSize size = self.frame.size;
    NSPoint location = NSZeroPoint;
    location.x = point.x - size.width/2;
    location.y = point.y - size.height/2;
    return NSMakeRect(location.x, location.y, size.width, size.height);
}

- (void)setInitialFrame:(NSPoint)screenPoint {
    NSRect initial = NSMakeRect(screenPoint.x, screenPoint.y, 0, 0);
    [self setFrame:initial display:NO];
}

- (void)setFinalFrame:(NSRect)frame {
    [self setFrame:frame display:YES animate:NO];
}

@end