//
//  TwitterReverseOAuthResponse.m
//  athlete
//
//  Created by kb on 2012.11.08.
//  Copyright (c) 2012 kb. All rights reserved.
//

#import "TwitterReverseOAuthResponse.h"

@implementation TwitterReverseOAuthResponse

+ (TwitterReverseOAuthResponse*)oauthResponseForResponseData:(NSData*)responseData
{
	if (responseData)
	{
		NSString* response = [[NSString alloc] initWithData:responseData
												   encoding:NSUTF8StringEncoding];

		NSArray* parts = [response componentsSeparatedByString:@"&"];
		TwitterReverseOAuthResponse* oauthResponse = [[TwitterReverseOAuthResponse alloc] init];
		for (NSString* part in parts)
		{
			NSArray* keyValue = [part componentsSeparatedByString:@"="];
			NSString* key = [keyValue objectAtIndex:0];
			if (key)
				[oauthResponse setValue:[keyValue lastObject] forKey:key];
		}

		return oauthResponse;
	}

	return nil;
}

#pragma mark -
#pragma mark KVC

+ (NSSet*)ignoredObjects {
	static NSSet* _ignoredObjects;
	// KVC: define a set of keys that are known but that we aren't interested in. Ignore them.
	if (!_ignoredObjects)	_ignoredObjects = [NSSet setWithObject:@"oauth_callback_confirmed"];
	return _ignoredObjects;
}

/**
 * We specify a set of keys that are known to be returned from OAuth responses, but that we are
 * not interested in.
 * In case of any other keys, we log them since they may indicate changes in API that we are not
 * prepared to deal with, but we continue nevertheless.
 * This is only relevant for the Twitter request/authorize convenience methods that do HTTP
 * calls and parse responses.
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
#if DEBUG
	// ... but if we got a new key that is not known, log it.
	if (![TwitterReverseOAuthResponse.ignoredObjects containsObject:key])
		NSLog(@"Got unknown key from provider response. Key=\"%@\", value:[%@]", key, value);
#endif
}

@end
