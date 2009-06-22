//
//  ComparisonPromptController.m
//  FontKit
//
//  Created by Adrian on 6/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "ComparisonPromptController.h"

@implementation ComparisonPromptController

@synthesize controller;

#pragma mark -
#pragma mark Constructor and destructor

- (id)init
{
    if (self = [super init])
    {
        controller = [[UINavigationController alloc] initWithRootViewController:self];
        
        self.navigationItem.prompt = @"Select a font to compare with";
        self.delegate = self;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                   target:self
                                                                                   action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancelItem;
        [cancelItem release];
    }
    return self;
}

- (void)dealloc
{
    [controller release];
    [super dealloc];
}

#pragma mark -
#pragma mark IBAction methods

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark FontsControllerDelegate methods

- (void)fontsController:(FontsController *)controller rowSelectedAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
