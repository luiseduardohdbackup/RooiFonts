//
//  UIFont+RooiFonts.m
//  RooiFonts
//
//  Created by Adrian on 6/21/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import "UIFont+RooiFonts.h"

@implementation UIFont (RooiFonts)

+ (NSString *)fontList
{
    NSMutableString *fonts = [NSMutableString string];
    NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *familyName in familyNames)
    {
        [fonts appendFormat:@"Family %@: \n", familyName];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for (NSString *fontName in fontNames)
        {
            [fonts appendFormat:@"%@ \n", fontName];
        }
        [fonts appendString:@"\n"];
    }
    return fonts;
}

@end
