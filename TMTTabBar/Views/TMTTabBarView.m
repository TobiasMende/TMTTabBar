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


@interface TMTTabBarView ()
- (void)initMember;

- (void)updateLayout;

- (void)activateTabItem:(TMTTabItemView *)actionedItem;
@end

@implementation TMTTabBarView {
    NSMutableArray <TMTTabItemView *> *_tabViews;
    NSButton *_addButton;
    NSArray <NSLayoutConstraint *> *_tabConstraints;
    NSLayoutConstraint *_buttonLeftConstraint;
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
    _tabViews = [NSMutableArray new];
    _tabConstraints = [NSArray new];
    _style = [TMTTabBarStyle new];

    [self initAddButton];

}

- (void)initAddButton {
    _addButton = [NSButton new];
    _addButton.bezelStyle = NSRegularSquareBezelStyle;
    _addButton.bordered = NO;
    _addButton.image = [NSImage imageNamed:NSImageNameAddTemplate];
    _addButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:_addButton];
    [NSLayoutConstraint constraintWithItem:_addButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.f constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_addButton
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.f constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_addButton
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.f constant:-self.style.addButtonSpacing].active = YES;
    [NSLayoutConstraint constraintWithItem:_addButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_addButton
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:0].active = YES;

    // TODO: connect action to delegate (implement delegate)
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [self.style.backgroundColor setFill];
    NSRectFill(self.bounds);

    // Drawing code here.
}

- (void)addTabView:(TMTTabItemView *)tabView {
    assert(!tabView.parent);
    tabView.parent = self;
    [_tabViews addObject:tabView];
    [self addSubview:tabView];
    [self updateLayout];
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    if (tabView.parent != self) {
        return;
    }
    [_tabViews removeObject:tabView];
    [tabView removeFromSuperview];
    tabView.parent = nil;
    [self updateLayout];
}

- (void)updateLayout {

    TMTTabBarLayoutManager *layoutManager = [[TMTTabBarLayoutManager alloc] initForView:self];

    _tabConstraints = [layoutManager updateLayoutConstraints:_tabConstraints forViews:_tabViews];

    [self updateAddButtonConstraints];

    self.needsDisplay = YES;
}

- (void)updateAddButtonConstraints {
    _buttonLeftConstraint.active = NO;
    if (_tabViews.count > 0) {
        _buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:_addButton
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_tabViews.lastObject
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:self.style.addButtonSpacing];
        _buttonLeftConstraint.active = YES;
    }
}

- (void)activateTabItem:(TMTTabItemView *)actionedItem {
    actionedItem.active = YES;
    for (TMTTabItemView *item in _tabViews) {
        if (item != actionedItem) {
            item.active = NO;
        }
    }
}

#pragma mark - TMTTabItemDelegate

- (void)selectTab:(TMTTabItemView *_Nonnull)actionedItem {
    [self activateTabItem:actionedItem];
}

- (void)closeTab:(TMTTabItemView *_Nonnull)item {
    [self removeTabView:item];
}


@end
