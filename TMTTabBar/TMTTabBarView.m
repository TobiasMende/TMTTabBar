//
//  TMTTabBarView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabBarView.h"
#import "TMTTabView.h"


@interface TMTTabBarView ()
- (void)updateLayout;

- (NSSize)calculateTabSize;
@end

@implementation TMTTabBarView {
    NSMutableArray<TMTTabView *> * _tabViews;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

- (void)addTabView:(TMTTabView *)tabView {
    [_tabViews addObject:tabView];
    [self addSubview:tabView];
    [self updateLayout];
}

- (void)removeTabView:(TMTTabView *)tabView {
    [_tabViews removeObject:tabView];
    [tabView removeFromSuperview];
    [self updateLayout];
}

- (void)updateLayout {
    NSSize tabSize = self.calculateTabSize;
    [self updateTabBounds:tabSize];

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


@end
