//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMTTabItemView;

@protocol TMTTabItemDelegate <NSObject>
- (void)clickedOnTab:(TMTTabItemView * _Nonnull)item;
@end