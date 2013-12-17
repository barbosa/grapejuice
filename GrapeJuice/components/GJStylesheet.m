//
//  GJStylesheet.m
//  GrapeJuice
//
//  Created by Bruno Torres on 12/16/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJStylesheet.h"

#import "ESCssParser.h"

@interface GJStylesheet ()

@property (nonatomic, strong) NSMutableDictionary* computedStylesheet;

@end

@implementation GJStylesheet

-( void )addStylesheet:( NSDictionary* )dictionary
{
    if ( !self.computedStylesheet )
        self.computedStylesheet = [NSMutableDictionary dictionary];
    
    [self.computedStylesheet addEntriesFromDictionary: dictionary];
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



@end
