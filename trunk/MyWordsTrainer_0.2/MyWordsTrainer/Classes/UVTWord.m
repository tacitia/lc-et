//
//  UVTWord.m
//  MyWordsTrainer
//
//  Created by Guo Hua on 27/12/2010.
//  Copyright 2010 HKUST. All rights reserved.
//

#import "UVTWord.h"

@implementation UVTWord

@synthesize word;
@synthesize meanings;
@synthesize usages;

-(id)initWithWord:(NSString*)theWord meanings:(NSDictionary*)theMeanings usages:(NSDictionary*)theUsages {
	self.word = theWord;
	self.meanings = [NSDictionary dictionaryWithDictionary:theMeanings];
	self.usages = [NSDictionary dictionaryWithDictionary:theUsages];
	return self;
}

@end
