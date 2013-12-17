//
//  GJButtonView.m
//  GrapeJuice
//
//  Created by emerson on 12/17/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJButtonView.h"

@implementation GJButtonView

- (void) consumesChildHtmlNode: (OGElement*) element
{
    OGElement* child = element.children.firstObject;
    if ([child isKindOfClass: [OGText class]])
    {
        OGText* textNode = ( OGText* )child;
        NSString* actualText = [textNode.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if( actualText.length > 0 )
        {
            [self setTitle: actualText forState: UIControlStateNormal];
            [self setTitleColor: [UIColor lightTextColor] forState: UIControlStateNormal];
            self.backgroundColor = [UIColor darkTextColor];
            self.frame = CGRectMake(0.0, 0.0, 100.0, 20.0);
        }
    }
}

@end
