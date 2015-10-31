//
// Created by Tobias Mende on 31.10.15.
// Copyright (c) 2015 Tobias Mende. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TMTTabContainerDelegate <NSObject>
- (void)closeActiveTab;
- (void)closeAllTabs;
- (void)closeAllButActive;
- (void)createTab;
@end