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
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.contentView.layer.cornerRadius = 20;
        
//        set Image view - Not parsed yet properly.
        self.articleImage = [[UIImageView alloc] init];
        self.articleImage.contentMode = UIViewContentModeScaleToFill;
        [self.articleImage setTranslatesAutoresizingMaskIntoConstraints:NO];
     
        [self.contentView addSubview:self.articleImage];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:160];
        
        //self.articleImage.clipsToBounds = YES;
        [self.contentView addConstraints:@[top, left, right, height]];
        
        //Init Article Title
        self.title = [[UILabel alloc] init];
        self.title.translatesAutoresizingMaskIntoConstraints = NO;
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [self.title setLineBreakMode:NSLineBreakByWordWrapping];
        [self.title setNumberOfLines:2];
        [self.contentView addSubview:self.title];
        
        NSLayoutConstraint *topLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.articleImage attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *leftLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *rightLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *heightLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60];

        [self.contentView addConstraints:@[topLabel, leftLabel, rightLabel, heightLabel]];
        
        
        //Init Article Publish Date //Check the format and parse it to NSDate based on the data returned.
        self.publishDate = [[UILabel alloc] init];
        self.publishDate.translatesAutoresizingMaskIntoConstraints = NO;
        [self.publishDate setTextAlignment:NSTextAlignmentLeft];
        [self.publishDate setLineBreakMode:NSLineBreakByWordWrapping];
        [self.contentView addSubview:self.publishDate];
        
        NSLayoutConstraint *topDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        NSLayoutConstraint *leftDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *rightDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *heightDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
        
        [self.contentView addConstraints:@[topDate, leftDate, rightDate, heightDate]];
        
        //Init Article Description
        self.articleDescription = [[UILabel alloc] init];
        self.articleDescription.translatesAutoresizingMaskIntoConstraints = NO;
        [self.articleDescription setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.articleDescription];
        
        NSLayoutConstraint *topDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.publishDate attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        NSLayoutConstraint *leftDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *rigthDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *bottomDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];

        [self.contentView addConstraints:@[topDescription, leftDescription, rigthDescription, bottomDescription]];
    }
    return self;
}
@end
