//
//  ArticleDetailsViewController.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/4/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ArticleDetailsViewController.h"

@interface ArticleDetailsViewController ()

@end

@implementation ArticleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationItem setTitle:self.article.title];
    [self setUpWebView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Navigation title too long, handling options:
    //Either Autoresize to fit the titleview frame.
    //Or Truncate the text
    //Or add two lines to title - 1.it doesnt look good and apple doesnt recommend.
    
    if(!self.navigationItem.titleView){
        self.navigationItem.titleView = ({
            UILabel *titleView = [UILabel new];
            titleView.numberOfLines = 0;
            titleView.textAlignment = NSTextAlignmentCenter;
            titleView.attributedText = [[NSAttributedString alloc] initWithString:self.article.title attributes:
                                        self.navigationController.navigationBar.titleTextAttributes
                                        ];
            
           [titleView setAdjustsFontSizeToFitWidth:YES];
            titleView;
        });
    }
}

-(void) setUpWebView{
    //Reminder ****Initialize the webview frame dynamically based on the content size. Dont hard code!
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 1024,768)];
    
    /** Reminder - Check if the Article link is not empty string! then load the url - Maybe should do in the datamanager Parse level itself*/
    //As per requirement, append "?displayMobileNavigation=0" to the article link.
    NSString *appendedString = [self.article.link stringByAppendingString:@"?displayMobileNavigation=0"];
    
    NSURL *nsurl=[NSURL URLWithString:appendedString];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    //Start loading indicator here
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //Remove loading indicator here
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
