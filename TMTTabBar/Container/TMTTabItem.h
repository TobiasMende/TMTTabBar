//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMTTabItem : NSObject<NSCopying>
@property NSString *label;
@property NSView *view;
@property NSView *customView;
@end