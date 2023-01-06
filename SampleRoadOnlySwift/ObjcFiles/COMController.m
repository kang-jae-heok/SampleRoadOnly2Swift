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

+ (void) sendRequest:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector :(BOOL)isMasking {
    [self addMaskingView];
    
    [self sendRequest:url :params :sender :selector];
}

+ (void) sendRequest:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    
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


+ (void)sendRequestGet:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
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

+ (void)removeMaskingView {
    UIWindow *window =  [[[UIApplication sharedApplication] delegate] window];
    
    for (UIView *v in [window subviews]) {
        if (v.tag == 99) {
            [v removeFromSuperview];
        }
    }

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

+ (void)sendRequestNcloud:(NSString*)url :(NSDictionary*)params :(id)sender :(SEL)selector {
    
    
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
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setValue:@"pigmldt25l" forHTTPHeaderField:@"X-NCP-APIGW-API-KEY-ID"];
    [request setValue:@"qFtYI0FzrXFS1Muh50cscBJCf1D424bM1fnT2Bi1" forHTTPHeaderField:@"X-NCP-APIGW-API-KEY"];

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
