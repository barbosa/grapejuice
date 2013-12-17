//
//  GJBodyView.m
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import "GJBodyView.h"

// grapejuice
#import "GJDivView.h"

@interface GJBodyView()
{
    UIScrollView* bodyContentView;
    GJDivView* mappedContentView;
}
@end

@implementation GJBodyView

#pragma mark - Ctor & Dtor

-( id )initWithFrame:( CGRect )frame
{
    self = [super initWithFrame: frame];
    if( self )
    {
        if( ![self buildGJBodyView] )
            return nil;
    }
    return self;
}

-( id )initWithCoder:( NSCoder* )aDecoder
{
    self = [super initWithCoder: aDecoder];
    if( self )
    {
        if( ![self buildGJBodyView] )
            return nil;
    }
    return self;
}

-( BOOL )buildGJBodyView
{
    bodyContentView = [[UIScrollView alloc] init];
    if( !bodyContentView )
        return  NO;
    
    // We MUST call super here since we override addSubview
    [super addSubview: bodyContentView];
    
    mappedContentView = [[GJDivView alloc] init];
    if( !mappedContentView )
        return NO;

    [bodyContentView addSubview: mappedContentView];
    
    self.autoresizingMask = UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;;
    
    bodyContentView.frame = self.bounds;
    bodyContentView.autoresizingMask = UIViewAutoresizingNone | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    bodyContentView.backgroundColor = [UIColor redColor];
    
    return YES;
}

#pragma mark - UIView Overriding

-( void )layoutSubviews
{
    [mappedContentView layoutSubviews];
    
    bodyContentView.contentSize = mappedContentView.frame.size;
    [bodyContentView layoutSubviews];
}

-( void )addSubview:( UIView* )view
{
    [mappedContentView addSubview: view];
}

@end


















































