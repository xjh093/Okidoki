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
```

---

# Logs:

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
