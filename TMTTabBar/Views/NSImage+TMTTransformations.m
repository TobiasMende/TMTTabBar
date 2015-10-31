//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "NSImage+TMTTransformations.h"


@implementation NSImage (TMTTransformations)

- (void) flip {
    [self flipImageVertically];
}

- (void)flipImageVertically {
    NSAffineTransform *transformation = [NSAffineTransform transform];
    NSSize dimensions = self.size;
    [self lockFocus];

    [transformation scaleXBy:1.0 yBy:-1.0];
    [transformation set];

    [self drawAtPoint:NSMakePoint(0,-dimensions.height)
             fromRect:NSMakeRect(0,0, dimensions.width, dimensions.height)
            operation:NSCompositeCopy fraction:1.0];

    [self unlockFocus];
}

- (void)flipImageHorizontally {
    NSAffineTransform *transformation = [NSAffineTransform transform];
    NSSize dimensions = self.size;
    [self lockFocus];

    [transformation scaleXBy:-1.0 yBy:1.0];
    [transformation set];

    [self drawAtPoint:NSMakePoint(-dimensions.height,0)
             fromRect:NSMakeRect(0,0, dimensions.width, dimensions.height)
            operation:NSCompositeCopy fraction:1.0];

    [self unlockFocus];
}
@end