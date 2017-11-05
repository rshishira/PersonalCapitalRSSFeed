//
//  ArticleDetailsViewController.h
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/4/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleDetailsViewController : UIViewController <UIWebViewDelegate>

@property(nonatomic, strong) Article *article;

@end
