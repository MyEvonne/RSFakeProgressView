//
//  RSFakeProgressView.h
//  RSFakeProgressView
//
//  Created by Richard on 19/01/2017.
//  Copyright © 2017 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kRSFakeProgressViewDefaultFakeProgress;
extern NSTimeInterval const kRSFakeProgressViewDefaultFakeProgressDuration;
extern NSInteger const kRSFakeProgressViewDefaultChangesPerSecond;

@interface RSFakeProgressView : UIView

#pragma mark - Progress View Properties. Customized progress view for easy changing frame.
/**
 The current progress shown by the receiver.
 The current progress is represented by a floating-point value between 0.0 and 1.0, inclusive, where 1.0 indicates the completion of the task. The default value is 0.0. Values less than 0.0 and greater than 1.0 are pinned to those limits.
 */
@property (assign, nonatomic) CGFloat progress;

/**
 The color shown for the portion of the progress bar that is filled.
 */
@property (strong, nonatomic) UIColor *progressTintColor;

/**
 The color shown for the portion of the progress bar that is not filled.
 */
@property (strong, nonatomic) UIColor *trackTintColor;

#pragma mark - Fake Progress Properties & Methods.

/**
 The progress that you want to stop at until the finishProgress: method is called.
 The default value is kRSFakeProgressViewDefaultFakeProgress which is equal to 0.9.
 */
@property (assign, nonatomic) CGFloat fakeProgress;

/**
 The duration of fake progress animation.
 The default value is kRSFakeProgressViewDefaultFakeProgressDuration which is equal to 1.0.
 */
@property (assign, nonatomic) NSTimeInterval fakeProgressDuration;

/**
 The changes in one second, default value is kRSFakeProgressViewDefaultChangesPerSecond which is equal to 30.
 */
@property (assign, nonatomic) NSInteger changesPerSecond;
/**
 This method would reset the progress to 0.0, than start progressing and stop at fakeProgress in fakeProgressDuration.
 */
- (void)startFakeProgress;

/**
 This method would set the progress to 1.0.
 */

/**
 This method would set the progress to 1.0. And it would perform completeBlock after the specific delay.

 @param completeBolck A block object to be executed after the delay of the progress is finished.
 @param delay The time interval after the progress is finished before execute the complete block. This is always specified in seconds.
 */
- (void)finishProgress:(void(^)(void))completeBolck withDelay:(NSTimeInterval)delay;

@end
