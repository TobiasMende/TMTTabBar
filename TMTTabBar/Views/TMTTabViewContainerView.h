//
// Created by Tobias Mende on 27.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TMTTabContainerDelegate;


@interface TMTTabViewContainerView : NSBox

@property (weak) id<TMTTabContainerDelegate> parent;

- (IBAction)performClose:(id)sender;
- (IBAction)performCloseAll:(id)sender;
- (IBAction)performCloseAllButActive:(id)sender;

- (IBAction)performAddNewTab:(id)sender;
@end