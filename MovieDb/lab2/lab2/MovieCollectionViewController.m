//
//  MovieCollectionViewController.m
//  lab2
//
//  Created by Sara Ashraf on 2/28/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.


#import "MovieCollectionViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ILMovieDBClient.h"
#import <LHTMDbClient.h>
#import "MovieAPI.h"
#import "Movie.h"
#import "AFNetworking.h"



@interface MovieCollectionViewController ()
{
    NSMutableArray* moviesList;
    NSMutableArray* movieaArray;
    NSMutableArray*mylabels;
    NSMutableArray*myImages;

   

   

}

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    movieaArray = [NSMutableArray new];
    [self getData];
       
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    int size = [movieaArray count];
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UILabel *myLable = [cell viewWithTag:2];
    UIImageView *myImage = [cell viewWithTag:1];
    
    Movie* m  =[movieaArray objectAtIndex:indexPath.row] ;
    
    [myLable setText:m.title];
    
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:m.poster_path];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
    [myImage sd_setImageWithURL: imageURL];
    
   
    
    return cell;
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


-(void)getData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString* category =[MovieAPI GET_POPULAR_MOVIES_URL];
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




-(void)get_rate_Data{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString* category =[MovieAPI GET_TOP_RATED_MOVIES_URL];
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
    movieaArray = [NSMutableArray new];
    
    
    moviesList = [data objectForKey:@"results"];
    
       for (NSMutableDictionary *m in moviesList) {
        Movie *movie =
        [[Movie alloc] initWithDictionary:m error:nil];
        
    movieaArray=[movieaArray arrayByAddingObject:movie];
    }
    
  
    [self.collectionView reloadData];
   }



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     DetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
    Movie* m  =[movieaArray objectAtIndex:indexPath.row] ;
    
    [details setFtitle:m.title];
    [details setDate:m.release_date];
    [details setRate:m.vote_average];
    [details setImgpath:m.poster_path];
    [details setTextviewf:m.overview];
    [details setId:m.id];

    
    
    [self.navigationController pushViewController:details animated:YES];

}

- (IBAction)sort:(id)sender {


    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"What do you want Sort By?"
                delegate:self
        cancelButtonTitle:nil
destructiveButtonTitle:nil
otherButtonTitles:@"TOP RATED ", @"POPULAR",nil];
    popup.tag = 1;
    [popup showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self get_rate_Data];
                break;
                case 1:
                    
                    [self getData];
                    
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}



@end
