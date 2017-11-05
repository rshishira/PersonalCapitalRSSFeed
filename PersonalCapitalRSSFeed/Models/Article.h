//
//  Article.h
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *articleImage;
@property(nonatomic,strong) NSString *articleDescription;
@property(nonatomic,strong) NSString *link;
@property(nonatomic,strong) NSString *publishDate;
@property(nonatomic,strong) NSDictionary *imageDetails;

@end
