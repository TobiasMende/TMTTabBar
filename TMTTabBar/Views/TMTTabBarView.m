//
//  TMTTabBarView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarView.h"
#import "TMTTabItemView.h"
#import "TMTTabBarLayoutManager.h"
#import "TMTTabBarStyle.h"
#import "TMTTabBarDelegate.h"
#import "NSView+TMTCoordinateHelpers.h"
#import "TMTTabBar.h"
#import "TMTTabAreaView.h"


@interface TMTTabBarView ()
- (void)initMember;

- (void)addTabItemClicked;
@end

@implementation TMTTabBarView {
    NSButton *_addButton;
    TMTTabAreaView *_tabArea;

    NSArray <NSLayoutConstraint *> *_addButtonVisible;

    NSLayoutConstraint *_addButtonInvisible;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initMember];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self initMember];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initMember];
    }
    return self;
}

- (void)initMember {
    _style = [TMTTabBarStyle new];
    [_style addObserver:self forKeyPath:@"shouldShowAddButton" options:NSKeyValueObservingOptionNew context:NULL];

    [self initTabArea];
    [self initAddButton];

}

- (void)initTabArea {
    _tabArea = [TMTTabAreaView new];
    [self addSubview:_tabArea];

    [NSLayoutConstraint constraintWithItem:_tabArea
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.f constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_tabArea
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.f constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_tabArea
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.f constant:0].active = YES;

    _addButtonInvisible = [NSLayoutConstraint
            constraintWithItem:_tabArea
                     attribute:NSLayoutAttributeRight
                     relatedBy:NSLayoutRelationEqual
                        toItem:self
                     attribute:NSLayoutAttributeRight
                    multiplier:1 constant:0];
}

- (void)initAddButton {
    _addButton = [NSButton new];
    _addButton.bezelStyle = NSRegularSquareBezelStyle;
    _addButton.bordered = NO;
    _addButton.image = [NSImage imageNamed:NSImageNameAddTemplate];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;
    _addButton.target = self;
    _addButton.action = @selector(addTabItemClicked);

    _addButtonVisible = @[
            [NSLayoutConstraint constraintWithItem:_addButton
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                         attribute:NSLayoutAttributeTop
                                        multiplier:1.f constant:0.f],
            [NSLayoutConstraint constraintWithItem:_addButton
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                         attribute:NSLayoutAttributeBottom
                                        multiplier:1.f constant:0.f],
            [NSLayoutConstraint constraintWithItem:_addButton
                                         attribute:NSLayoutAttributeRight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                         attribute:NSLayoutAttributeRight
                                        multiplier:1.f
                                          constant:-self.style.addButtonSpacing],
            [NSLayoutConstraint constraintWithItem:_addButton
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_addButton
                                         attribute:NSLayoutAttributeHeight
                                        multiplier:1
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:_addButton
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_tabArea
                                         attribute:NSLayoutAttributeRight
                                        multiplier:1
                                          constant:self.style.addButtonSpacing]
    ];
    [self updateAddButtonVisibility];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [self.style.backgroundColor setFill];
    NSRectFill(self.bounds);
}

- (void)setStyle:(TMTTabBarStyle *)style {
    if (_style) {
        [_style removeObserver:self forKeyPath:@"shouldShowAddButton"];
    }
    _style = style;
    if (_style) {
        [_style addObserver:self forKeyPath:@"shouldShowAddButton" options:NSKeyValueObservingOptionNew context:NULL];
    }

}

#pragma mark - Adding and Removing Tab Views

- (void)setParent:(nullable id <TMTTabBarDelegate>)parent {
    _parent = parent;
    _tabArea.parent = _parent;
}

- (void)addTabView:(TMTTabItemView *)tabView {
    [_tabArea addTabView:tabView];
}

- (void)addTabView:(TMTTabItemView *)tabView atPoint:(NSPoint)windowLocation {
    [_tabArea addTabView:tabView atPoint:windowLocation];
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    [_tabArea removeTabView:tabView];
}

- (void)addTabItemClicked {
    [self.parent createTab];
}

- (void)activateTabItem:(TMTTabItemView *)actionedItem {
    actionedItem.active = YES;
    for (TMTTabItemView *item in _tabArea.subviews) {
        if (item != actionedItem) {
            item.active = NO;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _style && [keyPath isEqualToString:@"shouldShowAddButton"]) {
        [self updateAddButtonVisibility];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateAddButtonVisibility {
    if (self.style.shouldShowAddButton) {
        _addButtonInvisible.active = NO;
        [self addSubview:_addButton];
        [NSLayoutConstraint activateConstraints:_addButtonVisible];

    } else {
        [NSLayoutConstraint deactivateConstraints:_addButtonVisible];
        [_addButton removeFromSuperview];
        _addButtonInvisible.active = YES;
    }
}
@end
