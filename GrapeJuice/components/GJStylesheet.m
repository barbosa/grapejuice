//
//  GJStylesheet.m
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJStylesheet.h"

#import "GJStyle.h"

#import "ESCssParser.h"

@interface GJStylesheet ()

@property (nonatomic, strong) NSMutableDictionary* computedStylesheet;

@end

@implementation GJStylesheet

+( GJStylesheet* )stylesheetFromUrl:( NSURL* )url
{
    GJStylesheet* stylesheet = [GJStylesheet new];
    [stylesheet addStylesheetFromUrl: url];
    return stylesheet;
}

+( GJStylesheet* )stylesheetFromUrls:( NSArray* )urls
{
    GJStylesheet* stylesheet = [GJStylesheet new];
    for ( NSURL* url in urls )
    {
        [stylesheet addStylesheetFromUrl: url];
    }
    return stylesheet;
}

-( void )addStylesheet:( NSDictionary* )dictionary
{
    if ( !self.computedStylesheet )
        self.computedStylesheet = [NSMutableDictionary dictionary];
    
    [self.computedStylesheet addEntriesFromDictionary: dictionary];
}

-( void )addStylesheetFromUrl:( NSURL* )url
{
    NSString* cssString = [NSString stringWithContentsOfURL: url
                                                   encoding: NSUTF8StringEncoding
                                                      error: nil];
    
    ESCssParser* parser = [[ESCssParser alloc] init];
    NSDictionary* styleSheet = [parser parseText: cssString];
    NSLog(@"styleSheet: %@", styleSheet);
    [self addStylesheet: styleSheet];
}

-( GJStyle* )computedStyleForTag:( NSString* )tag classes:( NSArray* )classes
{
    NSMutableDictionary* computedStyleDictionary = [NSMutableDictionary dictionaryWithDictionary: [self computedStylesForTag: tag]];
    [computedStyleDictionary addEntriesFromDictionary: [self computedStylesForClasses: classes]];
    
    return [GJStyle styleFromDictionary: computedStyleDictionary];
}


-( NSDictionary* )computedStylesForClasses:( NSArray* )classes
{
    NSMutableDictionary* computed = [NSMutableDictionary dictionary];
    
    for ( NSString* class in classes )
    {
        NSDictionary* classStyles = self.computedStylesheet[class];
        [computed addEntriesFromDictionary: [self normalizedStylesFromDictionary: classStyles]];
    }
    
    return computed;
}

-( NSDictionary* )computedStylesForTag:( NSString* )tag
{
    NSMutableDictionary* computed = [NSMutableDictionary dictionary];
    
    NSDictionary* catchAll = self.computedStylesheet[@"*"];
    [computed addEntriesFromDictionary: [self normalizedStylesFromDictionary: catchAll]];
    
    NSDictionary* tagStyles = self.computedStylesheet[tag];
    [computed addEntriesFromDictionary: [self normalizedStylesFromDictionary: tagStyles]];
    
    return computed;
}

-( NSDictionary* )normalizedStylesFromDictionary:( NSDictionary* )dict
{
    dict = [self expandedStylesFromDictionary: dict];
    NSMutableDictionary* normalizedDict = [NSMutableDictionary dictionaryWithDictionary: dict];

    for ( NSString* key in [dict allKeys] )
    {
        NSString* value = dict[key];
        value = [value stringByReplacingOccurrencesOfString: @"px" withString: @""];

        if ( [value rangeOfString: @"color"].location == NSNotFound )
            normalizedDict[key] = @([value floatValue]);
    }

    return normalizedDict;
}

-( NSDictionary* )expandedStylesFromDictionary:( NSDictionary* )dict
{
    NSMutableDictionary* expandedDict = [NSMutableDictionary dictionaryWithDictionary: dict];

    NSArray* expandableKeys = @[@"border", @"margin", @"padding"];
    NSArray* directionKeys = @[@"top", @"right", @"bottom", @"left"];

    for ( NSString* key in expandableKeys )
    {
        [expandedDict removeObjectForKey: key];

        NSString* value = dict[key];
        if ( [value length] )
        {
            NSArray* components = [value componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ( [components count] > 1 )
            {
                for ( NSUInteger i = 0; i < [components count]; i++ )
                {
                    NSString* expandedKey = [NSString stringWithFormat:@"%@-%@", key, directionKeys[i]];
                    if ( !expandedDict[expandedKey] )
                        expandedDict[expandedKey] = components[i];
                }
            }
            else
            {
                for ( NSUInteger i = 0; i < [directionKeys count]; i++ )
                {
                    NSString* expandedKey = [NSString stringWithFormat:@"%@-%@", key, directionKeys[i]];
                    if ( !expandedDict[expandedKey] )
                        expandedDict[expandedKey] = components[0];
                }
            }
        }
    }

    return expandedDict;
}

@end
