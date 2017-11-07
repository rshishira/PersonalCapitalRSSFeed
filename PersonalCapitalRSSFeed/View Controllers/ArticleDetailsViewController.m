//
//  ArticleDetailsViewController.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/4/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import "ActivityIndicatorFactory.h"

@interface ArticleDetailsViewController ()
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ArticleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Navigation title too long, handling options:
    //Either Autoresize to fit the titleview frame.
    //Or Truncate the text
    //Or add two lines to title - 1.it doesnt look good and apple doesnt recommend.
    if(!self.navigationItem.titleView){
        self.navigationItem.titleView = ({
            UILabel *titleView = [UILabel new];
            titleView.textAlignment = NSTextAlignmentCenter;
            titleView.textColor = [UIColor whiteColor];
            titleView.attributedText = [[NSAttributedString alloc] initWithString:self.article.title attributes:
                                        self.navigationController.navigationBar.titleTextAttributes
                                        ];

            [titleView setAdjustsFontSizeToFitWidth:YES];
            titleView;
        });
    }
    [self setUpWebView];
}

-(void) setUpWebView {
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webview setDelegate:self];
    
    NSURL *nsurl=[NSURL URLWithString:self.article.link];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webview loadRequest:nsrequest];
    [self.view addSubview:self.webview];
    
    self.activityIndicator = [ActivityIndicatorFactory activityIndicator];
    self.activityIndicator.center = self.view.center;
    [self.webview addSubview:self.activityIndicator];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
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
