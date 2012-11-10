//
//  TwitterReverseOAuthResponse.h
//  athlete
//
//  Created by kb on 2012.11.08.
//  Copyright (c) 2012 kb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterReverseOAuthResponse : NSObject
@property (strong, nonatomic) NSString* oauth_token;
@property (strong, nonatomic) NSString* oauth_token_secret;
@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) NSString* screen_name;

+ (TwitterReverseOAuthResponse*)oauthResponseForResponseData:(NSData*)responseData;

@end
