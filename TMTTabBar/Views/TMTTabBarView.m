//
//  TMTTabBarView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarView.h"
#import "TMTTabItemView.h"


@interface TMTTabBarView ()
- (void)initMember;

- (void)updateLayout;

- (NSSize)calculateTabSize;

- (void)activateTabItem:(TMTTabItemView *)actionedItem;
@end

@implementation TMTTabBarView {
    NSMutableArray<TMTTabItemView *> * _tabViews;
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
    if  (self) {
        [self initMember];
    }
    return self;
}

- (void)initMember {
    _tabViews = [NSMutableArray new];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

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
    if(tabView.parent != self) {
        return;
    }
    [_tabViews removeObject:tabView];
    [tabView removeFromSuperview];
    tabView.parent = nil;
    [self updateLayout];
}

- (void)updateLayout {
    if(_tabViews.count == 0) {
        return;
    }

    NSSize tabSize = self.calculateTabSize;
    [self updateTabBounds:tabSize];
    [self activateTabItem:_tabViews.lastObject];

    self.needsDisplay = YES;
}

- (void)updateTabBounds:(const NSSize)tabSize {
    NSPoint offset = NSMakePoint(0, 0);

    for (NSView *view in self.subviews) {
        view.frame = NSMakeRect(offset.x, offset.y, tabSize.width, tabSize.height);
        offset.x += tabSize.width;
        view.needsDisplay = YES;
    }
}

- (NSSize) calculateTabSize {
    const NSUInteger numberOfSubviews = self.subviews.count;
    if(numberOfSubviews == 0) {
        return NSMakeSize(0, 0);
    }
    const NSSize viewSize = self.bounds.size;
    const CGFloat tabWidth = viewSize.width / (CGFloat)numberOfSubviews;
    return NSMakeSize(tabWidth, viewSize.height);
}

- (void)activateTabItem:(TMTTabItemView *)actionedItem {
    actionedItem.active = YES;
    for(TMTTabItemView *item in _tabViews) {
        if (item != actionedItem) {
            item.active = NO;
        }
    }
}

#pragma mark - TMTTabItemDelegate

- (void)clickedOnTab:(TMTTabItemView *_Nonnull)actionedItem {
    [self activateTabItem:actionedItem];
}


@end
