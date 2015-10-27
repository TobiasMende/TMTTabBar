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
#import "TMTTabTitleView.h"

@interface TMTTabItemView ()
- (void)initMember;

- (void)initTitleView;

- (void)drawBorders;

- (void)drawBackground;

- (void)drawLabel;

- (void)closeTab;
@end

@implementation TMTTabItemView {
    TMTTabTitleView *_titleView;
    NSButton* _closeButton;
    NSTrackingArea*_trackingArea;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initMember];
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    [self initMember];
    return self;
}

- (instancetype)init {
    self = [super init];
    [self initMember];
    return self;
}

- (void)dealloc {
    [_titleView unbind:@"value"];
}

- (void)initMember {
    _style = [TMTTabItemStyle new];
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
    [_titleView bind:@"value" toObject:self withKeyPath:@"title" options:@{NSValidatesImmediatelyBindingOption : @YES,
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

    [self drawBackground];
    [self drawBorders];
    [self drawLabel];
}

- (void)drawBorders {
    if (self.active) {
        [self.style.activeBorderColor setStroke];
    } else {
        [self.style.inactiveBorderColor setStroke];
    }

    CGPoint upperLeft = self.bounds.origin;
    CGPoint upperRight = CGPointMake(upperLeft.x + self.bounds.size.width, upperLeft.y);
    [self drawVerticalBorderForUpper:upperRight];
}

- (void)drawVerticalBorderForUpper:(CGPoint)upper {
    CGPoint lower = CGPointMake(upper.x, upper.y + self.bounds.size.height);
    [NSBezierPath strokeLineFromPoint:upper toPoint:lower];
}

- (void)drawBackground {
    NSColor* color = self.active ? self.style.activeBackgroundColor : self.style.inactiveBackgroundColor;

    //_titleView.backgroundColor = color;
    [color setFill];
    NSRectFill(self.bounds);
}

- (void)drawLabel {
    _titleView.textColor = self.active ? self.style.activeTextColor : self.style.inactiveTextColor;
}

#pragma mark - Setter and Getter

- (void)setActive:(BOOL)active {
    _active = active;
    self.needsDisplay = YES;
}

#pragma mark - Actions

- (void)closeTab {
    [self.parent closeTab:self];
}

#pragma mark - Mouse Actions

- (void)mouseDown:(NSEvent *)theEvent {
    [self.parent selectTab:self];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [_closeButton.animator setAlphaValue:1.0f];
}

- (void)mouseExited:(NSEvent *)theEvent {
    [_closeButton.animator setAlphaValue:0.0f];
}


- (void)updateTrackingAreas {
    if(_trackingArea != nil) {
        [self removeTrackingArea:_trackingArea];
    }

    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                  options:opts
                                                    owner:self
                                                 userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

@end
