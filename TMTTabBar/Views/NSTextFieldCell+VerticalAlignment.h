//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextFieldCell (VerticalAlignment)
- (NSRect)titleRectForBounds:(NSRect)frame;

- (void)drawInteriorWithFrame:(NSRect)cFrame inView:(NSView *)cView;
@end