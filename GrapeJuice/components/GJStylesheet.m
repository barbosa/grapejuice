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
        [computed addEntriesFromDictionary: classStyles];
    }
    
    return computed;
}

-( NSDictionary* )computedStylesForTag:( NSString* )tag
{
    NSMutableDictionary* computed = [NSMutableDictionary dictionary];
    
    NSDictionary* catchAll = self.computedStylesheet[@"*"];
    [computed addEntriesFromDictionary: catchAll];
    
    NSDictionary* tagStyles = self.computedStylesheet[tag];
    [computed addEntriesFromDictionary: tagStyles];
    
    return computed;
}

@end
