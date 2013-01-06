AmzonProductAdvertisingAPISample
================================

Example REST Requests for Product Advertising API


TRY IT OUT

1. Go to https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html and get your AWS Access Key ID and Secret Access Key.
2. Go to https://affiliate.amazon.co.jp/ and get your Associate Tag.
3. Enter your AWS Access Key ID , Secret Access Key and Associate Tag on AmzonProductAdvertisingAPISample/Model/YSSignedRequestsManager.m file.

YSSignedRequestsManager.m file generate and return the request URL.
You can get the URL with this method.
+ (NSURL*)requestURL:(NSString*)ItemId;


Please use http://yoshiminu.tumblr.com/post/39763242929/amazon-api-isbn as a reference.
