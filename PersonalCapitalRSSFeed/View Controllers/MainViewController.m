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
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"MainViewNavTitle", nil)];
    
    //Set up CollectionView and make data request below:
    [self setUpCollectionView];
    [self getRSSFeedData];
}

#pragma RSS Feed Data Request
- (void) getRSSFeedData {
    
    //Have created a factory method in ActivityIndicatorFactory.m which instantiates
    //UIActivityIndicator and starts the animation when called below.
    //By this approach we can access activity indicator accross the application.
    self.activityIndicator = [ActivityIndicatorFactory activityIndicator];
    self.activityIndicator.center = self.view.center;
    [self.collectionView addSubview:self.activityIndicator];

    //Block to handle data request asynchronously and on completion display the
    //data on main queue.
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
    
    //Adding Pull to refresh, which is a property available on UICollectionView and setting a traget @selector to get refreshed RSS feed data.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor blueColor]];
    [self.refreshControl addTarget:self action:@selector(getRSSFeedData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView setRefreshControl:self.refreshControl];
    [self.view addSubview:self.collectionView];
    
    //Adding autolayout constraints to UICollectionView in relation to self.view
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.view addConstraints:@[top, bottom, left, right]];
}

//This method converts the RSS Feed Published date format to the desired date format to be plugged into the UI.
-(NSString *)formatDateWithString:(NSString *)date{
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ\n"];
    NSDate * convertedDate = [formatter dateFromString:date];
    
    [formatter setDateFormat:NSLocalizedString(@"OutputDateFormat", nil)];
    NSString *dateString = [formatter stringFromDate:convertedDate];
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
    
    //Display NSAttributedString format of Publish date appended with Article description only for the first article on the view.
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
    //Set the below size of the cell Only for the first article.
    if(indexPath.row == 0){
       return CGSizeMake(self.view.frame.size.width - 20, 280);
    }
    
    //For the rest of the cells, for handheld device (whose size class property will be UIUserInterfaceSizeClassCompact)
    //set cell in two rows. else if its a tablet(whose size class property will be UIUserInterfaceSizeClassRegular) set cell in three rows.
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        return CGSizeMake(self.view.frame.size.width/2 - 20, 230);
    } else {
         return CGSizeMake(self.view.frame.size.width/3 - 20, 230);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 5);
}

//On did select of the cell/article, passing the Article model as a property to the ArticleDetailViewController
//programatically pushing to the detail VC
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.articleDetailsVC = [[ArticleDetailsViewController alloc] init];
    [self.articleDetailsVC setArticle:self.articlesArray[indexPath.item]];
    self.articleDetailsVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:self.articleDetailsVC animated:YES];
}

    //CollectionView changes its cell layout on device orientation change, to tackle this I tried using LayoutIfNeeded, but dint work.
    //So had to resort to reload of CollectionView, which is not the best approach, but calls the sizeForItemAtIndexPath to layout
    //cells again.
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    //[self.collectionView layoutIfNeeded];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
