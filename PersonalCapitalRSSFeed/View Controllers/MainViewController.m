//
//  MainViewController.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "MainViewController.h"
#import "RSSFeedDataManager.h"
#import "ArticleCollectionViewCell.h"
#import "ArticleDetailsViewController.h"
#import "ActivityIndicatorFactory.h"

NSString *const cellID = @"ArticleCell";

@interface MainViewController ()

@property (nonatomic, strong) NSArray *articlesArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UILabel *redView;
@property (nonatomic, strong) ArticleDetailsViewController *articleDetailsVC;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"MainViewNavTitle", nil)];
    
    [self setUpCollectionView];
    [self getRSSFeedData];
}

#pragma RSS Feed Data Request
- (void) getRSSFeedData {

    self.activityIndicator = [ActivityIndicatorFactory activityIndicator];
    self.activityIndicator.center = self.view.center;
    [self.collectionView addSubview:self.activityIndicator];

    RSSFeedDataManager *dataManager = [[RSSFeedDataManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [dataManager getArticleWithCompletion:^(NSArray<Article *> *articles, NSError *error) {
        weakSelf.articlesArray = articles;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
            [self.collectionView.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
        });
    }];
}

#pragma Set Up CollectionView
- (void) setUpCollectionView {

     self.layout = [[UICollectionViewFlowLayout alloc] init];
     self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.collectionView setCollectionViewLayout:self.layout];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor blueColor]];
    [refreshControl addTarget:self action:@selector(getRSSFeedData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView setRefreshControl:refreshControl];
    [self.view addSubview:self.collectionView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.view addConstraints:@[top, bottom, left, right]];
}

-(NSString *)formatDateWithString:(NSString *)date{
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:NSLocalizedString(@"InputDateFormat", nil)];
    NSDate * convrtedDate = [formatter dateFromString:date];
    [formatter setDateFormat:NSLocalizedString(@"OutputDateFormat", nil)];
    NSString *dateString = [formatter stringFromDate:convrtedDate];
    return dateString;
}

#pragma CollectionView Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return [self.articlesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    Article *article = [self.articlesArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:article.imageDetails[@"url"]]]];
    cell.articleImage.image = image;
        
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:article.title attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
    cell.title.attributedText = titleString;
    
    if(indexPath.row == 0){
        NSAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[article.articleDescription dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:NULL error:nil];
        cell.publishDate.attributedText = attributedString;
        NSString *descString = [attributedString string];
        
        NSString *appendedCompleteString = [[self formatDateWithString:article.publishDate] stringByAppendingString:[NSString stringWithFormat:@" - %@",descString]];
        cell.publishDate.font = [UIFont fontWithName:NSLocalizedString(@"HelveticaNeue", nil) size:12.0];
        cell.publishDate.text = appendedCompleteString;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
       return CGSizeMake(self.view.frame.size.width - 20, 280);
    }
    
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        return CGSizeMake(self.view.frame.size.width/2 - 20, 230);
    } else {
         return CGSizeMake(self.view.frame.size.width/3 - 20, 230);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.articleDetailsVC = [[ArticleDetailsViewController alloc] init];
    [self.articleDetailsVC setArticle:self.articlesArray[indexPath.item]];
    self.articleDetailsVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:self.articleDetailsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
