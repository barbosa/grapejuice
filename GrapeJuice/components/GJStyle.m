//
//  GJStyle.m
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJStyle.h"

#import "UIColorUtils.h"

@implementation GJStyle

+( GJStyle* )styleFromDictionary:( NSDictionary* )dictionary
{
    GJStyle* style = [GJStyle new];

    style.backgroundColor = [self colorFromHexString: dictionary[@"background-color"]];

    style.borderColor = [self colorFromHexString: dictionary[@"border-color"]];
    style.borderRadius = [dictionary[@"border-radius"] floatValue];
    style.borderWidth = [dictionary[@"border-width"] floatValue];

    style.borderTop = [dictionary[@"border-top"] floatValue];
    style.borderRight = [dictionary[@"border-right"] floatValue];
    style.borderBottom = [dictionary[@"border-bottom"] floatValue];
    style.borderLeft = [dictionary[@"border-left"] floatValue];

    style.marginTop = [dictionary[@"margin-top"] floatValue];
    style.marginRight = [dictionary[@"margin-right"] floatValue];
    style.marginBottom = [dictionary[@"margin-bottom"] floatValue];
    style.marginLeft = [dictionary[@"margin-left"] floatValue];

    style.paddingTop = [dictionary[@"padding-top"] floatValue];
    style.paddingRight = [dictionary[@"padding-right"] floatValue];
    style.paddingBottom = [dictionary[@"padding-bottom"] floatValue];
    style.paddingLeft = [dictionary[@"padding-left"] floatValue];

    style.width = [dictionary[@"width"] floatValue];
    style.height = [dictionary[@"height"] floatValue];

    return style;
}

+( UIColor* )colorFromHexString:( NSString* )hex
{
    if ( ![hex length] )
        return nil;

    uint32_t result = 0;

    NSScanner *scanner = [NSScanner scannerWithString: hex];

    if ([hex characterAtIndex: 0] == '#' )
        [scanner setScanLocation:1];
    [scanner scanHexInt:&result];

    return [UIColor colorFromARGBHex: 0xff000000 | result];
}

@end
