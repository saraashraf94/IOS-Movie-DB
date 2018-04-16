//
//  DetailsViewController.m
//  lab2
//
//  Created by Sara Ashraf on 3/1/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import "DetailsViewController.h"
#import "MovieAPI.h"
#import "JSONModel.h"
#import "AFNetworking.h"
#import "MovieCollectionViewController.h"
#import "Trailer ViewController.h"
#import "Database.h"
#import "RateView.h"
#import "ReviewTableViewController.h"
#import "Review.h"

@interface DetailsViewController (){

NSMutableArray* trailerList;
NSMutableArray* Reviwlist;
NSMutableArray* trailerArray;
NSMutableArray* youtube_urls;
NSArray* ReviewArray;
NSString* youtube_url;
NSString* slectedMovie;
Database *data;
    
}

@end

@implementation DetailsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    ReviewArray = [NSMutableArray new];
    
    trailerArray = [NSMutableArray new];
    youtube_urls=[NSMutableArray new];
    Trailer_ViewController *tralir=[Trailer_ViewController new];
    Review *rev=[Review new];

    [self getData];
    [self getReview];
  
   // NSLog(@"%@",_ftitle);
//
//     NSLog(@"%@",[MovieAPI GET_YOU_TUBE_PATH:trailerArray[0]]);
    
    
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewDidLoad];
  
    
    self.navigationItem.leftItemsSupplementBackButton=YES;
    [_myScroll setScrollEnabled:YES];
    [_myScroll setContentSize:CGSizeMake(320,1000)];
    
    
    data=[Database sharedInstance];
    
    [data setPosterPath:_imgpath];
    [data setTitle:_ftitle];
    [data setOverview:_textviewf];
    [data setReleaseDate:_date];
    [data setVoteAverage:_rate];
    [data setId:_id];
    
    // [data findContact];
    
    //[data status];
    
    
    [data findContact];
    if([data.status isEqualToString:@"Match found"]){
        
        [_favout setImage:[UIImage imageNamed:@"starhighlighted.png"] forState:UIControlStateNormal];
        
        
    }else if([data.status isEqualToString:@"Match not found"]){
        
        
        
        [_favout setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    
    }

    
    
    [_mylabel2 setText:_ftitle];

    [_fdate setText:_date];
    [_textview setText:_textviewf];
    
    [_frate setText:_rate];
    
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:_imgpath];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
    
    [_fposter sd_setImageWithURL:imageURL];
    float frate=[_rate floatValue ];
    float brate=frate/2;
    RateView* stars = [RateView rateViewWithRating:brate];
    [self.stars addSubview:stars];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)getData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
       NSString* category =[MovieAPI GET_Trailer:_id];
    NSURL *URL = [NSURL URLWithString:category];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cellular Data is Turned Off"
    message:@"Turn on Cellular Data or Use WLAN to Access Data"
            delegate:self
            cancelButtonTitle:nil
            otherButtonTitles:@"OK",nil];
            [alert show];
            
            NSLog(@"Error: %@", error);
        } else {
            
        
           [self getMoviesArrayfromString:responseObject];
        }
    }];
    [dataTask resume];
    
}

-(void)getMoviesArrayfromString:(NSMutableDictionary*) data{
    
    trailerList = [data objectForKey:@"results"];

      for (NSMutableDictionary *k in trailerList) {
       
         Trailer_ViewController *key =
        [[Trailer_ViewController alloc] initWithDictionary:k error:nil];
        
    trailerArray=[trailerArray arrayByAddingObject:key];
    
   
        [youtube_urls addObject:[MovieAPI GET_YOU_TUBE_PATH:key.key]];
        youtube_url=[MovieAPI GET_YOU_TUBE_PATH:key.key];
    
    }

    
}

- (IBAction)play_Movie:(id)sender {
    
    
    NSURL *url = [NSURL URLWithString:youtube_urls[0]];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url];
    
}

-(void)getReviwArrayfromString:(NSMutableDictionary*) data{
    
    
    Reviwlist= [data objectForKey:@"results"];
    
    for (NSMutableDictionary *r in Reviwlist) {
        
        Review *rev =
        [[Review alloc] initWithDictionary:r error:nil];
        
        ReviewArray=[ReviewArray arrayByAddingObject:rev];
        
        
    }
}


-(void)getReview{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString* category =[MovieAPI GET_REVIEW:_id];
    NSURL *URL = [NSURL URLWithString:category];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cellular Data is Turned Off"
                                                            message:@"Turn on Cellular Data or Use WLAN to Access Data"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            [alert show];
            
        } else {
            
            
            [self getReviwArrayfromString:responseObject];
        }
    }];
    [dataTask resume];
    
}




- (IBAction)ReviewBtn:(id)sender{
    
  
    
    ReviewTableViewController *detailsreview=[self.storyboard instantiateViewControllerWithIdentifier:@"detailsreview"];
    
    
    
    [detailsreview setReviewdetl:ReviewArray];
    
    
    
    [self.navigationController pushViewController:detailsreview animated:YES];
    
}

- (IBAction)play_Movie2:(id)sender {
    
    NSURL *url = [NSURL URLWithString:youtube_urls[1]];
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url];
   
}
- (IBAction)fav:(id)sender {
    

    
    [data findContact];
    
    if([data.status isEqualToString:@"Match found"]){
        
       
        [_favout setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
         [data deleteMovie:_id];
        
    }else if([data.status isEqualToString:@"Match not found"]){
        
        
        
        [_favout setImage:[UIImage imageNamed:@"starhighlighted.png"] forState:UIControlStateNormal];
        [data saveData];
    }
    
   
}
@end
