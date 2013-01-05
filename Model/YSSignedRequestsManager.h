//
//  YSSignedRequestsManager.h
//  PriceSearch
//
//  Created by Shingai Yoshimi on 1/5/13.
//  Copyright (c) 2013 Shingai Yoshimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSignedRequestsManager : NSObject

+ (NSURL*)requestURL:(NSString*)ItemId;

@end
