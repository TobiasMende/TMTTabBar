//
// Created by Tobias Mende on 28.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMTRenderingHints : NSObject

@property (nonatomic) BOOL active;
@property (nonatomic) BOOL highlight;

- (instancetype)initForView:(NSView * _Nonnull)view;
@end