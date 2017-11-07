//
//  ActivityIndicatorFactory.m
//  PersonalCapitalRSSFeed
//
//  Created by Shishira Ramesh on 11/6/17.
//  Copyright © 2017 Shishira Ramesh. All rights reserved.
//

#import "ActivityIndicatorFactory.h"


@implementation ActivityIndicatorFactory

+(UIActivityIndicatorView *) activityIndicator{
   UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    activityIndicator.opaque = YES;
    activityIndicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    activityIndicator.layer.cornerRadius = 20;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicator setColor:[UIColor whiteColor]];
    
    [activityIndicator startAnimating];
    return activityIndicator;

}

@end
