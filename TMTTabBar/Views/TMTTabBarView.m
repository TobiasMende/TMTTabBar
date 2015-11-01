//
//  TMTTabBarView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarView.h"
#import "TMTTabItemView.h"
#import "TMTTabBarStyle.h"
#import "TMTTabBarDelegate.h"
#import "TMTTabBar.h"
#import "TMTTabAreaView.h"


@interface TMTTabBarView ()
- (void)initMember;

- (void)addTabItemClicked;
@end

@implementation TMTTabBarView {
    NSButton *_addButton;
    TMTTabAreaView *_tabArea;
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
    self.translatesAutoresizingMaskIntoConstraints = YES;

}

- (void)initTabArea {
    _tabArea = [TMTTabAreaView new];
    [self addView:_tabArea inGravity:NSStackViewGravityCenter];
}

- (void)initAddButton {
    _addButton = [NSButton new];
    _addButton.bezelStyle = NSRegularSquareBezelStyle;
    _addButton.bordered = NO;
    _addButton.image = [NSImage imageNamed:NSImageNameAddTemplate];
    _addButton.translatesAutoresizingMaskIntoConstraints = YES;
    _addButton.target = self;
    _addButton.action = @selector(addTabItemClicked);
    [_addButton setContentHuggingPriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationHorizontal];
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
        [self addView:_addButton inGravity:NSStackViewGravityLeading];
    } else {
        [self removeView:_addButton];
    }
}
@end
