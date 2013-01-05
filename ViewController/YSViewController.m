//
//  YSViewController.m
//  AmzonProductAdvertisingAPISample
//
//  Created by Shingai Yoshimi on 12/28/12.
//  Copyright (c) 2012 Shingai Yoshimi. All rights reserved.
//

#import "YSViewController.h"
#import "XMLReader.h"
#import "YSSignedRequestsManager.h"


@interface YSViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YSViewController


//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//
#pragma mark -- Initialize --
//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//
#pragma mark -- View lifecycle --
//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 290)/2, self.view.frame.size.height/2 - 80, 290, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"ISBNコードを入力してください";
    _textField.textColor = [UIColor blueColor];
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
    
    UIButton *recognizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [recognizeButton setFrame:CGRectMake((self.view.frame.size.width - 250)/2, self.view.frame.size.height/2, 250, 50)];
    [recognizeButton setTitle:@"Search" forState:UIControlStateNormal];
    [recognizeButton addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recognizeButton];
}


//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//
#pragma mark -- Send Request --
//★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★─☆｡oﾟ｡★//

- (void)sendRequest {
    
    NSURL *requestURL = [YSSignedRequestsManager requestURL:_textField.text];
    NSURLRequest *request=[NSURLRequest requestWithURL:requestURL];
    NSURLConnection *connection=[[NSURLConnection alloc]
                                    initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"start loading");
    }
    
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData {
    NSError *error = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:receivedData error:&error];
    
    NSLog(@"%@", xmlDictionary);
}


- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error localizedDescription]);
}

@end
