//
//  FontKitAppDelegate.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface FontKitAppDelegate : NSObject <UIApplicationDelegate> 
{
@private
    IBOutlet UIWindow *window;
    MainController *viewController;
}

@end

