//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabTitleView.h"
#include "NSTextFieldCell+VerticalAlignment.h"

@implementation TMTTabTitleView {

}


- (instancetype)init {
    self = [super init];
    [self initMember];
    return self;
}

- (void)initMember {
    self.alignment = NSCenterTextAlignment;
    self.bezeled = NO;
    self.drawsBackground = NO;
    self.editable = NO;
    self.selectable = NO;
    self.autoresizingMask =  NSViewWidthSizable | NSViewHeightSizable;
    [self setContentCompressionResistancePriority:NSLayoutPriorityDragThatCannotResizeWindow forOrientation:NSLayoutConstraintOrientationHorizontal];
}





@end