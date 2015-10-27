//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarStyle.h"


@implementation TMTTabBarStyle {

}
- (instancetype)init {
    self = [super init];
    if(self) {
        _backgroundColor = [NSColor windowFrameColor];
        _addButtonSpacing = 0.5;
    }
    return self;
}

@end