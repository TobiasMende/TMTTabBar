//
// Created by Tobias Mende on 07.11.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabViewController;
@class TMTTabbedWindow;
@protocol TMTTabViewDelegate;


@interface TMTTabWindowFactory : NSObject


+ (nonnull TMTTabViewController *)createTabWindow:(nonnull id <TMTTabViewDelegate>)delegate atPosition:(NSPoint)position;

+ (void)unregister:(nonnull TMTTabbedWindow *)window;

@end