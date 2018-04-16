//
//  Review.h
//  lab2
//
//  Created by Sara Ashraf on 3/3/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface Review : JSONModel


@property (nonatomic) NSString* author;
@property (nonatomic) NSString* content;
@property (nonatomic) NSString* id;

@end
