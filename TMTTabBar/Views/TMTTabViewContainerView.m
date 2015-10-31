//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabViewContainerView.h"
#import "TMTTabContainerDelegate.h"


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

- (void)performClose:(id)sender {
    [self.parent closeActiveTab];
}

- (void)performCloseAll:(id)sender {
    [self.parent closeAllTabs];
}

- (void)performCloseAllButActive:(id)sender {
    [self.parent closeAllButActive];

}

- (void)performAddNewTab:(id)sender {
    [self.parent createTab];
}

@end