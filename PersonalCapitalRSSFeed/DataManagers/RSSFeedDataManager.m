//
//  RSSFeedDataManager.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "RSSFeedDataManager.h"

@interface RSSFeedDataManager()

@property(nonatomic, strong) Article *currentArticle;
@property(nonatomic, strong) NSMutableArray *articleArray;
@property(nonatomic, strong) NSString *currentElementName;
@property(nonatomic, strong) NSString *currentString;

@end

@implementation RSSFeedDataManager

//Establish a session and make a rss feed data request with the given url and initialize NSXMLParser in this function, follwed by set of parser delegates and start parsing.
-(void) getArticleWithCompletion:(void (^)(NSArray<Article*>*, NSError*)) completionHandler{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *articleURL = NSLocalizedString(@"RssFeedURL", nil);
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:articleURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                completionHandler(nil, error);
                return;
            }
            weakSelf.articleArray = [[NSMutableArray alloc] init];
            if(data == nil){
                completionHandler(nil, [NSError errorWithDomain:NSLocalizedString(@"PersonalCapitalRSSFeed", nil) code:-1 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"NoDataMessage", nil)}]);
               return;
            }
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            [parser setDelegate:self];
        
            BOOL result = [parser parse];
            if(result){
                completionHandler(weakSelf.articleArray, nil);
            } else {
                completionHandler(nil, [NSError errorWithDomain:NSLocalizedString(@"PersonalCapitalRSSFeed", nil) code:-1 userInfo:@{NSLocalizedDescriptionKey:NSLocalizedString(@"ParsingErrorMessage", nil)}]);  
                return;
            }
        
        }];
    [dataTask resume];
}

#pragma NSXMLParser delegates
// Called when the parser finds an element start tag.
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElementName = elementName;
    self.currentString = @"";
    
    //We are looking for our "item" and "media:content" nodes.
    if([elementName isEqualToString:@"item"]){
        self.currentArticle = [[Article alloc] init];
    } else if ([self.currentElementName isEqualToString:@"media:content"]){
        if(self.currentArticle) {
            self.currentArticle.imageDetails = [attributeDict copy];
        }
    }
}

//Called when an end tag is encountered. The various parameters are supplied below.
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if ([self.currentElementName isEqualToString:@"title"]){
        self.currentArticle.title = self.currentString;
    } else if ([self.currentElementName isEqualToString:@"link"]){
        //Append this string to the article link to eliminate chrome navigationbar contained within the rendered website.
        NSString *appendedString = [self.currentString stringByAppendingString:NSLocalizedString(@"displayMobileNavigation", nil)];
        self.currentArticle.link = appendedString;
    } else if ([self.currentElementName isEqualToString:@"pubDate"]){
        self.currentArticle.publishDate = self.currentString;
    } else if ([self.currentElementName isEqualToString:@"description"]){
        self.currentArticle.articleDescription = self.currentString;
    } else if ([self.currentElementName isEqualToString:@"media:content"]){
        self.currentArticle.articleImage = self.currentString;
    }
    if([elementName isEqualToString:@"item"]){
        [self.articleArray addObject:self.currentArticle];
    }
}

// This returns the string of the characters encountered thus far. 
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    self.currentString = [self.currentString stringByAppendingString:string];
}

@end
