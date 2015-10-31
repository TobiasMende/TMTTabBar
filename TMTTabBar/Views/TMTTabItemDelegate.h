//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabItem;

@protocol TMTTabItemDelegate <NSObject>
- (void)selectTab:(nonnull TMTTabItem *)item;
- (void)closeTab:(nonnull TMTTabItem *)item;
@end