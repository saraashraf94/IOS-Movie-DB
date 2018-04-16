//
//  FavouritCollection.m
//  lab2
//
//  Created by Sara Ashraf on 3/2/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import "FavouritCollection.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FavouritCollection (){
    
    NSMutableArray *movies;
    Movie *movie;
    Database *data;
}


@end

@implementation FavouritCollection

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    movies = [NSMutableArray new];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    

    UIImageView *myImage = [cell viewWithTag:1];
    
    Movie* m  =[movies objectAtIndex:indexPath.row] ;
    
    
    NSString* stringImageURL =[MovieAPI GET_MOVIE_IMAGE_PATH_With_Image:m.poster_path];
    NSURL* imageURL = [[NSURL alloc] initWithString:stringImageURL];
    
        [myImage setImageWithURL: imageURL];
    
   
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsViewController *details=[self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
    Movie* m  =[movies objectAtIndex:indexPath.row] ;
    
    [details setFtitle:m.title];
    [details setDate:m.release_date];
    [details setRate:m.vote_average];
    [details setImgpath:m.poster_path];
    [details setTextviewf:m.overview];
    [details setId:m.id];
    
    

    
    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewDidLoad];
    
    movies = [NSMutableArray new];
    
    data=[Database sharedInstance];
    
    
    movies=[data getAll];
    
       [self.collectionView reloadData];
}


@end
