//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTRenderingHints.h"
#import "TMTTabItemStyle.h"


@implementation TMTTabItemStyle {

}
- (id)init {
    self = [super init];
    if(self) {
        _inactiveBackgroundColor = [NSColor headerColor];
        _activeBackgroundColor = [NSColor gridColor];

        _inactiveBorderColor = [NSColor controlDarkShadowColor];
        _activeBorderColor = [NSColor gridColor];

        _inactiveTextColor = [NSColor controlTextColor];
        _activeTextColor = [NSColor controlTextColor];
        _rightMargin = 1;
        _leftMargin = 4;
        _dragItemMaxWidth = 150;
    }
    return self;
}

- (void)styleBackgroundForRect:(NSRect)rect withRenderingHints:(TMTRenderingHints* _Nonnull) renderingHints {
    NSColor* color = renderingHints.active || renderingHints.highlight ? self.activeBackgroundColor : self.inactiveBackgroundColor;
    [color setFill];
    NSRectFill(rect);
}

- (void)styleBordersForRect:(NSRect)rect withRenderingHinter:(TMTRenderingHints * _Nonnull) renderingHint {
    NSColor* color = renderingHint.active ? self.activeBorderColor : self.inactiveBorderColor;
    [color setStroke];
    CGPoint upperLeft = rect.origin;
    CGPoint upperRight = CGPointMake(upperLeft.x + rect.size.width, upperLeft.y);
    CGPoint lower = CGPointMake(upperRight.x, upperRight.y + rect.size.height);
    [NSBezierPath strokeLineFromPoint:upperRight toPoint:lower];
}

- (void)styleTitle:(NSTextField *_Nonnull)titleField withRenderingHints:(TMTRenderingHints* _Nonnull) renderingHints {
    titleField.textColor = renderingHints.active ? self.activeTextColor : self.inactiveTextColor;
}

@end