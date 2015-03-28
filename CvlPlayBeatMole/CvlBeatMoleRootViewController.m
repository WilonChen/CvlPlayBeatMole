//
//  CvlBeatMoleRootViewController.m
//  CvlPlayBeatMole
//
//  Created by qianfeng on 15/3/15.
//  Copyright (c) 2015年 陈威. All rights reserved.
//

#import "CvlBeatMoleRootViewController.h"
#import "CvlBeatMoleView.h"

#define TAG_BACKGROUND(x) x+10
@interface CvlBeatMoleRootViewController ()
{
    NSMutableArray *_molesArray;
    
    NSTimer *_timer;
}
@end

@implementation CvlBeatMoleRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackGround];
    [self createMoles];
    [self createTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createBackGround {
    
        for (NSInteger i = 1; i <= 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"GameBG0%i",(int)i]];
        UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
            imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
            imageView.tag = TAG_BACKGROUND(i);
            
           imageView.center =  [self centerForBackGround:i];
            
            imageView.userInteractionEnabled = YES;
            
            [self.view addSubview:imageView];
            [imageView release];
    }
    
}

- (CGPoint)centerForBackGround:(NSInteger)i {
    CGFloat y = 0;
    switch (i) {
        case 4:
            y += 116 / 2 - 36;
            y += 123 / 2;
        case 3:
            y += 123 / 2 - 36;
            y += 124 / 2;
        case 2:
            y += 124 / 2 - 36;
            y += 227 / 2;
        case 1:
            y += 227 / 2;
        default:
        break;
    }
    return  CGPointMake(160, y);
}
- (void)createMoles {
    if (_molesArray == nil) {
        _molesArray = [[NSMutableArray alloc] init];
    }
    for (NSInteger i = 0; i < 3; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            CvlBeatMoleView *molesView = [[CvlBeatMoleView alloc] initWithCenter:CGPointMake(j * 103 + 60, i * 87 + 240)];
            [self.view insertSubview:molesView aboveSubview:[self.view viewWithTag:TAG_BACKGROUND(1 + i)]];
            [_molesArray addObject:molesView];
            [molesView release];
        }
    }
}
- (void)moleMove {
    NSInteger x = arc4random() % 100;
    if (x == 0) {
        CvlBeatMoleView *mole = _molesArray[arc4random() % _molesArray.count];
        if (mole.isJump == NO) {
            mole.isJump = YES;
        }
    }
    for (CvlBeatMoleView *mole in _molesArray) {
        [mole bombleMove];
    }
}
- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    
}
- (void)refresh {
    [self moleMove];
}
- (void)dealloc {
    [_molesArray release];
    [_timer release];
    if (_timer) {
        [_timer invalidate];
    }
    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
