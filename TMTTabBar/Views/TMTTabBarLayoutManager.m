//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarLayoutManager.h"


@implementation TMTTabBarLayoutManager {

    NSView *_view;
    NSArray<NSLayoutConstraint *> *_constraints;
}

- (instancetype)initForView:(NSView *)view {
    self = [super init];
    if(self) {
        _view = view;
        _constraints = [NSArray new];
    }
    return self;
}

- (void)updateLayout {

    [NSLayoutConstraint deactivateConstraints:_constraints];
    NSMutableArray<NSLayoutConstraint *> *newConstraints = [NSMutableArray new];

    NSArray<NSView *> *views = _view.subviews;

    for(int i = 0; i < views.count; ++i) {
        if(i == 0) {
            [newConstraints addObject:[self attachLeft:views[i]]];
        }
        if(i == views.count-1) {
            [newConstraints addObject:[self attachRight:views[i]]];
        }
        if(i+1 < views.count) {
            [newConstraints addObject:[self connectMiddle:views[i] withNext:views[i + 1]]];
            [newConstraints addObject:[self equalWidth:views[i] withNext:views[i + 1]]];
        }
        [newConstraints addObject:[self attachTop:views[i]]];
        [newConstraints addObject:[self attachBottom:views[i]]];
    }

    _constraints = newConstraints;

    [NSLayoutConstraint activateConstraints:_constraints];
}

- (NSLayoutConstraint *)attachTop:(NSView *)view {
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:_view
                                        attribute:NSLayoutAttributeTop
                                       multiplier:1
                                         constant:0];
}

- (NSLayoutConstraint *)attachBottom:(NSView *)view {
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:_view
                                        attribute:NSLayoutAttributeBottom
                                       multiplier:1
                                         constant:0];
}

- (NSLayoutConstraint *)equalWidth:(NSView *)view withNext:(NSView *)next {
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:next
                                        attribute:NSLayoutAttributeWidth
                                       multiplier:1
                                         constant:0];
}

- (NSLayoutConstraint *)attachLeft:(NSView *)view {
    return [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:0];
}


- (NSLayoutConstraint *)attachRight:(NSView *)view {
    return [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0];
}

- (NSLayoutConstraint *) connectMiddle:(NSView *)view withNext:(NSView *)nextView {
    return [NSLayoutConstraint constraintWithItem:nextView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0];
}
@end
