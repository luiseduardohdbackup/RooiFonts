//
//  RFFontsController.h
//  RooiFonts
//
//  Created by Adrian on 11/12/08.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFFontsControllerDelegate.h"

@interface RFFontsController : UITableViewController

@property (nonatomic, assign) IBOutlet id<RFFontsControllerDelegate> delegate;
@property (nonatomic, readonly) NSString *currentlySelectedFontName;
@property (nonatomic, readonly) NSString *currentlySelectedFontFamily;

@end