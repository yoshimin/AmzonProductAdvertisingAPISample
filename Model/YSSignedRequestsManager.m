//
//  YSSignedRequestsManager.m
//  PriceSearch
//
//  Created by Shingai Yoshimi on 1/5/13.
//  Copyright (c) 2013 Shingai Yoshimi. All rights reserved.
//

#import "YSSignedRequestsManager.h"
#import "NSString+URLEncode.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonHMAC.h>

static NSString *accessKeyID = @"[PutYourAccessKeyIdHere]";
static NSString *associateTag = @"[PutYourassociateTagHere]";
static NSString *secretAccessKey = @"[PutYoursecretAccessKeyHere]";


@implementation YSSignedRequestsManager

+ (NSURL*)requestURL:(NSString*)ItemId {
    
    //Get the time stamp to enter into requestURL
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *timeStamp = [formatter stringFromDate:[NSDate date]];
    
    //Enter the time stamp into the parameters
    //Sort the parameter/value pairs by byte value (not alphabetically, lowercase parameters will be listed after uppercase ones).
    NSString *parameters = [NSString stringWithFormat:@"AWSAccessKeyId=%@&AssociateTag=%@&IdType=ISBN&ItemId=%@&Operation=ItemLookup&ResponseGroup=OfferSummary&SearchIndex=Books&Service=AWSECommerceService&Timestamp=%@&Version=2011-08-01", accessKeyID, associateTag, ItemId, timeStamp];
    
    //URL encode the request's comma (,) and colon (:) characters
    NSString *encodedParameters = [parameters minimalUrlEncode];
    
    //Prepend the following three lines(with line breaks) before the canonical string
    // GET
    // necs.amazonaws.jp
    // xml
    NSString *head = @"GET\necs.amazonaws.jp\n/onca/xml";
    NSString *stringToSign = [NSString stringWithFormat:@"%@\n%@", head, encodedParameters];
    
    //Calculate an RFC 2104-compliant HMAC with the SHA256 hash algorithm using the string above with Secret Access Key
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    const char *cKey = [secretAccessKey cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [stringToSign cStringUsingEncoding:NSASCIIStringEncoding];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //base64URL encode the calculated result above
    NSData *HMAC = [[NSData alloc]initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *base64EncodedString = [HMAC base64EncodedString];
    
    //URL encode the plus (+) and equal (=) characters in the signature
    NSString *hash = [base64EncodedString urlEncode];
    
    //Add the URL encoded signature to your request, and the result is a properly-formatted signed request
    NSString *requestURLString = [NSString stringWithFormat:@"http://ecs.amazonaws.jp/onca/xml?%@&Signature=%@", encodedParameters, hash];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    return requestURL;
}

@end
