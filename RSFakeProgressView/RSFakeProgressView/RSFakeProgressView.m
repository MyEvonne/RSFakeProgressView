//
//  RSFakeProgressView.m
//  RSFakeProgressView
//
//  Created by Richard on 19/01/2017.
//  Copyright © 2017 Richard. All rights reserved.
//

#import "RSFakeProgressView.h"

CGFloat const kRSFakeProgressViewDefaultFakeProgress = 0.9f;
NSTimeInterval const kRSFakeProgressViewDefaultFakeProgressDuration = 1.0f;
NSInteger const kRSFakeProgressViewDefaultChangesPerSecond = 30;

@interface RSFakeProgressView ()
@property (strong, nonatomic) CALayer *progressLayer;

@property (assign, nonatomic) CGFloat progressIncrement;
@property (assign, nonatomic) NSTimeInterval progressDelay;
@end

@implementation RSFakeProgressView

- (instancetype)init {
	self = [super init];
	if (self) {
		[self initializer];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initializer];
	}
	return self;
}

- (void)initializer {
	self.progressLayer = [CALayer layer];
	[self.layer addSublayer:self.progressLayer];
	
	self.progressTintColor = [UIColor darkGrayColor];
	self.trackTintColor = [UIColor lightGrayColor];
	self.fakeProgress = kRSFakeProgressViewDefaultFakeProgress;
	self.fakeProgressDuration = kRSFakeProgressViewDefaultFakeProgressDuration;
	self.changesPerSecond = kRSFakeProgressViewDefaultChangesPerSecond;
}

- (void)layoutSubviews {
	CGRect frame = self.layer.bounds;
	frame.size.width = frame.size.width * self.progress;
	self.progressLayer.frame = frame;
}

#pragma mark - Setter
- (void)setProgressTintColor:(UIColor *)progressTintColor {
	_progressTintColor = progressTintColor;
	self.progressLayer.backgroundColor = progressTintColor.CGColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
	_trackTintColor = trackTintColor;
	self.backgroundColor = self.trackTintColor;
}

- (void)setProgress:(CGFloat)progress {
	_progress = progress;
	CGRect frame = self.layer.bounds;
	frame.size.width = frame.size.width * progress;
	self.progressLayer.frame = frame;
}

#pragma mark - Fake Progress Method
- (void)setFakeProgress:(CGFloat)fakeProgress {
	_fakeProgress = fakeProgress;
	[self calculateParameters];
}

- (void)setFakeProgressDuration:(NSTimeInterval)fakeProgressDuration {
	_fakeProgressDuration = fakeProgressDuration;
	[self calculateParameters];
}

- (void)setChangesPerSecond:(NSInteger)changesPerSecond {
	_changesPerSecond = changesPerSecond;
	[self calculateParameters];
}

- (void)calculateParameters {
	NSInteger changes = self.changesPerSecond * self.fakeProgressDuration;
	if (changes > 0) {
		self.progressIncrement = self.fakeProgress / changes;
		self.progressDelay = self.fakeProgressDuration / changes;
	}
}

- (void)startFakeProgress {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(increaseProgress) object:nil];
	self.progress = 0;
	[self increaseProgress];
}

- (void)increaseProgress {
	self.progress += self.progressIncrement;
	if (self.progress < self.fakeProgress) {
		[self performSelector:@selector(increaseProgress) withObject:nil afterDelay:self.progressDelay];
	}
}

- (void)finishProgress:(void(^)(void))completeBolck withDelay:(NSTimeInterval)delay {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(increaseProgress) object:nil];
	self.progress = 1;
	if (delay < 0) {
		delay = 0;
	}
	if (completeBolck) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			completeBolck();
		});
	}
}

@end
