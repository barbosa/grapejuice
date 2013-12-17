//
//  UIColorUtils.m
//  Components
//
//  Created by Daniel L. Alves on 5/16/11.
//  Copyright 2011 Jack & Towers. All rights reserved.
//

#import "UIColorUtils.h"

// jacktowers
//#import "NSDictionary+Utils.h"

#pragma mark - Defines

#define RED_COMPONENT_INDEX		0
#define GREEN_COMPONENT_INDEX	1
#define BLUE_COMPONENT_INDEX	2
#define ALPHA_COMPONENT_INDEX	3

#define WA_WHITE_COMPONENT_INDEX	0
#define WA_ALPHA_COMPONENT_INDEX	1

NSString* const COLOR_DICT_COMPONENT_KEY_RED    = @"r";
NSString* const COLOR_DICT_COMPONENT_KEY_GREEN  = @"g";
NSString* const COLOR_DICT_COMPONENT_KEY_BLUE   = @"b";
NSString* const COLOR_DICT_COMPONENT_KEY_ALPHA  = @"a";

#pragma mark - Implementation

@implementation UIColor( UIColorUtils )

//+( UIColor* )colorFromDictionary:( NSDictionary* )colorDict
//{
//    uint8_t r = [[colorDict numberForKey: COLOR_DICT_COMPONENT_KEY_RED] unsignedCharValue];
//    uint8_t g = [[colorDict numberForKey: COLOR_DICT_COMPONENT_KEY_GREEN] unsignedCharValue];
//    uint8_t b = [[colorDict numberForKey: COLOR_DICT_COMPONENT_KEY_BLUE] unsignedCharValue];
//    uint8_t a = [[colorDict numberForKey: COLOR_DICT_COMPONENT_KEY_ALPHA] unsignedCharValue];
//    return [self colorWithByteRed: r byteGreen: g byteBlue: b byteAlpha: a];
//}

+( UIColor* )colorFromRGBHex:( uint32_t )rgb
{
	return [self colorFromARGBHex: rgb | 0xFF000000];
}

+( UIColor* )colorFromRGBAHex:( uint32_t )rgba
{
	uint8_t r = ( rgba & 0xFF000000 ) >> 24;
	uint8_t g = ( rgba & 0x00FF0000 ) >> 16;
	uint8_t b = ( rgba & 0x0000FF00 ) >>  8;
	uint8_t a = ( rgba & 0x000000FF );
	
	return [self colorWithByteRed: r byteGreen: g byteBlue: b byteAlpha: a];
}

+( UIColor* )colorFromARGBHex:( uint32_t )argb
{
	uint8_t a = ( argb & 0xFF000000 ) >> 24;
	uint8_t r = ( argb & 0x00FF0000 ) >> 16;
	uint8_t g = ( argb & 0x0000FF00 ) >>  8;
	uint8_t b = ( argb & 0x000000FF );
	
	return [self colorWithByteRed: r byteGreen: g byteBlue: b byteAlpha: a];
}

+( UIColor* )colorWithARGBHexString:( NSString* )str
{
#define HEX_STR_MAX_CHARS 8
	
	if( !str || [str length] == 0 )
		return nil;
	
	uint8_t nHexChars = 0;
	char onlyValidHexChars[ HEX_STR_MAX_CHARS ];
	
	const char* temp = [[str stringByReplacingOccurrencesOfString: @"0x" withString: @""] UTF8String];
	while( (( *temp ) != 0 ) && ( nHexChars < HEX_STR_MAX_CHARS ) )
	{
		if( [UIColor isValidHexChar: *temp] )
			onlyValidHexChars[ nHexChars++ ] = *temp;
		
		++temp;
	}
	
	if( ( nHexChars & 1 ) != 0 )
		return nil;
	
	uint32_t argb = 0xFFFFFFFF;
	uint8_t* iterator = ( uint8_t* )&argb;
	
	while( nHexChars > 0 )
	{
		( *iterator ) = ( [UIColor hexCharToByte: onlyValidHexChars[nHexChars - 2]] * 16 ) + [UIColor hexCharToByte: onlyValidHexChars[nHexChars - 1]];
		++iterator;
		
		nHexChars -= 2;
	}
	
	return [UIColor colorFromARGBHex: argb];
	
#undef HEX_STR_MAX_CHARS
}

+( UIColor* )colorWithByteRed:( uint8_t )r byteGreen:( uint8_t )g byteBlue:( uint8_t )b byteAlpha:( uint8_t )a
{
    return [UIColor colorWithRed: ( float )r / 255.0f  green: ( float )g / 255.0f blue: ( float )b / 255.0f alpha: ( float )a / 255.0f];    
}

#pragma mark - Helpers

+( BOOL )isValidHexChar:( char )c
{
	return ( c >= '0' && c <= '9' ) || ( c >= 'A' && c <= 'F' ) || ( c >= 'a' && c <= 'f' );
}

+( uint8_t )hexCharToByte:( char )c
{
	if( c >= '0' && c <= '9' )
		return ( uint8_t )( c - '0' );
	else if( c >= 'A' && c <= 'F' )
		return ( uint8_t )( 10 + c - 'A' );
	else if( c >= 'a' && c <= 'f' )
		return ( uint8_t )( 10 + c - 'a' );
	
	@throw [NSException exceptionWithName: NSInvalidArgumentException 
								   reason: [NSString stringWithFormat: @"Character %c is not a valid hex char", c] 
								 userInfo: nil];
}

#pragma mark - UIColor Components Getters

-( CGFloat )getComponent:( uint8_t ) index
{
	CGColorRef temp = self.CGColor;
	NSUInteger nComponents = CGColorGetNumberOfComponents( temp );
	
	// White ; Alpha
	if( nComponents == 2 )
	{
		return CGColorGetComponents( self.CGColor )[ ( index == ALPHA_COMPONENT_INDEX ? WA_ALPHA_COMPONENT_INDEX : WA_WHITE_COMPONENT_INDEX ) ];
	}
	// RGBA
	else
	{
		return CGColorGetComponents( self.CGColor )[ index ];
	}
}

-( CGFloat )red
{
	return [self getComponent: RED_COMPONENT_INDEX];
}

-( CGFloat )green
{
	return [self getComponent: GREEN_COMPONENT_INDEX];
}

-( CGFloat )blue
{
	return [self getComponent: BLUE_COMPONENT_INDEX];
}

-( CGFloat )alpha
{
	return [self getComponent: ALPHA_COMPONENT_INDEX];
}

-( uint8_t )byteRed
{
	return ( uint8_t )( 255.0 * [self red] );
}

-( uint8_t )byteGreen
{
	return ( uint8_t )( 255.0 * [self green] );
}

-( uint8_t )byteBlue
{
	return ( uint8_t )( 255.0 * [self blue] );
}

-( uint8_t )byteAlpha
{
	return ( uint8_t )( 255.0 * [self alpha] );
}

@end
