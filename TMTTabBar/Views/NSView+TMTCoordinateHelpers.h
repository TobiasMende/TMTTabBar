//
// Created by Tobias Mende on 08.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (TMTCoordinateHelpers)
- (NSPoint)center;

- (bool)contains:(NSPoint)windowLocation;
@end