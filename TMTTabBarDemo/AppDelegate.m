//
//  AppDelegate.m
//  TMTTabBarDemo
//
//  Created by Tobias Mende on 25.10.15.
//  Copyright © 2015 Tobias Mende. All rights reserved.
//

#import <TMTTabBar/TMTTabBar.h>
#import "TMTTabItemView.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)addTab:(id)sender {
    TMTTabItemView *view = [[TMTTabItemView alloc] initWithFrame:NSMakeRect(0,0,0,0)];
    view.title = [NSString stringWithFormat:@"Tab %i", self.tabCounter++];
    [self.tabBar addTabView:view];
}

- (IBAction)removeTab:(id)sender {
    TMTTabItemView *view = (TMTTabItemView *)self.tabBar.subviews.lastObject;
    if(view) {
        [self.tabBar removeTabView:view];
    }
}
@end
