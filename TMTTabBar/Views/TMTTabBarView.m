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


@interface TMTTabBarView ()
- (void)initMember;

- (void)addTabItemClicked;
@end

@implementation TMTTabBarView {
    NSButton *_addButton;
    NSView *_tabArea;
    TMTTabBarLayoutManager *_layoutManager;
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

    [self initTabArea];
    [self initAddButton];

    _layoutManager = [[TMTTabBarLayoutManager alloc] initForView:_tabArea];
}

- (void)initTabArea {
    _tabArea = [NSView new];
    _tabArea.translatesAutoresizingMaskIntoConstraints = NO;
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
    [NSLayoutConstraint constraintWithItem:_addButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_tabArea
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:self.style.addButtonSpacing].active = YES;

    _addButton.target = self;
    _addButton.action = @selector(addTabItemClicked);
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [self.style.backgroundColor setFill];
    NSRectFill(self.bounds);
}

- (void)addTabView:(TMTTabItemView *)tabView {
    [_tabArea addSubview:tabView];
    [_layoutManager updateLayout];
}

- (void)removeTabView:(TMTTabItemView *)tabView {
    [tabView removeFromSuperview];
    [_layoutManager updateLayout];
}

- (void)addTabItemClicked {
    [self.parent createTabItem];
}


- (void)activateTabItem:(TMTTabItemView *)actionedItem {
    actionedItem.active = YES;
    for (TMTTabItemView *item in _tabArea.subviews) {
        if (item != actionedItem) {
            item.active = NO;
        }
    }
}



@end
