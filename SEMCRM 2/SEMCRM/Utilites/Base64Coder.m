// Copyright 2009, Sebastian Stenzel, sebastianstenzel.de
// All rights reserved.
// 
// This software is derived from the Base64Coder by Christian d'Heureuse in terms of the Apache License.
// Copyright 2003-2009 Christian d'Heureuse, Inventec Informatik AG, Zurich, Switzerland
// www.source-code.biz, www.inventec.ch/chdh
//
// This code can be used, copied or modified for any purpose according to the
// simplified BSD Licence (http://opensource.org/licenses/bsd-license.php) as
// long as you retain this copyright notice and reproduce it in binary form.

#import "Base64Coder.h"

static unsigned char encodingTable[64] = {
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
	'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
	'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
	'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};
static unsigned char decodingTable[128];

@implementation Base64Coder

#pragma mark -
#pragma mark encoding/decoding strings

/**
 Encodes a NSString to a BASE64 encoded string.
 If no character encoding is passed, UTF8 is assumed.
 */
+ (NSString*) encodeString:(NSString*)string withEncodingOrZero:(NSStringEncoding)encoding{
	if(encoding == 0)
		encoding = NSUTF8StringEncoding;
	return [Base64Coder encodeData:[string dataUsingEncoding:encoding]];
}

/**
 Decodes a BASE64 encoded string.
 If no character encoding is passed, UTF8 is assumed.
 */
+ (NSString*) decodeString:(NSString*)string withEncodingOrZero:(NSStringEncoding)encoding{
	NSString* result = nil;
	@try {
		if(encoding == 0)
			encoding = NSUTF8StringEncoding;
		result = [[NSString alloc] initWithData:[Base64Coder decodeData:string] encoding:encoding];
	}
	@catch (NSException* e) {
		if([e.name isEqualToString:@"invalid base64 data"])
			@throw;
	}
	return result;
}

#pragma mark -
#pragma mark encoding/decoding data

/**
 Generates an BASE64 encoded string from the given data.
 */
+ (NSString*) encodeData:(NSData*)data {
	int length = [data length];
	int oDataLen = (length*4+2)/3;	   // output length without padding
	int oLen = ((length+2)/3)*4;		 // output length including padding
	const unsigned char* input = [data bytes];
//	char output[oLen+1];	//+1 byte for null termination
    char *output = malloc(oLen+1);
	int ip = 0;
	int op = 0;
	while (ip < length) {
		int i0 = input[ip++];
		int i1 = ip < length ? input[ip++] : 0;
		int i2 = ip < length ? input[ip++] : 0;
		int o0 = i0 >> 2;
		int o1 = ((i0 &   3) << 4) | (i1 >> 4);
		int o2 = ((i1 & 0xf) << 2) | (i2 >> 6);
		int o3 = i2 & 0x3F;
		output[op++] = encodingTable[o0];
		output[op++] = encodingTable[o1];
		output[op] = op < oDataLen ? encodingTable[o2] : '='; op++;
		output[op] = op < oDataLen ? encodingTable[o3] : '='; op++;
	}
	output[op] = 0;
	NSString *str = [NSString stringWithCString:output encoding:NSASCIIStringEncoding];
    free(output);
    return str;
}

/**
 Decodes the BASE64 encoded string to a NSData object.
 */
+ (NSData*) decodeData:(NSString*)string {
	string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];	//removing line breaks from base64 blocks
	
	int iLen = [string length];
	if (iLen%4 != 0) @throw [NSException exceptionWithName:@"invalid base64 data"
													reason:@"length of base64 encoded string not a multiple of 4."
												  userInfo:nil];
	while (iLen > 0 && [string characterAtIndex:(iLen-1)] == '=') iLen--;
	int oLen = (iLen*3) / 4;
	
	const unsigned char* input = [[string dataUsingEncoding:NSASCIIStringEncoding] bytes]; //valid base64 strings only contain ascii chars
	if(input == nil)
		@throw [NSException exceptionWithName:@"invalid base64 data"
									   reason:@"illegal character in base64 encoded data."
									 userInfo:nil];
	char output[oLen+1];
	int ip = 0;
	int op = 0;
	while (ip < iLen) {
		int i0 = input[ip++];
		int i1 = input[ip++];
		int i2 = ip < iLen ? input[ip++] : 'A';
		int i3 = ip < iLen ? input[ip++] : 'A';
		if (i0 > 127 || i1 > 127 || i2 > 127 || i3 > 127)
			@throw [NSException exceptionWithName:@"invalid base64 data"
										   reason:@"illegal character in base64 encoded data."
										 userInfo:nil];
		int b0 = decodingTable[i0];
		int b1 = decodingTable[i1];
		int b2 = decodingTable[i2];
		int b3 = decodingTable[i3];
		if (b0 < 0 || b1 < 0 || b2 < 0 || b3 < 0)
			@throw [NSException exceptionWithName:@"invalid base64 data"
										   reason:@"illegal character in base64 encoded data."
										 userInfo:nil];
		int o0 = (b0<<2) | (b1>>4);
		int o1 = ((b1 & 0xf)<<4) | (b2>>2);
		int o2 = ((b2 & 3)<<6) | b3;
		output[op++] = o0;
		if (op<oLen) output[op++] = o1;
		if (op<oLen) output[op++] = o2;
	}
	output[op] = 0;
	return [NSData dataWithBytes:output length:oLen];
}

#pragma mark -
#pragma mark static initialization

+ (void) initialize {
	for(int i=0;i<128;i++) decodingTable[i] = -1;
	for(int i=0;i<64;i++) decodingTable[encodingTable[i]] = i;
}

@end