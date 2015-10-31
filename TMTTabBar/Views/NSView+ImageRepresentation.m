//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSView+ImageRepresentation.h"
#import "NSImage+TMTTransformations.h"


@implementation NSView (ImageRepresentation)

- (NSImage *)imageRepresentation {
    BOOL wasHidden = self.isHidden;
    BOOL wantedLayer = self.wantsLayer;

    self.hidden = NO;
    self.wantsLayer = YES;

    NSImage *image = [[NSImage alloc] initWithSize:self.bounds.size];
    [image lockFocus];
    CGContextRef ctx = [NSGraphicsContext currentContext].graphicsPort;
    [self.layer renderInContext:ctx];
    [image unlockFocus];

    self.wantsLayer = wantedLayer;
    self.hidden = wasHidden;

    if ([self isFlipped]) {
        [image flip];
    }

    return image;
}

@end