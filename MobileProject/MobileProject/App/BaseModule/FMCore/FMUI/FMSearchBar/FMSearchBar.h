//
//  FMSearchBar.h
//  MobileProject
//
//  Created by Mingoy on 16/10/11.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FMSearchBarIconAlign) {
    FMSearchBarIconAlignLeft,
    FMSearchBarIconAlignCenter
};
@class FMSearchBar;
@protocol FMSearchBarDelegate <UIBarPositioningDelegate>

@optional

- (BOOL)searchBarShouldBeginEditing:(FMSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(FMSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(FMSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(FMSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(FMSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(FMSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; // called before text changes

- (void)searchBarSearchButtonClicked:(FMSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(FMSearchBar *)searchBar;                     // called when cancel button pressed
// called when cancel button pressed
@end


@interface FMSearchBar :  UIView<UITextInputTraits>

@property(nonatomic,assign) id<FMSearchBarDelegate> delegate;              // weak reference. default is nil
@property(nonatomic,copy)   NSString               *text;                  // current/starting search text
@property(nonatomic,retain) UIColor                *textColor;
@property(nonatomic,retain) UIFont                 *textFont;
@property(nonatomic,copy)   NSString               *placeholder;           // default is nil
@property(nonatomic,retain) UIColor                *placeholderColor;
@property(nonatomic,retain) UIImage                *iconImage;
@property(nonatomic,retain) UIImage                *backgroundImage;

@property(nonatomic,retain) UIButton *cancelButton; //lazy


@property(nonatomic,assign) UITextBorderStyle       textBorderStyle;
@property(nonatomic)        UIKeyboardType          keyboardType;
@property(nonatomic)        FMSearchBarIconAlign    iconAlign;     //text aligh model


@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;
@property (nonatomic, readwrite, retain) UIView *inputView;

- (BOOL)resignFirstResponder;
- (void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;

@end
