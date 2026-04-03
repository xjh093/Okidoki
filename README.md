# Okidoki
UI chain , UI链式语法

基于：
https://github.com/xjh093/JHCategories

# Example

```
UIView *view = [[UIView alloc] init];
view.okidoki
.tag(@100)
.alpha(@0.5)
.bgColor(@"#FFFEEE")
.bdColor(@"#CCCCCC")
.bdWidth(@1)
.cnRadius(@3)
.mtBounds(@(YES));

UILabel *label = [[UILabel alloc] init];
label.okidoki
.text(@"label")
.color([UIColor blackColor])
.font([UIFont systemFontOfSize:14])
.align(@1)
.lines(@2)
.adjust(@YES)
.lineSpace(@1)
.autoWidth(@200)
.autoHeight(@100)
.attributedSubstring(@"la",[UIColor redColor])
.attributedSubstring(@"la",[UIFont systemFontOfSize:17]);

UIButton *button = [[UIButton alloc] init];
button.okidoki
.titleForState(@"button",@0)
.colorForState([UIColor redColor],@0)
.imageForState([UIImage imageNamed:@"button"],@0);

// TextField with input limit - only digits, max 6 characters
UITextField *textField = [[UITextField alloc] init];
textField.okidoki
.pHolder(@"Enter code")
.tfInputLimit(OkidokiInputLimitTypeDigital, 6, nil, ^(NSString *original, NSString *matched) {
    NSLog(@"Input changed: %@ -> %@", original, matched);
});

// TextField with multiple types - digits and lowercase letters
UITextField *usernameField = [[UITextField alloc] init];
usernameField.okidoki
.pHolder(@"Username")
.tfInputLimit(OkidokiInputLimitTypeDigital | OkidokiInputLimitTypeAlphabetLower, 20, nil, nil);

// TextField with custom characters
UITextField *amountField = [[UITextField alloc] init];
amountField.okidoki
.pHolder(@"Amount")
.tfInputLimit(OkidokiInputLimitTypeCustom, 0, @"0123456789.", nil);

// TextView with Chinese and letter input
UITextView *textView = [[UITextView alloc] init];
textView.okidoki
.tvInputLimit(OkidokiInputLimitTypeChinese | OkidokiInputLimitTypeAlphabet, 200, nil, nil);
```

---

# Logs:

### 2026-04-03
- 0.0.14
  - Input Limit: tfInputLimit & tvInputLimit
  - 支持多种输入类型限制（数字、字母、中文、自定义字符）
  - 支持组合类型（如：数字+字母）
  - 支持长度限制
  - 处理中文输入法
- 0.0.13
  - KeyboardHandler  
- 0.0.12
  - UIAlertController  

### 2026-04-02
- 0.0.11
  - UIScrollView、UITableView、UICollectionView、UITextField、UITextView  

### 2026-03-31
- 0.0.6
  - addSubview、gesture、control

### 2026-03-31
- 0.0.5
  - AutoLayout

### 2020-03-02
- fix bugs and add methods.

### 2020-01-16
- modify pHColor() and pHFont() methods.

### 2019-11-05
- modify autoWidth() method.

### 2019-08-08
- fix a bug~
    - a bug can cause crash.
    
### 2019-05-28
- update.
   - kNumberAdaptor();

### 2019-05-16
- update.

### 2019-02-14
- update.

### 2018-12-3
- update.

---
