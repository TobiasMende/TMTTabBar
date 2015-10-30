//
//  TMTTabItemView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabItemView.h"
#import "TMTTabItemStyle.h"
#import "TMTTabItemDelegate.h"
#import "TMTTabItem.h"
#import "TMTTabTitleView.h"
#import "TMTRenderingHints.h"

@interface TMTTabItemView ()
- (void)initMember;

- (void)initSubviews;

- (void)initCloseButton;

- (void)initTitleView;

- (void)initCustomView;

- (void)setupLayout;

- (void)setupCloseButtonLayout;

- (void)setupCustomViewLayout;

- (void)setupTitleViewLayout;

- (void)closeTab;
@end

@implementation TMTTabItemView {
    TMTTabTitleView *_titleView;
    NSButton *_closeButton;
    NSTrackingArea *_trackingArea;
    TMTRenderingHints *_hints;
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

- (instancetype)initWithItem:(TMTTabItem *_Nonnull)item {
    self = [super init];
    if (self) {
        _item = item;
        [self initMember];
    }
    return self;
}

- (void)dealloc {
    [_titleView unbind:@"value"];
}

- (void)initMember {
    _style = [TMTTabItemStyle new];
    _hints = [[TMTRenderingHints alloc] initForView:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self initSubviews];
    [self setupLayout];
}

- (void)initSubviews {
    [self initTitleView];
    [self initCloseButton];
    [self initCustomView];
}

- (void)initCloseButton {
    _closeButton = [NSButton new];
    _closeButton.bezelStyle = NSRegularSquareBezelStyle;
    _closeButton.bordered = NO;
    _closeButton.image = [NSImage imageNamed:NSImageNameStopProgressTemplate];
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_closeButton];

    _closeButton.alphaValue = 0.0f;
    _closeButton.target = self;
    _closeButton.action = @selector(closeTab);

}

- (void)initTitleView {
    _titleView = [TMTTabTitleView new];
    [self addSubview:_titleView];
    [_titleView bind:@"value" toObject:self withKeyPath:@"item.label" options:@{NSValidatesImmediatelyBindingOption : @YES,
            NSContinuouslyUpdatesValueBindingOption : @YES}];

}

- (void)initCustomView {
    _customView = [NSBox new];
    _customView.borderType = NSNoBorder;
    _customView.boxType = NSBoxCustom;
    _customView.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:_customView];
}

- (void)setupLayout {
    [self setupCloseButtonLayout];
    [self setupTitleViewLayout];
    [self setupCustomViewLayout];
}

- (void)setupCloseButtonLayout {
    [NSLayoutConstraint constraintWithItem:_closeButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:self.style.leftMargin].active = YES;

    [NSLayoutConstraint constraintWithItem:_closeButton
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1
                                  constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_closeButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_closeButton
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:0].active = YES;
}

- (void)setupCustomViewLayout {
    [NSLayoutConstraint constraintWithItem:_customView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:-self.style.rightMargin].active = YES;

    [NSLayoutConstraint constraintWithItem:_customView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_customView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0.f].active = YES;
    [NSLayoutConstraint constraintWithItem:_customView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_customView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:0].active = YES;
}

- (void)setupTitleViewLayout {
    [NSLayoutConstraint constraintWithItem:_titleView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_closeButton
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_customView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_titleView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0].active = YES;
}


#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    [_style styleBackgroundForRect:self.bounds withRenderingHints:_hints];
    [_style styleBordersForRect:self.bounds withRenderingHinter:_hints];
    [_style styleTitle:_titleView withRenderingHints:_hints];
}

#pragma mark - Setter and Getter

- (void)setActive:(BOOL)active {
    _hints.active = active;
}

#pragma mark - Actions

- (void)closeTab {
    [self.parent closeTab:self.item];
}

#pragma mark - Mouse Actions

- (void)mouseDown:(NSEvent *)theEvent {
    [self.parent selectTab:self.item];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    _hints.highlight = YES;
    [_closeButton.animator setAlphaValue:1.0f];
}

- (void)mouseExited:(NSEvent *)theEvent {
    _hints.highlight = NO;
    [_closeButton.animator setAlphaValue:0.0f];
}

- (void)updateTrackingAreas {
    if (_trackingArea != nil) {
        [self removeTrackingArea:_trackingArea];
    }

    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:opts
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

@end
