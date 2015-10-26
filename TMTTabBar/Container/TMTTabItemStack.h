//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TMTTabItemStack<__covariant ItemType> : NSObject<NSFastEnumeration> {
    NSMutableArray<ItemType> *_items;
}
- (instancetype)init;

- (BOOL)isEmpty;

- (void)push:(ItemType)tabItem;

- (ItemType)pop;

- (id)peek;

- (NSUInteger)size;

- (void)remove:(ItemType)item;
@end