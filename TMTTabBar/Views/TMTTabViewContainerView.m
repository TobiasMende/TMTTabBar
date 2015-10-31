//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabViewContainerView.h"


@implementation TMTTabViewContainerView {

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self initMember];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self initMember];
    }
    return self;
}

- (void)initMember {
    self.boxType = NSBoxCustom;
    self.borderType = NSNoBorder;
}
@end