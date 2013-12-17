//
//  GJTextView.h
//  GrapeJuice
//
//  Created by Daniel Alves on 16/12/13.
//  Copyright (c) 2013 Globo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJStyle;

@interface GJTextView : UILabel

@property( nonatomic, readwrite, strong )GJStyle* style;

@end
