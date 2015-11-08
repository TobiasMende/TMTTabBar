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
#import "NSView+ImageRepresentation.h"
#import "TMTTabBar.h"

@interface TMTTabItemView ()
- (void)initMember;

- (void)initSubviews;

- (void)initCloseButton;

- (void)initTitleView;

- (void)initCustomView;

- (void)closeTab;

- (NSArray<NSDraggingImageComponent *> *)draggingImages;
@end

@implementation TMTTabItemView {
    TMTTabTitleView *_titleView;
    NSButton *_closeButton;
    NSTrackingArea *_trackingArea;
    TMTRenderingHints *_hints;
    NSBox *_customViewContainer;
}

- (instancetype)initWithItem:(TMTTabItem *_Nonnull)item andStyle:(TMTTabItemStyle *)style {
    self = [super init];
    if (self) {
        _item = item;
        _style = style;
        [self initMember];
        self.edgeInsets = NSEdgeInsetsMake(0, 5, 0, 0);
    }
    return self;
}

- (void)dealloc {
    [_titleView unbind:@"value"];

}

- (void)initMember {
    _hints = [[TMTRenderingHints alloc] initForView:self];
    [self initSubviews];
    self.spacing = 0;
}

- (void)initSubviews {
    [self initTitleView];
    [self initCloseButton];
    [self initCustomView];

    self.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
}

- (void)initCloseButton {
    _closeButton = [NSButton new];
    _closeButton.bezelStyle = NSRegularSquareBezelStyle;
    _closeButton.bordered = NO;
    _closeButton.image = [NSImage imageNamed:NSImageNameStopProgressTemplate];
    [self addView:_closeButton inGravity:NSStackViewGravityLeading];

    _closeButton.alphaValue = 0.0f;
    _closeButton.target = self;
    _closeButton.action = @selector(closeTab);

}

- (void)initTitleView {
    _titleView = [TMTTabTitleView new];
    [self addView:_titleView inGravity:NSStackViewGravityCenter];
    [_titleView bind:@"value" toObject:self withKeyPath:@"item.label" options:@{NSValidatesImmediatelyBindingOption : @YES,
            NSContinuouslyUpdatesValueBindingOption : @YES}];

}

- (void)initCustomView {
    _customViewContainer = [NSBox new];
    _customViewContainer.borderType = NSNoBorder;
    _customViewContainer.boxType = NSBoxCustom;
    [NSLayoutConstraint constraintWithItem:_customViewContainer
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_customViewContainer attribute:NSLayoutAttributeHeight
                                multiplier:1 constant:0].active = YES;
    [self addView:_customViewContainer inGravity:NSStackViewGravityTrailing];

    [_customViewContainer bind:@"contentView" toObject:self withKeyPath:@"item.customView" options:@{NSValidatesImmediatelyBindingOption : @YES,
            NSContinuouslyUpdatesValueBindingOption : @YES}];
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

#pragma mark - Dragging

- (void)mouseDragged:(NSEvent *)theEvent {

    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    [pbItem setDataProvider:self forTypes:@[TMTTabItemDragType]];

    NSDraggingItem *draggingItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];

    [draggingItem setImageComponentsProvider:^NSArray * {
        return [self draggingImages];
    }];

    [self beginDraggingSessionWithItems:@[draggingItem] event:theEvent source:self];
    [self removeFromSuperview];
}

- (NSArray<NSDraggingImageComponent *> *)draggingImages {
    NSRect itemBounds = self.bounds;
    NSRect scaledContentBounds = self.item.view.bounds;
    scaledContentBounds.size.height *= itemBounds.size.width / scaledContentBounds.size.width;
    scaledContentBounds.size.width = itemBounds.size.width;
    scaledContentBounds.origin.y -= scaledContentBounds.size.height;

    NSDraggingImageComponent *item = [NSDraggingImageComponent draggingImageComponentWithKey:NSDraggingImageComponentIconKey];
    item.contents = self.imageRepresentation;
    item.frame = itemBounds;

    NSDraggingImageComponent *contentView = [NSDraggingImageComponent draggingImageComponentWithKey:NSDraggingImageComponentIconKey];
    contentView.frame = scaledContentBounds;
    contentView.contents = self.item.view.imageRepresentation;

    return @[item, contentView];
}

#pragma mark - NSDraggingSource

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    return [self.parent draggingSession:session sourceOperationMaskForDraggingContext:context forItem:self.item];
}

- (void)draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation {
    [self.parent draggingSession:session endedAtPoint:screenPoint operation:operation forItem:self.item];
}

#pragma mark - NSPasteboardItemDataProvider

- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSString *)type {

}

@end
