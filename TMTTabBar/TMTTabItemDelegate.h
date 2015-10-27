//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabItemView;

@protocol TMTTabItemDelegate <NSObject>
- (void)selectTab:(TMTTabItemView * _Nonnull)item;
- (void)closeTab:(TMTTabItemView * _Nonnull)item;
@end