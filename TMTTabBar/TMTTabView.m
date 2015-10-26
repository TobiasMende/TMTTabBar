//
//  TMTTabView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabView.h"

@interface TMTTabView ()
- (void)drawBorders;

- (void)drawBackground;

- (void)drawLabel;
@end

@implementation TMTTabView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [self drawBackground];
    [self drawBorders];
    [self drawLabel];
}

- (void)drawBorders {
    [[NSColor controlShadowColor] setStroke];

    CGPoint upperLeft = self.bounds.origin;
    CGPoint upperRight = CGPointMake(upperLeft.x + self.bounds.size.width, upperLeft.y);
    [self drawVerticalBorderForUpper:upperRight];
}

- (void)drawVerticalBorderForUpper:(CGPoint)upper {
    CGPoint lower = CGPointMake(upper.x, upper.y  + self.bounds.size.height);
    [NSBezierPath strokeLineFromPoint:upper toPoint:lower];
}

- (void)drawBackground {
    [[NSColor controlBackgroundColor] setFill];
    NSRectFill(self.bounds);
}

- (void)drawLabel {
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [NSColor secondaryLabelColor]};
    [self.label drawInRect:self.bounds withAttributes:attributes];
}

@end
