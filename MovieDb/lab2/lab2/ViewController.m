//
//  ViewController.m
//  lab2
//
//  Created by Sara Ashraf on 2/14/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ILMovieDBClient.h"
#import <LHTMDbClient.h>
#import "MovieAPI.h"
#import "Movie.h"
#import "AFNetworking.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(void)getData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString* category =[MovieAPI GET_POPULAR_MOVIES_URL];
    NSURL *URL = [NSURL URLWithString:category];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
           
            NSLog(@"Error: %@", error);
        } else {
            
            [self getMoviesArrayfromString:responseObject];
        }
    }];
    [dataTask resume];
    
}
-(void)getMoviesArrayfromString:(NSMutableDictionary*) data{

    
    
    NSMutableArray* moviesList = [data objectForKey:@"results"];
    
    NSMutableDictionary* ss = [moviesList objectAtIndex:1];
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:[ss objectForKey:@"poster_path"]];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
      NSMutableArray* movieaArray = [NSMutableArray new];
    for (NSMutableDictionary *m in moviesList) {
        Movie *movie =
        [[Movie alloc] initWithDictionary:m error:nil];
        NSLog([m objectForKey:@"title"]);
        NSLog(@"%@",[movie title]);
        [movieaArray arrayByAddingObject:movie];
    }
    
}
@end
