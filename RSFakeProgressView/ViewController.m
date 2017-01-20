//
//  ViewController.m
//  RSFakeProgressView
//
//  Created by Richard on 19/01/2017.
//  Copyright © 2017 Richard. All rights reserved.
//

#import "ViewController.h"
#import "RSFakeProgressView.h"

@interface ViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView * webView;

@property (strong, nonatomic) RSFakeProgressView * fakeProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.webView];
	self.webView.delegate = self;
	
	self.fakeProgressView = [[RSFakeProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 5)];
	self.fakeProgressView.progressTintColor = [UIColor orangeColor];
	[self.view addSubview:self.fakeProgressView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]]];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[self.fakeProgressView startFakeProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.fakeProgressView finishProgress:^{
		
	} withDelay:1];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[self.fakeProgressView finishProgress:^{
		
	} withDelay:1];
}
@end
