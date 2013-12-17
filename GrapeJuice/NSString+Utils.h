//
//  NSString+Utils.h
//  GrapeJuice
//
//  Created by Daniel Alves on 17/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString( Utils )

-( CGSize )sizeNeededWithFont:( UIFont* )font
                       insets:( UIEdgeInsets )textInsets
                     maxWidth:( CGFloat )maxWidth
                lineBreakMode:( NSLineBreakMode )lineBreakMode
             andTextAlignment:( NSTextAlignment )textAlignment;

@end
