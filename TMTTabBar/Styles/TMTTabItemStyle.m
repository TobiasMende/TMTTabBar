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
        _inactiveBackgroundColor = [NSColor controlBackgroundColor];
        _activeBackgroundColor = [NSColor secondarySelectedControlColor];

        _inactiveBorderColor = [NSColor controlDarkShadowColor];
        _activeBorderColor = [NSColor controlShadowColor];

        _inactiveTextColor = [NSColor controlTextColor];
        _activeTextColor = [NSColor controlTextColor];
    }
    return self;
}

@end