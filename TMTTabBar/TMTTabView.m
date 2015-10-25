//
//  TMTTabView.m
//  TMTTabBarView
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabView.h"

@implementation TMTTabView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self.label drawInRect:self.bounds withAttributes:nil];
    // Drawing code here.
}

@end
