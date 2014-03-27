//
//  ViewController.m
//  Graphview
//
//  Created by Ketul shah on 13/03/14.
//  Copyright (c) 2014 Clarion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:
                                                       [[NSBundle mainBundle] pathForResource:@"piechart" ofType:@"html"]]]];
    webView.scalesPageToFit=YES;
    webView.scrollView.scrollEnabled=NO;
    
	// Do any additional setup after loading the view, typically from a nib.
}
    -(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
    {
        // Creates a mutable data object for updating with binary data, like a byte array
        NSMutableData *pdfData = [NSMutableData data];
        
        // Points the pdf converter to the mutable data object and to the UIView to be converted
        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
        UIGraphicsBeginPDFPage();
        CGContextRef pdfContext = UIGraphicsGetCurrentContext();
        
        
        // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
        
        [aView.layer renderInContext:pdfContext];
        
        // remove PDF rendering context
        UIGraphicsEndPDFContext();
        
        // Retrieves the document directories from the iOS device
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
        
        // instructs the mutable data object to write its context to a file on disk
        [pdfData writeToFile:documentDirectoryFilename atomically:YES];
        NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    }
    
//-(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
//{
//        // Creates a mutable data object for updating with binary data, like a byte array
//        UIWebView *webView1 = (UIWebView*)aView;
//        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
//        
//        int height = [heightStr intValue];
//        //  CGRect screenRect = [[UIScreen mainScreen] bounds];
//        //  CGFloat screenHeight = (self.contentWebView.hidden)?screenRect.size.width:screenRect.size.height;
//        CGFloat screenHeight = webView.bounds.size.height;
//        int pages = ceil(height / screenHeight);
//        
//        NSMutableData *pdfData = [NSMutableData data];
//        UIGraphicsBeginPDFContextToData(pdfData, webView.bounds, nil);
//        CGRect frame = [webView frame];
//        for (int i = 0; i < pages; i++) {
//            // Check to screenHeight if page draws more than the height of the UIWebView
//            if ((i+1) * screenHeight  > height) {
//                CGRect f = [webView frame];
//                f.size.height -= (((i+1) * screenHeight) - height);
//                [webView setFrame: f];
//            }
//            
//            UIGraphicsBeginPDFPage();
//            CGContextRef currentContext = UIGraphicsGetCurrentContext();
//            //      CGContextTranslateCTM(currentContext, 72, 72); // Translate for 1" margins
//            
//            [[[webView subviews] lastObject] setContentOffset:CGPointMake(0, screenHeight * i) animated:NO];
//            [webView.layer renderInContext:currentContext];
//        }
//        
//        UIGraphicsEndPDFContext();
//        // Retrieves the document directories from the iOS device
//        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//        
//        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
//        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
//        
//        // instructs the mutable data object to write its context to a file on disk
//        [pdfData writeToFile:documentDirectoryFilename atomically:YES];
//        [webView setFrame:frame];
//    }

#pragma mark uiwebview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request     navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView1{
   
   
}
-(IBAction)m:(id)sender{
//    [NSThread sleepForTimeInterval:5];
    
    [self createPDFfromUIView:webView saveToDocumentsWithFileName:@"abc.pdf"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
