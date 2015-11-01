//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (TMTCoordinateHelpers)

- (bool)contains:(NSPoint)windowLocation;
- (nullable NSView*)subviewAtLocation:(NSPoint)windowLocation;
- (nullable NSView *)subviewBeforeLocationX:(NSPoint)windowLocation;

- (NSUInteger)dropPositionFor:(NSPoint)windowLocation;

- (NSPoint)center;
@end