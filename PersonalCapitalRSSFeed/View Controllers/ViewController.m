//
//  ViewController.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/3/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ViewController.h"
#import "RSSFeedDataManager.h"
#import "ArticleCollectionViewCell.h"
#import "ArticleDetailsViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *articlesArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UILabel *redView;
@property (nonatomic, strong) ArticleDetailsViewController *articleDetailsVC;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    [self getRSSFeedData];
}

#pragma RSS Feed Data Request
- (void) getRSSFeedData {
    //Make a singleton class of Activity Indicator, accessible from WebView VC as well
    //Cutomize the background gray view to have rounded corner
    //Add autolayout constraints to the indicator and not use Frame!
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.activityIndicator.opaque = YES;
    self.activityIndicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.layer.cornerRadius = 10;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityIndicator setColor:[UIColor whiteColor]];
    [self.collectionView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    RSSFeedDataManager *dataManager = [[RSSFeedDataManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [dataManager getArticleWithCompletion:^(NSArray<Article *> *articles, NSError *error) {
        weakSelf.articlesArray = articles;
        dispatch_async(dispatch_get_main_queue(), ^{
            //Remove Loading view here
            [weakSelf.collectionView reloadData];
            [self.activityIndicator stopAnimating];
        });
    }];
}

#pragma Set Up CollectionView
- (void) setUpCollectionView {
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height -20) collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"ArticleCell"];
    [self.view addSubview:self.collectionView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    //[self.view addConstraints:@[top, bottom, left, right]];
    
}

#pragma CollectionView Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return [self.articlesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    Article *article = [self.articlesArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 10;

    cell.title.text = article.title;
    cell.publishDate.text = article.publishDate;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:article.imageDetails[@"url"]]]];
    cell.articleImage.image = image;
    //Clip image bounds -
    [cell.articleImage setClipsToBounds:YES];

//    cell.articleDescription.text = [[NSAttributedString alloc] initWithData:[article.articleDescription dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
       return CGSizeMake(self.view.frame.size.width - 20, 280);
    }
    //Use SizeClasses and see if UIView or View Controller has an SizeClass attribute
    //and based on Compact or Regular properties in size class, user it.
    return CGSizeMake(self.view.frame.size.width/2 - 15, 280);
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
