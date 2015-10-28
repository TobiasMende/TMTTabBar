//
// Created by Tobias Mende on 28.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTRenderingHints.h"


@implementation TMTRenderingHints {
    NSView *_view;
}
- (void)setActive:(BOOL)active {
    _active = active;
    _view.needsDisplay = YES;
}

- (void)setHighlight:(BOOL)highlight {
    _highlight = highlight;
    _view.needsDisplay = YES;
}

- (instancetype)initForView:(NSView *_Nonnull)view {
    self = [super init];
    if(self) {
        _view = view;
    }
    return self;
}

@end