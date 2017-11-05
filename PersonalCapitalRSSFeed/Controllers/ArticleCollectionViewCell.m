//
//  ArticleCollectionViewCell.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ArticleCollectionViewCell.h"

@implementation ArticleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
     //******Add autolayout constraints and NOT use frames and bounds!!
        
//        set Image view - Not parsed yet properly.
        self.articleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        self.articleImage.contentMode = UIViewContentModeScaleAspectFill;
        self.articleImage.clipsToBounds = YES;
        [self.articleImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.articleImage];
        
        //Init Article Title
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.articleImage.frame.size.height, frame.size.width, 20)];
        [self.title setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.title];
        
        //Init Article Publish Date //Check the format and parse it to NSDate based on the data returned.
        self.publishDate = [[UILabel alloc] initWithFrame:CGRectMake(0, self.title.frame.size.height, frame.size.width, frame.size.height/3)];
        [self.publishDate setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.publishDate];
        
        //Init Article Description
        self.articleDescription = [[UITextView alloc] initWithFrame:CGRectMake(0, self.publishDate.frame.size.height + 10, frame.size.width, frame.size.height/3)];
        [self.articleDescription setTextAlignment:NSTextAlignmentCenter];
        [self.articleDescription sizeToFit];
        [self.contentView addSubview:self.articleDescription];
    }
    return self;
}
@end
