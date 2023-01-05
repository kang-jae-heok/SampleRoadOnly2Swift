//
//  COMController.m
//
//

#import "COMController.h"
#define SERVER_URL @"http://110.165.17.124/sampleroad/"

@implementation COMController

@synthesize maskView;

-(id)initWithData {
    
    return self;
}

+ (void) sendRequest :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector :(BOOL)isMasking {
    [self addMaskingView];
    
    [self sendRequest:url :params :sender :selector];
}

+ (void) sendRequest :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    
    NSString *requestURL;
    
    NSRange range;
    range = [url rangeOfString:@"http"];
    
    if (range.location != NSNotFound) {
        requestURL = [NSString stringWithFormat:@"%@",url];
    }else {
        requestURL = [NSString stringWithFormat:@"%@%@.php",SERVER_URL,url];
    }
    
    NSLog(@"request url : %@", requestURL);
    NSLog(@"params  :  %@", params);

    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    // 임시 변수 선언
    NSMutableArray *parts = [NSMutableArray array];
    
    if(params)
    {
    
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in params) {
            
            value = [params objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
           
            
            NSLog(@"part :   %@",part);
        }
        // 값들을 &로 연결하여 Body에 사용
       
    }
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    NSString *postString = [parts componentsJoinedByString:@"&"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:30.0];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"aapplication/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" forHTTPHeaderField:@"Authorization"];
    
    
    [request setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_token"] forHTTPHeaderField:@"Authorization-Customer"];
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
    
    
    NSLog(@"request send complete....");
}

+ (void)sendRequestWithMethod:(NSString *)method :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    
    NSString *requestURL;
    
    NSRange range;
    range = [url rangeOfString:@"http"];
    
    if (range.location != NSNotFound) {
        requestURL = [NSString stringWithFormat:@"%@",url];
    }else {
        requestURL = [NSString stringWithFormat:@"%@%@.php",SERVER_URL,url];
    }
    
    NSLog(@"request url : %@", requestURL);
    NSLog(@"params  :  %@", params);

    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    // 임시 변수 선언
    NSMutableArray *parts = [NSMutableArray array];
    
    if(params)
    {
    
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in params) {
            
            value = [params objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
           
            
            NSLog(@"part :   %@",part);
        }
        // 값들을 &로 연결하여 Body에 사용
       
    }
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:method];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    NSString *postString = [parts componentsJoinedByString:@"&"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:30.0];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"aapplication/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" forHTTPHeaderField:@"Authorization"];
    [request setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_token"] forHTTPHeaderField:@"Authorization-Customer"];
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
    
    
    NSLog(@"request send complete....");
}

+ (void)sendRequestApi :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    
    NSString *requestURL = [NSString stringWithFormat:@"%@",url];
    
    NSLog(@"request url : %@", requestURL);
    NSLog(@"params  :  %@", params);

    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    // 임시 변수 선언
    NSMutableArray *parts = [NSMutableArray array];
    
    if(params)
    {
    
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in params) {
            
            value = [params objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
            
            NSLog(@"part :   %@",part);
        }
        // 값들을 &로 연결하여 Body에 사용
       
    }
    
    NSData *plainData = [@"RBRwF4F1WGhfEnSurL8C83yZNawNlk7RkRxWwjUa" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedText = [plainData base64EncodedStringWithOptions:0];
    
    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]); // returned as a double
    long digits = (long)time; // this is the first 10 digits
    int decimalDigits = (int)(fmod(time, 1) * 1000); // this will get the 3 missing digits
    long timestamp = (digits * 1000) + decimalDigits;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"content-type"];
    [request setValue:[NSString stringWithFormat:@"%ld",timestamp] forHTTPHeaderField:@"x-ncp-apigw-timestamp"];
    [request setValue:@"cfImg0cxWuPnXaPOQeDF" forHTTPHeaderField:@"x-ncp-iam-access-key"];
    [request setValue:encodedText forHTTPHeaderField:@"x-ncp-apigw-signature-v2"];
   
    
    NSString *postString = [parts componentsJoinedByString:@"&"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:30.0];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
    
    
    NSLog(@"request send complete....");
}

+ (void)sendRequestGet :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    NSString *requestURL;
    
    NSRange range;
    range = [url rangeOfString:@"http"];
    
    if (range.location != NSNotFound) {
        requestURL = [NSString stringWithFormat:@"%@",url];
    }else {
        requestURL = [NSString stringWithFormat:@"%@%@.php",SERVER_URL,url];
    }
    
    NSLog(@"request url : %@", requestURL);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"GET"];
    
    NSRange range2;
    range2 = [url rangeOfString:@"api.iamport.kr/certifications/"];
    if (range2.location != NSNotFound) {
        NSLog(@"certifications certifications certifications certifications certifications");
        NSLog(@"params : %@",params);
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:[params valueForKey:@"access_token"] forHTTPHeaderField:@"Authorization"];
    }else {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setValue:@"aapplication/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" forHTTPHeaderField:@"Authorization"];
        [request setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_token"] forHTTPHeaderField:@"Authorization-Customer"];
    }
    

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            NSLog(@"error : %@",error);
        }else if(data){

            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
    
    
    NSLog(@"request send complete....");
}

+ (void) sendRemoveFileRequest :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@.php",@"http://110.165.17.124/meong/",url];
//    NSLog(@"request url : %@", requestURL);
//    NSLog(@"params  :  %@", params);

    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    // 임시 변수 선언
    NSMutableArray *parts = [NSMutableArray array];
    
    if(params)
    {
    
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in params) {
            
            value = [params objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
            
            NSLog(@"part :   %@",part);
        }
        // 값들을 &로 연결하여 Body에 사용
       
    }
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    NSString *postString = [parts componentsJoinedByString:@"&"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:30.0];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){

            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
    
    
    NSLog(@"request send complete....");
}

+ (void)sendFileRequest :(NSString*)url :(NSString *)filePath :(NSString *)fileName :(id)sender :(SEL)selector {
    
    NSLog(@"fileName  :  %@\nfilePath   :   %@",fileName,filePath);
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@.php",@"http://110.165.17.124/meong/",url];
//    NSLog(@"request url : %@", requestURL);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];

 
    // set HTTP Header
    NSString *boundary = [NSString stringWithFormat:@"----WebKitFormBoundaryF1kvH5cIG9tbI2Wk"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSString *Accept_Encoding = [NSString stringWithFormat:@" gzip,deflate,sdch"];
    [request addValue:Accept_Encoding forHTTPHeaderField:@"Accept-Encoding"];
    
    NSString *Accept_Language = [NSString stringWithFormat:@" ko-KR,ko;q=0.8,en-US;q=0.6,en;q=0.4"];
    [request addValue:Accept_Language forHTTPHeaderField:@"Accept-Language"];
    
    NSString *Accept_Charset = [NSString stringWithFormat:@" windows-949,utf-8;q=0.7,*;q=0.3"];
    [request addValue:Accept_Charset forHTTPHeaderField:@"Accept-Charset"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"upload data  :  %@",data);
    // post body
    NSMutableData *body = [NSMutableData data];
    if (data) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: video/mp4\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
    
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:requestURL]];

    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
     ];

    NSLog(@"request send complete....");
}

+ (void)sendRequestMultipart :(NSString*)url :(NSDictionary*)params :(NSArray *)paramsFiles :(NSArray *)paramsNames :(id)sender :(SEL)selector {
    
    NSData *data;
    if (params) {
        data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    //NSString *reqParam = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *requestURL = [NSString stringWithFormat:@"%@%@.php",@"http://110.165.17.124/meong/",url];
//    NSLog(@"request url : %@", requestURL);
//    NSLog(@"request parameters : %@", params);
    //NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    //NSString* FileParamConstant = @"file";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    
    
    // set HTTP Header
    NSString *boundary = [NSString stringWithFormat:@"----WebKitFormBoundaryF1kvH5cIG9tbI2Wk"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSString *Accept_Encoding = [NSString stringWithFormat:@" gzip,deflate,sdch"];
    [request addValue:Accept_Encoding forHTTPHeaderField:@"Accept-Encoding"];
    
    NSString *Accept_Language = [NSString stringWithFormat:@" ko-KR,ko;q=0.8,en-US;q=0.6,en;q=0.4"];
    [request addValue:Accept_Language forHTTPHeaderField:@"Accept-Language"];
    
    NSString *Accept_Charset = [NSString stringWithFormat:@" windows-949,utf-8;q=0.7,*;q=0.3"];
    [request addValue:Accept_Charset forHTTPHeaderField:@"Accept-Charset"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    
    for (NSString *key in [params allKeys]) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";\r\n", key] dataUsingEncoding:NSUTF8StringEncoding] ];
        [body appendData:[[NSString stringWithFormat:@"\r\n"]dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",[params objectForKey:key]]dataUsingEncoding:NSUTF8StringEncoding]] ;
    }
    
    // add image data
    int idx=0;
    for (NSString *path in paramsFiles) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@\"\r\n",[paramsNames objectAtIndex:idx]] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: video/mp4\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:data];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        idx++;
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding] ];
    
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:requestURL]];

    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
     ];

    NSLog(@"request send complete....");
}

+ (void)addMaskingView {
//    FSPmobileAppDelegate *delegate = (FSPmobileAppDelegate*)[[UIApplication sharedApplication] delegate];
    //MainViewController *main = (MainViewController*)delegate.window.rootViewController;
    
    UIWindow *window =  [[[UIApplication sharedApplication] delegate] window];
    CGRect r = window.frame;

    UIView *maskView = [[UIView alloc]initWithFrame:r];
    maskView.tag = 99;

    [maskView setBackgroundColor:[UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:0.2]];
    maskView.userInteractionEnabled = NO;
    [window addSubview:maskView];
    
    UIActivityIndicatorView *spiner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [spiner setCenter:CGPointMake(maskView.frame.size.width /2, maskView.frame.size.height/2)];
    [maskView addSubview:spiner];
    [spiner startAnimating];
}

+ (void)requestUploadImage:(NSString *)url image:(UIImage *)image imageName:(NSString *)imageName :(id)sender :(SEL)selector {
    
    // make request object and set options
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"notegg";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add image data
    UIImage *imageToUpload = image;
    NSData *imageData = UIImageJPEGRepresentation(imageToUpload, 0.5);
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@.jpg\"\r\n",imageName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.php",SERVER_URL,url]]];
    NSLog(@"request url : %@", [NSString stringWithFormat:@"%@%@.php",SERVER_URL,url]);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        NSLog(@"response   %@\ndata    %@\nerror     %@",response,data,error);
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
     ];
    
    NSLog(@"request send complete....");
}

+ (void)removeMaskingView {
    UIWindow *window =  [[[UIApplication sharedApplication] delegate] window];
    
    for (UIView *v in [window subviews]) {
        if (v.tag == 99) {
            [v removeFromSuperview];
        }
    }

}

+ (void)sendPushRequest :(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    NSString *requestURL;
    
    NSRange range;
    range = [url rangeOfString:@"http"];
    
    if (range.location != NSNotFound) {
        requestURL = [NSString stringWithFormat:@"%@",url];
    }else {
        requestURL = [NSString stringWithFormat:@"%@%@.php",SERVER_URL,url];
    }
    
    NSLog(@"request url : %@", requestURL);
    NSLog(@"params  :  %@", params);

    // bodyObject의 객체가 존재할 경우 QueryString형태로 변환
    // 임시 변수 선언
    NSMutableArray *parts = [NSMutableArray array];
    
    if(params)
    {
    
        NSString *part;
        id key;
        id value;
        
        // 값을 하나하나 변환
        for(key in params) {
            
            value = [params objectForKey:key];
            part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                    [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [parts addObject:part];
            
            NSLog(@"part :   %@",part);
        }
        // 값들을 &로 연결하여 Body에 사용
       
    }
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];

    NSString *postString = [parts componentsJoinedByString:@"&"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setTimeoutInterval:30.0];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        NSLog(@"response   %@\ndata    %@\nerror     %@",response,data,error);
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){

            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }
     ];
}


+ (void)sendRequestMultipartClayFul:(NSDictionary *)param :(UIImage *)paramImage :(NSString *)paramImageName :(id)sender :(SEL)selector {
    

    NSString *requestURL = [NSString stringWithFormat:@"https://api.clayful.io/v1/images"];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM4N2NkNjVkZGUxOWExZjdkNGM0NTk2ODhlZTJkNTk1MWZkZjRlYTI5ZWQ1OWE1NTc2MjBlOTI5Y2M4OTNiZTAiLCJyb2xlIjoiY2xpZW50IiwiaWF0IjoxNjU0NTc5NzQ0LCJzdG9yZSI6IlZLS1RZTjIzVEJFUS5GOVg5R0pKQkVFNVEiLCJzdWIiOiJYUzRVRVRCOFNFVkcifQ.G1j5SEaS-sjgRf1dPTr0l7zeIPNVPKVNw2Ga49FfUG0" forHTTPHeaderField:@"Authorization"];
    
    NSString *boundary = @"----formDataBoundary";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    [param enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
    
    
    // add image data
    NSLog(@"paramImage : %@",paramImage);
    NSData *imageData = UIImageJPEGRepresentation(paramImage, 0.5);
    
    if (imageData) {
        NSLog(@"paramImageName : %@",paramImageName);
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", paramImageName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
 
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:requestURL]];

    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(error) {
            //[sender performSelector:@selector(receiveError:) withObject:error] ;
            
        }else if(data){
            //            [sender  performSelector:@selector(receiveData:) withObject:data ] ;
            [sender performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
        }else{
            NSLog(@"no data........ ");
        }

//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
     ];

    NSLog(@"request send complete....");
}


@end
