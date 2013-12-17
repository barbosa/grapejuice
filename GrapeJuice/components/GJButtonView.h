//
//  GJButtonView.h
//  GrapeJuice
//
//  Created by emerson on 12/17/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJLayout;

@interface GJButtonView : UIView
{
    @protected
        UIButton* mappedButton;
}

@property( nonatomic, readwrite, strong )GJLayout* layout;

-( void )consumesChildHtmlNode:( OGElement* )element;

@end
