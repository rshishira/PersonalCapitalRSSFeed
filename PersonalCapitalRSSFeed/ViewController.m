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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(50, 50);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height -20) collectionViewLayout:self.layout];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"ArticleCell"];
    [self.view addSubview:self.collectionView];
    
    RSSFeedDataManager *dataManager = [[RSSFeedDataManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [dataManager getArticleWithCompletion:^(NSArray<Article *> *articles, NSError *error) {
        weakSelf.articlesArray = articles;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });

    }];

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

    cell.title.text = article.title;
    cell.publishDate.text = article.publishDate;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:article.imageDetails[@"url"]]]];
    cell.articleImage.image = image;

    NSLog(@"%@",article.imageDetails[@"url"]);
//    cell.articleDescription.text = [[NSAttributedString alloc] initWithData:[article.articleDescription dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/2 - 20, 200);
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
