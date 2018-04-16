//
//  MovieCollectionViewController.h
//  lab2
//
//  Created by Sara Ashraf on 2/28/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ILMovieDBClient.h"
#import "DetailsViewController.h"

@interface MovieCollectionViewController : UICollectionViewController <UIAlertViewDelegate>


- (IBAction)sort:(id)sender;

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex ;
@property NSString *status;
@property NSString *result;
@end
