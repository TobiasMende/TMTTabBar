//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarLayoutManager.h"


@implementation TMTTabBarLayoutManager {

    NSView *_view;
    NSArray<NSLayoutConstraint *> *_constraints;
    NSUInteger _lastDropPosition;

}

- (instancetype)initForView:(NSView *)view {
    self = [super init];
    if(self) {
        _view = view;
        _constraints = [NSArray new];
        _lastDropPosition = NSNotFound;
    }
    return self;
}

- (void)addView:(NSView *)view {
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizingMask = NSViewMaxXMargin | NSViewMinXMargin | NSViewWidthSizable;

    if(_view.subviews.count > 0) {
        NSView *last = _view.subviews.lastObject;
        NSLog(@"constraints = %@", last.constraints);
    }
}


- (void)updateLayout {
    [self updateLayoutWithDropSpaceAt:NSNotFound];
}

- (void)updateLayoutWithDropSpaceAt:(NSUInteger)dropPosition {
    if(dropPosition != NSNotFound && dropPosition == _lastDropPosition) {
        return;
    }

    /*NSLog(@"drop pos = %li", dropPosition);
    _lastDropPosition = dropPosition;

    NSMutableArray<NSLayoutConstraint *> *newConstraints = [NSMutableArray new];

    NSArray<NSView *> *views = _view.subviews;

    for(int i = 0; i < views.count; ++i) {
        [newConstraints addObject:[self attachTop:views[i]]];
        [newConstraints addObject:[self attachBottom:views[i]]];
        [newConstraints addObject:[self connectLeft:i withDropPostion:dropPosition]];

        if(i == views.count-1) {
            CGFloat distance = (dropPosition == views.count) ? self.dropSpace : 0;
            [newConstraints addObject:[self attachRight:views[i] withDistance:distance]];
        }
        if(i+1 < views.count) {
            [newConstraints addObject:[self equalWidth:views[i] withNext:views[i + 1]]];
        }
    }

    [NSLayoutConstraint deactivateConstraints:_constraints];
    _constraints = newConstraints;
    [NSLayoutConstraint activateConstraints:_constraints];
    [self animate];*/
}

- (void)animate {
    _view.wantsLayer = YES;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext* context) {
        context.duration = 0.5;
        context.allowsImplicitAnimation = YES;
        [_view layoutSubtreeIfNeeded];
    } completionHandler:nil];
}

- (CGFloat)dropSpace {
    return _view.bounds.size.width/(CGFloat)(_view.subviews.count+1);
}

- (NSLayoutConstraint *)connectLeft:(NSUInteger)viewIndex withDropPostion:(NSUInteger)dropPosition {
    CGFloat distance = (viewIndex == dropPosition) ? self.dropSpace : 0;
    NSView *view = _view.subviews[viewIndex];
    if(viewIndex == 0) {
        return [self attachLeft:view withDistance:distance];
    } else {
        NSView *predecessor = _view.subviews[viewIndex-1];
        return [self connect:view withPrevious:predecessor havingDistance:distance];
    }
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

- (NSLayoutConstraint *)attachLeft:(NSView *)view withDistance:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:constant];
}

- (NSLayoutConstraint *)attachRight:(NSView *)view withDistance:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:constant];
}

- (NSLayoutConstraint *)connect:(NSView *)view withPrevious:(NSView *)previous havingDistance:(CGFloat)constant {
    return [NSLayoutConstraint constraintWithItem:view
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:previous
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:constant];
}
@end
