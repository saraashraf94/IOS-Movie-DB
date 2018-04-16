//
//  DetailsViewController.h
//  lab2
//
//  Created by Sara Ashraf on 3/1/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Database.h"
#import "ReviewTableViewController.h"
//#import "MovieAPI.h"
@interface DetailsViewController : UIViewController<UIAlertViewDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *title;

@property NSString *ftitle;
@property NSString *date;
@property NSString *id;
@property NSString *rate;
@property NSString *imgpath;
@property NSString *textviewf;


@property (strong, nonatomic) IBOutlet UIView *stars;

@property (strong, nonatomic) IBOutlet UIImageView *fposter;

@property (strong, nonatomic) IBOutlet UILabel *fdate;

@property (weak, nonatomic) IBOutlet UILabel *mylabel2;

@property (strong, nonatomic) IBOutlet UILabel *frate;

@property (strong, nonatomic) IBOutlet UITextView *textview;

- (IBAction)play_Movie:(id)sender;

+(NSString*) GET_PATH_TRAILER;

@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;
- (IBAction)ReviewBtn:(id)sender;

- (IBAction)play_Movie2:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favout;

-(void)getReview:(NSString*)_id;

- (IBAction)fav:(id)sender;



@end
