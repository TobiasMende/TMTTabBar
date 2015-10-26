//
//  TMTTabItemView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabItemView.h"
#import "TMTTabItemStyle.h"
#import "TMTTabItemDelegate.h"

@interface TMTTabItemView ()
- (void)initMember;

- (void)drawBorders;

- (void)drawBackground;

- (void)drawLabel;
@end

@implementation TMTTabItemView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initMember];
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    [self initMember];
    return self;
}

- (instancetype)init {
    self = [super init];
    [self initMember];
    return self;
}

- (void)initMember {
    _style = [TMTTabItemStyle new];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [self drawBackground];
    [self drawBorders];
    [self drawLabel];
}

- (void)drawBorders {
    if (self.active) {
        [self.style.activeBorderColor setStroke];
    } else {
        [self.style.inactiveBorderColor setStroke];
    }

    CGPoint upperLeft = self.bounds.origin;
    CGPoint upperRight = CGPointMake(upperLeft.x + self.bounds.size.width, upperLeft.y);
    [self drawVerticalBorderForUpper:upperRight];
}

- (void)drawVerticalBorderForUpper:(CGPoint)upper {
    CGPoint lower = CGPointMake(upper.x, upper.y + self.bounds.size.height);
    [NSBezierPath strokeLineFromPoint:upper toPoint:lower];
}

- (void)drawBackground {
    if (self.active) {
        [self.style.activeBackgroundColor setFill];
    } else {
        [self.style.inactiveBackgroundColor setFill];
    }
    NSRectFill(self.bounds);
}

- (void)drawLabel {
    NSColor *textColor = self.active ? self.style.activeTextColor : self.style.inactiveTextColor;
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor};
    [self.label drawInRect:self.bounds withAttributes:attributes];
}

- (void)setActive:(BOOL)active {
    _active = active;
    self.needsDisplay = YES;
}

#pragma mark - Mouse Actions

- (void)mouseDown:(NSEvent *)theEvent {
    [self.parent clickedOnTab:self];
}

@end
