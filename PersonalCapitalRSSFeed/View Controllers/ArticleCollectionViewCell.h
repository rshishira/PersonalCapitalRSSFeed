//
//  ArticleCollectionViewCell.h
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UIImageView *articleImage;
@property(nonatomic,strong) UITextView *articleDescription;
@property(nonatomic,strong) UILabel *publishDate;
@end
