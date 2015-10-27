//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabItemStyle.h"


@implementation TMTTabItemStyle {

}
- (id)init {
    self = [super init];
    if(self) {
        _inactiveBackgroundColor = [NSColor headerColor];
        _activeBackgroundColor = [NSColor gridColor];

        _inactiveBorderColor = [NSColor controlDarkShadowColor];
        _activeBorderColor = [NSColor controlShadowColor];

        _inactiveTextColor = [NSColor controlTextColor];
        _activeTextColor = [NSColor controlTextColor];
        _rightMargin = 1;
        _leftMargin = 4;
    }
    return self;
}

@end