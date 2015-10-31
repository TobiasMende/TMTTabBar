//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (TMTTransformations)
- (void)flip;

- (void)flipImageVertically;

- (void)flipImageHorizontally;
@end