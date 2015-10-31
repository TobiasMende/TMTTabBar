//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMTRenderingHints;


@interface TMTTabItemStyle : NSObject

@property (nonnull) NSColor *inactiveBackgroundColor;
@property (nonnull) NSColor *activeBackgroundColor;

@property (nonnull) NSColor *inactiveBorderColor;
@property (nonnull) NSColor *activeBorderColor;

@property (nonnull) NSColor *inactiveTextColor;
@property (nonnull) NSColor *activeTextColor;

@property CGFloat rightMargin;
@property CGFloat leftMargin;
@property CGFloat dragItemMaxWidth;

- (id _Nonnull) init;

- (void)styleBackgroundForRect:(NSRect)rect withRenderingHints:(TMTRenderingHints *_Nonnull)renderingHints;

- (void)styleBordersForRect:(NSRect)rect withRenderingHinter:(TMTRenderingHints *_Nonnull)renderingHint;

- (void)styleTitle:(NSTextField *_Nonnull)titleField withRenderingHints:(TMTRenderingHints *_Nonnull)renderingHints;
@end
