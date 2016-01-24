//
//  ListViewController.m
//  Clear
//
//  Created by Yifei Zhou on 11/29/15.
//  Copyright © 2015 Aladdin Inc. All rights reserved.
//

#import "ListViewController.h"
#import <XLForm/XLForm.h>
#import "PreviewViewController.h"

@interface ListViewController ()

@end

NSString *const kALDMultivaluedFormViewControllerSectionTag = @"XLFormSectionInsertModeButton";

@implementation ListViewController

@synthesize rowDescriptor = _rowDescriptor;

- (void)awakeFromNib
{
    self.title = @"To-Do Lists";
    
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupInterface];
    [self setupNavigationButton];
    
    if (self.rowDescriptor.value) {
        self.form = nil;
        [self initializeForm];
    }
}

- (void)setupNavigationButton
{
    UIBarButtonItem *saveButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didTappedSaveButton:)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}

- (void)setupInterface
{
    
}

- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:nil
                                             sectionOptions:XLFormSectionOptionCanInsert | XLFormSectionOptionCanDelete
                                          sectionInsertMode:XLFormSectionInsertModeButton];
    section.multivaluedTag = kALDMultivaluedFormViewControllerSectionTag;
    
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeText];
    [[row cellConfig] setObject:self.cellPlaceholderText forKey:@"textField.placeholder"];
    section.multivaluedRowTemplate = row;
    section.multivaluedAddButton.title = @"添加一个新的项目";
    
    if (!ALDObjectIsNilClass(self.rowDescriptor.value) && [self.rowDescriptor.value isKindOfClass:[NSArray class]]) {
        for (id object in self.rowDescriptor.value) {
            row = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeText];
            [row.cellConfig setObject:self.cellPlaceholderText forKey:@"textField.placeholder"];
            row.value = [NSString stringWithFormat:@"%@", object];
            [section addFormRow:row];
        }
    }
    
    self.form = form;
}

- (NSString *)cellPlaceholderText
{
    return @"新的项目";
}

- (XLFormRowDescriptor *)rowDescriptor
{
    if (!_rowDescriptor) {
        _rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:nil rowType:XLFormRowDescriptorTypeSelectorPush];
    }
    return _rowDescriptor;
}

- (void)didTappedSaveButton:(id)sender
{
    id results = self.formValues[kALDMultivaluedFormViewControllerSectionTag];
    if (!ALDObjectIsNilClass(results) && [results isKindOfClass:[NSArray class]]) {
        self.rowDescriptor.value = [NSArray arrayWithArray:results];
    }
    PreviewViewController *viewController = [[PreviewViewController alloc] init];
    viewController.rowDescriptor = self.rowDescriptor;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
