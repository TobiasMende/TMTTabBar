//
// Created by Tobias Mende on 26.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import "TMTTabItemStack.h"

@implementation TMTTabItemStack {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray new];
    }
    return self;
}


- (BOOL)isEmpty {
    return _items.count == 0;
}

- (void)push:(id)tabItem {
    NSUInteger index = [_items indexOfObject:tabItem];
    if (index != NSNotFound) {
        [_items removeObjectAtIndex:index];
    }
    [_items addObject:tabItem];
}

- (id)pop {
    id item = _items.lastObject;
    if (item) {
        [_items removeLastObject];
    }
    return item;
}

- (id)peek {
    return _items.lastObject;
}

- (NSUInteger)size {
    return _items.count;
}

- (void)remove:(id)item {
    [_items removeObject:item];
}


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained[])buffer count:(NSUInteger)len {
    if(state->state == 0) {
        state->mutationsPtr = (__bridge void*)self;
        state->extra[0] = self.size;
        state->state = 1;
    }
    NSUInteger remaining = state->extra[0];
    if(remaining <= 0) {
        return 0;
    }

    __unsafe_unretained id item = _items[--remaining];
    state->itemsPtr = &item;
    state->extra[0] = remaining;
    return 1;
}
@end