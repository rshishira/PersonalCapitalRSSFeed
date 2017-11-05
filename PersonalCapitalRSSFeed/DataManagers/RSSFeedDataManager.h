//
//  RSSFeedDataManager.h
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

@interface RSSFeedDataManager : NSObject<NSXMLParserDelegate>

-(void) getArticleWithCompletion:(void (^)(NSArray<Article*>*, NSError*)) completionHandler;

@end
