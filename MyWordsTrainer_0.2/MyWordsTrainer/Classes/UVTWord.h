//
//  UVTWord.h
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UVTWord : NSObject {
	NSString* word;
	NSDictionary* meanings;
	NSDictionary* usages;
}

@property (nonatomic, retain) NSString* word;
@property (nonatomic, retain) NSDictionary* meanings;
@property (nonatomic, retain) NSDictionary* usages;

-(id)initWithWord:(NSString*)name meanings:(NSDictionary*)meanings usages:(NSDictionary*)usages;

@end
