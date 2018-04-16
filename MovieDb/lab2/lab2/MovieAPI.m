//
//  MovieAPI.m
//  lab2
//
//  Created by Sara Ashraf on 2/27/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import "MovieAPI.h"

@implementation MovieAPI{

   
}
const NSString* API_KEY = @"e5f9929ddcdead7015fdb6048e240743";
const NSString* MOVIE_API_BASE_UTL = @"https://api.themoviedb.org/3/movie/";
const NSString* QUERY = @"?";
const NSString* QUERY_KEY = @"api_key=";
const NSString* QUERY_LANG_AND_PAGES = @"&language=en-US&page=1";
const NSString* IMAGE_PATH = @"https://image.tmdb.org/t/p/w185/";
const NSString* VIDEO =@"/videos";
const NSString* REVIEW =@"/reviews";




const NSString* YOU_TUBE_LINK = @"https://www.youtube.com/watch?v=";
NSString *sort;

+(NSString*) GET_POPULAR_MOVIES_URL{
    NSString* popularDir = @"popular";
    popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:popularDir];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    return popularDir;
}

+(NSString*) GET_TOP_RATED_MOVIES_URL{
    NSString* popularDir = @"top_rated";
    popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:popularDir];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    return popularDir;
}

+(NSString*) GET_MOVIE_IMAGE_PATH_With_Image:(NSString*)image {
    return [IMAGE_PATH stringByAppendingString:image];
}


+(NSString*) GET_Trailer:(NSString*)fid{
    // NSString* popularDir = @"popular";
    NSString* popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:fid];
    popularDir = [popularDir stringByAppendingString:VIDEO];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    
  // NSLog(@"%@",popularDir);
    return popularDir;
}

+(NSString*) GET_YOU_TUBE_PATH:(NSString*)key {
  

    return [YOU_TUBE_LINK stringByAppendingString:key];

    
}



+(NSString*) GET_REVIEW:(NSString*)fid{
    // NSString* popularDir = @"popular";
    NSString* popularDir = [MOVIE_API_BASE_UTL stringByAppendingString:fid];
    popularDir = [popularDir stringByAppendingString:REVIEW];
    popularDir = [popularDir stringByAppendingString:QUERY];
    popularDir = [popularDir stringByAppendingString:QUERY_KEY];
    popularDir = [popularDir stringByAppendingString:API_KEY];
    popularDir = [popularDir stringByAppendingString:QUERY_LANG_AND_PAGES];
    
   // NSLog(@"%@",popularDir);
    return popularDir;
}







@end
