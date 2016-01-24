//
//  PreviewViewController.m
//  Clear
//
//  Created by Yifei Zhou on 11/29/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import "PreviewViewController.h"
#import <XLForm/XLForm.h>
#import "SaveListViewController.h"
#import "UIColor+ALDAdditions.h"

@interface PreviewViewController ()

@property (strong, nonatomic) NSArray *keywords;
@property (strong, nonatomic) NSMutableArray *keywordButtons;

@end

@implementation PreviewViewController

- (instancetype)init
{
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PreviewViewController"];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    _keywordButtons = [@[] mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预览";

    [self setupInterface];
    
    if (!ALDObjectIsNilClass(self.rowDescriptor.value) && [self.rowDescriptor.value isKindOfClass:[NSArray class]]) {
        self.keywords = self.rowDescriptor.value;
    }
    
    if (self.keywords.count > 0) {
        [self setupNavigationButton];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTappedView:)];
    gestureRecognizer.numberOfTapsRequired = 2;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)setupInterface
{
}

- (void)setKeywords:(NSArray *)keywords
{
    [self clearKeywordButtons];
    _keywords = keywords;
    [self setupKeywordButtons];
}

- (void)clearKeywordButtons
{
    for (UIButton *button in self.keywordButtons) {
        [button removeFromSuperview];
    }
    [self.keywordButtons removeAllObjects];
}

- (void)setupNavigationButton
{
    UIBarButtonItem *saveButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"生成图片" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedSaveButton:)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}

- (void)setupKeywordButtons
{
    [self.keywords enumerateObjectsUsingBlock:^(NSString *keyword, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:28];
        [button setTitle:keyword forState:UIControlStateNormal];
        [button setTitleColor:[UIColor ald_randomColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didTappedKeywordButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.keywordButtons addObject:button];
        [self.view addSubview:button];
        if (idx == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.view);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(self.mas_topLayoutGuide).offset(180);
            }];
        } else {
            UIButton *lastButton = self.keywordButtons[idx - 1];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.view);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(lastButton.mas_bottom).offset(15);
            }];
        }
    }];
}

- (void)didTappedKeywordButton:(id)sender
{
    // Edit it
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTappedSaveButton:(id)sender
{
    UIImage *image = [self.view currentScreenImage];
    SaveListViewController *viewController = [[SaveListViewController alloc] initWithUIImage:image];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)userDidTappedView:(id)sender
{
    self.backgroundImageView.alpha = (arc4random() % 100) / 100.0f;
    for (UIButton *button in self.keywordButtons) {
        [button setTitleColor:[UIColor ald_randomColor] forState:UIControlStateNormal];
    }
}

@end
