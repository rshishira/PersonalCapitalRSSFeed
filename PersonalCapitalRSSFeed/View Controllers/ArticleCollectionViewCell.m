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
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.contentView.layer.cornerRadius = 10;
        
        //Init Article Image
        self.articleImage = [[UIImageView alloc] init];
        [self.articleImage setContentMode:UIViewContentModeScaleAspectFill];
        [self.articleImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.articleImage.layer setMasksToBounds:YES];
        self.articleImage.layer.cornerRadius = 10;
        [self.contentView addSubview:self.articleImage];
        
        //Adding autolayout constraints to articleImage in relation to self.contentView
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.articleImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:160];
        [self.contentView addConstraints:@[top, left, right, height]];
        
        //Init Article Title
        self.title = [[UILabel alloc] init];
        self.title.translatesAutoresizingMaskIntoConstraints = NO;
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [self.title setLineBreakMode:NSLineBreakByWordWrapping];
        [self.title setNumberOfLines:2];
        [self.contentView addSubview:self.title];
        //Adding autolayout constraints to Title in relation to self.contentView
        NSLayoutConstraint *topLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.articleImage attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *leftLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *rightLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *heightLabel = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
        [self.contentView addConstraints:@[topLabel, leftLabel, rightLabel, heightLabel]];
        
        
        //Init Article Publish Date
        self.publishDate = [[UILabel alloc] init];
        self.publishDate.translatesAutoresizingMaskIntoConstraints = NO;
        [self.publishDate setTextAlignment:NSTextAlignmentLeft];
        [self.publishDate setLineBreakMode:NSLineBreakByWordWrapping];
        [self.publishDate setNumberOfLines:3];
        [self.contentView addSubview:self.publishDate];
        //Adding autolayout constraints to publishDate in relation to self.contentView
        NSLayoutConstraint *topDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *leftDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
        NSLayoutConstraint *rightDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *heightDate = [NSLayoutConstraint constraintWithItem:self.publishDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
        [self.contentView addConstraints:@[topDate, leftDate, rightDate, heightDate]];
        
        //Init Article Description
        self.articleDescription = [[UILabel alloc] init];
        self.articleDescription.translatesAutoresizingMaskIntoConstraints = NO;
        [self.articleDescription setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.articleDescription];
        //Adding autolayout constraints to articleDescription in relation to self.contentView
        NSLayoutConstraint *topDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.publishDate attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
        NSLayoutConstraint *leftDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *rigthDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *bottomDescription = [NSLayoutConstraint constraintWithItem:self.articleDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
        [self.contentView addConstraints:@[topDescription, leftDescription, rigthDescription, bottomDescription]];
    }
    return self;
}
@end
