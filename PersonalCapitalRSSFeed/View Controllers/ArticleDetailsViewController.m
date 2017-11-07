//
//  ArticleDetailsViewController.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/4/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ArticleDetailsViewController.h"

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
            titleView.numberOfLines = 0;
            titleView.textAlignment = NSTextAlignmentCenter;
            titleView.attributedText = [[NSAttributedString alloc] initWithString:self.article.title attributes:
                                        self.navigationController.navigationBar.titleTextAttributes
                                        ];
            
            [titleView setAdjustsFontSizeToFitWidth:YES];
            titleView;
        });
    }
    
    [self setUpWebView];
}

-(void) viewWillAppear:(BOOL)animated {
        [self.webview.scrollView setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0)];
}
-(void) setUpWebView{

    /** Reminder - Check if the Article link is not empty string! then load the url - Maybe should do in the datamanager Parse level itself*/
    //As per requirement, append "?displayMobileNavigation=0" to the article link.
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webview setDelegate:self];
    NSString *appendedString = [self.article.link stringByAppendingString:@"?displayMobileNavigation=0"];
    
    NSURL *nsurl=[NSURL URLWithString:appendedString];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webview loadRequest:nsrequest];
    [self.view addSubview:self.webview];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.activityIndicator.opaque = YES;
    self.activityIndicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.layer.cornerRadius = 10;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityIndicator setColor:[UIColor whiteColor]];
    [self.webview addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];

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
