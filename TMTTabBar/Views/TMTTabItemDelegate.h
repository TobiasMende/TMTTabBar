//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabItem;

@protocol TMTTabItemDelegate <NSObject>
- (void)selectTab:(TMTTabItem * _Nonnull)item;
- (void)closeTab:(TMTTabItem * _Nonnull)item;
@end