//
//	ModelGuaideIma.m
//
//	Create by Mingo 袁凤鸣 on 5/6/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ModelGuaideIma.h"

NSString *const kModelGuaideImaAuthor = @"author";
NSString *const kModelGuaideImaClicks = @"clicks";
NSString *const kModelGuaideImaComments = @"comments";
NSString *const kModelGuaideImaFavorites = @"favorites";
NSString *const kModelGuaideImaIdField = @"id";
NSString *const kModelGuaideImaImageUrl = @"image_url";
NSString *const kModelGuaideImaImages = @"images";
NSString *const kModelGuaideImaIsTop = @"is_top";
NSString *const kModelGuaideImaKeywords = @"keywords";
NSString *const kModelGuaideImaLink = @"link";
NSString *const kModelGuaideImaLinkType = @"link_type";
NSString *const kModelGuaideImaLiveUrl = @"live_url";
NSString *const kModelGuaideImaSource = @"source";
NSString *const kModelGuaideImaSubtitle = @"subtitle";
NSString *const kModelGuaideImaSummary = @"summary";
NSString *const kModelGuaideImaTags = @"tags";
NSString *const kModelGuaideImaTime = @"time";
NSString *const kModelGuaideImaTimeTrans = @"time_trans";
NSString *const kModelGuaideImaTitle = @"title";
NSString *const kModelGuaideImaType = @"type";
NSString *const kModelGuaideImaVideoDuration = @"video_duration";
NSString *const kModelGuaideImaVideoUrl = @"video_url";

@interface ModelGuaideIma ()
@end
@implementation ModelGuaideIma




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kModelGuaideImaAuthor] isKindOfClass:[NSNull class]]){
		self.author = dictionary[kModelGuaideImaAuthor];
	}	
	if(![dictionary[kModelGuaideImaClicks] isKindOfClass:[NSNull class]]){
		self.clicks = [dictionary[kModelGuaideImaClicks] integerValue];
	}

	if(![dictionary[kModelGuaideImaComments] isKindOfClass:[NSNull class]]){
		self.comments = [dictionary[kModelGuaideImaComments] integerValue];
	}

	if(![dictionary[kModelGuaideImaFavorites] isKindOfClass:[NSNull class]]){
		self.favorites = [dictionary[kModelGuaideImaFavorites] integerValue];
	}

	if(![dictionary[kModelGuaideImaIdField] isKindOfClass:[NSNull class]]){
		self.idid = [dictionary[kModelGuaideImaIdField] integerValue];
	}

	if(![dictionary[kModelGuaideImaImageUrl] isKindOfClass:[NSNull class]]){
		self.imageUrl = dictionary[kModelGuaideImaImageUrl];
	}	
	if(![dictionary[kModelGuaideImaImages] isKindOfClass:[NSNull class]]){
		self.images = dictionary[kModelGuaideImaImages];
	}	
	if(![dictionary[kModelGuaideImaIsTop] isKindOfClass:[NSNull class]]){
		self.isTop = [dictionary[kModelGuaideImaIsTop] integerValue];
	}

	if(![dictionary[kModelGuaideImaKeywords] isKindOfClass:[NSNull class]]){
		self.keywords = dictionary[kModelGuaideImaKeywords];
	}	
	if(![dictionary[kModelGuaideImaLink] isKindOfClass:[NSNull class]]){
		self.link = dictionary[kModelGuaideImaLink];
	}	
	if(![dictionary[kModelGuaideImaLinkType] isKindOfClass:[NSNull class]]){
		self.linkType = [dictionary[kModelGuaideImaLinkType] integerValue];
	}

	if(![dictionary[kModelGuaideImaLiveUrl] isKindOfClass:[NSNull class]]){
		self.liveUrl = dictionary[kModelGuaideImaLiveUrl];
	}	
	if(![dictionary[kModelGuaideImaSource] isKindOfClass:[NSNull class]]){
		self.source = dictionary[kModelGuaideImaSource];
	}	
	if(![dictionary[kModelGuaideImaSubtitle] isKindOfClass:[NSNull class]]){
		self.subtitle = dictionary[kModelGuaideImaSubtitle];
	}	
	if(![dictionary[kModelGuaideImaSummary] isKindOfClass:[NSNull class]]){
		self.summary = dictionary[kModelGuaideImaSummary];
	}	
	if(![dictionary[kModelGuaideImaTags] isKindOfClass:[NSNull class]]){
		self.tags = dictionary[kModelGuaideImaTags];
	}	
	if(![dictionary[kModelGuaideImaTime] isKindOfClass:[NSNull class]]){
		self.time = dictionary[kModelGuaideImaTime];
	}	
	if(![dictionary[kModelGuaideImaTimeTrans] isKindOfClass:[NSNull class]]){
		self.timeTrans = dictionary[kModelGuaideImaTimeTrans];
	}	
	if(![dictionary[kModelGuaideImaTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kModelGuaideImaTitle];
	}	
	if(![dictionary[kModelGuaideImaType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kModelGuaideImaType] integerValue];
	}

	if(![dictionary[kModelGuaideImaVideoDuration] isKindOfClass:[NSNull class]]){
		self.videoDuration = dictionary[kModelGuaideImaVideoDuration];
	}	
	if(![dictionary[kModelGuaideImaVideoUrl] isKindOfClass:[NSNull class]]){
		self.videoUrl = dictionary[kModelGuaideImaVideoUrl];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.author != nil){
		dictionary[kModelGuaideImaAuthor] = self.author;
	}
	dictionary[kModelGuaideImaClicks] = @(self.clicks);
	dictionary[kModelGuaideImaComments] = @(self.comments);
	dictionary[kModelGuaideImaFavorites] = @(self.favorites);
	dictionary[kModelGuaideImaIdField] = @(self.idid);
	if(self.imageUrl != nil){
		dictionary[kModelGuaideImaImageUrl] = self.imageUrl;
	}
	if(self.images != nil){
		dictionary[kModelGuaideImaImages] = self.images;
	}
	dictionary[kModelGuaideImaIsTop] = @(self.isTop);
	if(self.keywords != nil){
		dictionary[kModelGuaideImaKeywords] = self.keywords;
	}
	if(self.link != nil){
		dictionary[kModelGuaideImaLink] = self.link;
	}
	dictionary[kModelGuaideImaLinkType] = @(self.linkType);
	if(self.liveUrl != nil){
		dictionary[kModelGuaideImaLiveUrl] = self.liveUrl;
	}
	if(self.source != nil){
		dictionary[kModelGuaideImaSource] = self.source;
	}
	if(self.subtitle != nil){
		dictionary[kModelGuaideImaSubtitle] = self.subtitle;
	}
	if(self.summary != nil){
		dictionary[kModelGuaideImaSummary] = self.summary;
	}
	if(self.tags != nil){
		dictionary[kModelGuaideImaTags] = self.tags;
	}
	if(self.time != nil){
		dictionary[kModelGuaideImaTime] = self.time;
	}
	if(self.timeTrans != nil){
		dictionary[kModelGuaideImaTimeTrans] = self.timeTrans;
	}
	if(self.title != nil){
		dictionary[kModelGuaideImaTitle] = self.title;
	}
	dictionary[kModelGuaideImaType] = @(self.type);
	if(self.videoDuration != nil){
		dictionary[kModelGuaideImaVideoDuration] = self.videoDuration;
	}
	if(self.videoUrl != nil){
		dictionary[kModelGuaideImaVideoUrl] = self.videoUrl;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.author != nil){
		[aCoder encodeObject:self.author forKey:kModelGuaideImaAuthor];
	}
	[aCoder encodeObject:@(self.clicks) forKey:kModelGuaideImaClicks];	[aCoder encodeObject:@(self.comments) forKey:kModelGuaideImaComments];	[aCoder encodeObject:@(self.favorites) forKey:kModelGuaideImaFavorites];	[aCoder encodeObject:@(self.idid) forKey:kModelGuaideImaIdField];	if(self.imageUrl != nil){
		[aCoder encodeObject:self.imageUrl forKey:kModelGuaideImaImageUrl];
	}
	if(self.images != nil){
		[aCoder encodeObject:self.images forKey:kModelGuaideImaImages];
	}
	[aCoder encodeObject:@(self.isTop) forKey:kModelGuaideImaIsTop];	if(self.keywords != nil){
		[aCoder encodeObject:self.keywords forKey:kModelGuaideImaKeywords];
	}
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:kModelGuaideImaLink];
	}
	[aCoder encodeObject:@(self.linkType) forKey:kModelGuaideImaLinkType];	if(self.liveUrl != nil){
		[aCoder encodeObject:self.liveUrl forKey:kModelGuaideImaLiveUrl];
	}
	if(self.source != nil){
		[aCoder encodeObject:self.source forKey:kModelGuaideImaSource];
	}
	if(self.subtitle != nil){
		[aCoder encodeObject:self.subtitle forKey:kModelGuaideImaSubtitle];
	}
	if(self.summary != nil){
		[aCoder encodeObject:self.summary forKey:kModelGuaideImaSummary];
	}
	if(self.tags != nil){
		[aCoder encodeObject:self.tags forKey:kModelGuaideImaTags];
	}
	if(self.time != nil){
		[aCoder encodeObject:self.time forKey:kModelGuaideImaTime];
	}
	if(self.timeTrans != nil){
		[aCoder encodeObject:self.timeTrans forKey:kModelGuaideImaTimeTrans];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kModelGuaideImaTitle];
	}
	[aCoder encodeObject:@(self.type) forKey:kModelGuaideImaType];	if(self.videoDuration != nil){
		[aCoder encodeObject:self.videoDuration forKey:kModelGuaideImaVideoDuration];
	}
	if(self.videoUrl != nil){
		[aCoder encodeObject:self.videoUrl forKey:kModelGuaideImaVideoUrl];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.author = [aDecoder decodeObjectForKey:kModelGuaideImaAuthor];
	self.clicks = [[aDecoder decodeObjectForKey:kModelGuaideImaClicks] integerValue];
	self.comments = [[aDecoder decodeObjectForKey:kModelGuaideImaComments] integerValue];
	self.favorites = [[aDecoder decodeObjectForKey:kModelGuaideImaFavorites] integerValue];
	self.idid = [[aDecoder decodeObjectForKey:kModelGuaideImaIdField] integerValue];
	self.imageUrl = [aDecoder decodeObjectForKey:kModelGuaideImaImageUrl];
	self.images = [aDecoder decodeObjectForKey:kModelGuaideImaImages];
	self.isTop = [[aDecoder decodeObjectForKey:kModelGuaideImaIsTop] integerValue];
	self.keywords = [aDecoder decodeObjectForKey:kModelGuaideImaKeywords];
	self.link = [aDecoder decodeObjectForKey:kModelGuaideImaLink];
	self.linkType = [[aDecoder decodeObjectForKey:kModelGuaideImaLinkType] integerValue];
	self.liveUrl = [aDecoder decodeObjectForKey:kModelGuaideImaLiveUrl];
	self.source = [aDecoder decodeObjectForKey:kModelGuaideImaSource];
	self.subtitle = [aDecoder decodeObjectForKey:kModelGuaideImaSubtitle];
	self.summary = [aDecoder decodeObjectForKey:kModelGuaideImaSummary];
	self.tags = [aDecoder decodeObjectForKey:kModelGuaideImaTags];
	self.time = [aDecoder decodeObjectForKey:kModelGuaideImaTime];
	self.timeTrans = [aDecoder decodeObjectForKey:kModelGuaideImaTimeTrans];
	self.title = [aDecoder decodeObjectForKey:kModelGuaideImaTitle];
	self.type = [[aDecoder decodeObjectForKey:kModelGuaideImaType] integerValue];
	self.videoDuration = [aDecoder decodeObjectForKey:kModelGuaideImaVideoDuration];
	self.videoUrl = [aDecoder decodeObjectForKey:kModelGuaideImaVideoUrl];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ModelGuaideIma *copy = [ModelGuaideIma new];

	copy.author = [self.author copy];
	copy.clicks = self.clicks;
	copy.comments = self.comments;
	copy.favorites = self.favorites;
	copy.idid = self.idid;
	copy.imageUrl = [self.imageUrl copy];
	copy.images = [self.images copy];
	copy.isTop = self.isTop;
	copy.keywords = [self.keywords copy];
	copy.link = [self.link copy];
	copy.linkType = self.linkType;
	copy.liveUrl = [self.liveUrl copy];
	copy.source = [self.source copy];
	copy.subtitle = [self.subtitle copy];
	copy.summary = [self.summary copy];
	copy.tags = [self.tags copy];
	copy.time = [self.time copy];
	copy.timeTrans = [self.timeTrans copy];
	copy.title = [self.title copy];
	copy.type = self.type;
	copy.videoDuration = [self.videoDuration copy];
	copy.videoUrl = [self.videoUrl copy];

	return copy;
}
@end
