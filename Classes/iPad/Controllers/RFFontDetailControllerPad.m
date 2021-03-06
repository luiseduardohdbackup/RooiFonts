//
//  RFFontDetailControllerPad.m
//  RooiFonts
//
//  Created by Adrian on 9/15/11.
//  Copyright 2011 akosma software. All rights reserved.
//

#import "RFFontDetailControllerPad.h"
#import "RFSizeController.h"
#import "RFAboutController.h"
#import "RFFontInfoControllerPad.h"

@interface RFFontDetailControllerPad ()

@property (nonatomic, retain) RFFontInfoControllerPad *infoController;
@property (nonatomic, retain) UIPopoverController *infoPopover;

@end


@implementation RFFontDetailControllerPad

@synthesize toolbar = _toolbar;
@synthesize actionButtonItem = _actionButtonItem;
@synthesize textButtonItem = _textButtonItem;
@synthesize infoController = _infoController;
@synthesize infoPopover = _infoPopover;
@synthesize infoButtonItem = _infoButtonItem;

- (void)dealloc
{
    [_infoPopover release];
    [_infoController release];
    [_toolbar release];
    [_actionButtonItem release];
    [_textButtonItem release];
    [_infoButtonItem release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sizeController.slider.value = 35.0;
    self.sizeController.sizeLabel.text = @"35.0";
    self.sizeController.slider.maximumValue = 200.0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.infoPopover dismissPopoverAnimated:YES];
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
}

#pragma mark - IBAction methods

- (IBAction)showFontInfo:(id)sender
{
    if (self.infoController == nil)
    {
        self.infoController = [[[RFFontInfoControllerPad alloc] init] autorelease];
        self.infoPopover = [[[UIPopoverController alloc] initWithContentViewController:self.infoController] autorelease];
    }
    self.infoController.currentFont = self.sampleView.font;
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.infoPopover presentPopoverFromBarButtonItem:self.infoButtonItem 
                             permittedArrowDirections:UIPopoverArrowDirectionAny 
                                             animated:YES];
}

- (IBAction)action:(id)sender
{
    if (self.otherActionsSheet == nil)
    {
        NSString *screenshotOption = NSLocalizedString(@"Screenshot via e-mail", 
                                                       @"'Screenshot' entry of the action menu in the detail screen");
        NSString *copyOption = NSLocalizedString(@"Copy name", 
                                                 @"'Copy' entry of the action menu in the detail screen");
        NSString *cancelButtonText = NSLocalizedString(@"Cancel", 
                                                       @"'Cancel' button in action menus");
        
        self.otherActionsSheet = [[[UIActionSheet alloc] initWithTitle:@""
                                                              delegate:self 
                                                     cancelButtonTitle:cancelButtonText
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:screenshotOption, copyOption, nil] autorelease];
    }
    [self showActionSheet];
}

#pragma mark - Overridden methods

- (void)showActionSheet
{
    [self.infoPopover dismissPopoverAnimated:YES];
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet showFromBarButtonItem:self.actionButtonItem 
                                         animated:YES];
}

- (void)showTextsSheet
{
    [self.infoPopover dismissPopoverAnimated:YES];
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.textsActionSheet showFromBarButtonItem:self.textButtonItem 
                                        animated:YES];
}

- (IBAction)clear:(id)sender
{
    [self.infoPopover dismissPopoverAnimated:YES];
    [self.textsActionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.otherActionsSheet dismissWithClickedButtonIndex:-1 animated:YES];
    [self.sampleView becomeFirstResponder];
    self.sampleView.text = @"";
}

#pragma mark - NSNotification handler methods

- (void)shrinkTextView:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSValue *keyboardFrameValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect bounds = [keyboardFrameValue CGRectValue];
    bounds = [self.view convertRect:bounds fromView:self.view.window];
    CGFloat origin = self.sampleView.frame.origin.y;
    CGSize size = CGSizeMake(self.sampleView.frame.size.width, 
                             self.sampleView.frame.size.height - bounds.size.height);
    [UIView animateWithDuration:0.35
                     animations:^{
                         self.sampleView.frame = CGRectMake(0.0, 
                                                            origin,
                                                            size.width, 
                                                            size.height);
                     }];
}

- (void)expandTextView:(NSNotification *)notification
{
    CGFloat origin = self.sampleView.frame.origin.y;
    CGSize size = CGSizeMake(self.sampleView.frame.size.width, 
                             self.view.frame.size.height - origin);
    [UIView animateWithDuration:0.35
                     animations:^{
                         self.sampleView.frame = CGRectMake(0.0, 
                                                            origin, 
                                                            size.width, 
                                                            self.view.frame.size.height - origin);
                     }];
}

@end
