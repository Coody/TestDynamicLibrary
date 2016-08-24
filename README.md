# TestDynamicLibrary

1. 用來測試 iOS Dynamic library 的專案集合
2. 有改寫自別人的專案（底下會附上所有參考的文章與專案出處）
3. 做記錄用


# 第 0 階段（2016/06/27 開始）

1. 認識iOS library 以及 framework。參考：[靜態library][] ， [iOS static framework][]
[靜態library]: http://furnacedigital.blogspot.tw/2011/06/xcode-4-static-library.html
[iOS static framework]: https://www.raywenderlich.com/65964/create-a-framework-for-ios


# 第 1 階段（2016/07/~ 開始）

1. iOS 的 dynamic library 如何產生？ 參考：[建立動態 library（embedded framework）][] ， [stackoverflow_1][] ， [stackoverflow_2][] ， [stackoverflow_3][] ， [stackoverflow_4][] ，[stackoverflow_5][] ， [iOS8xcode6][] ，  [After_2014_WWDC][] ， [removeBundleCache][] ， [removeBundleCache_StackOverFlow][] ... PS: 內部還可以相關連到很多文章，在這裡不再補連結了。
2. dynamic library 如何建立並加入專案中？並且可以 work ？
3. 將 dynamic library 改成下載的方式，並且可以 work ?
4. 問題確認與解決。
5. 第一階段總結報告。

[建立動態 library（embedded framework）]: http://foggry.com/blog/2014/06/12/wwdc2014zhi-iosshi-yong-dong-tai-ku/
[stackoverflow_1]: http://stackoverflow.com/questions/15331056/library-static-dynamic-or-framework-project-inside-another-project
[stackoverflow_2]: http://stackoverflow.com/questions/4733847/can-you-build-dynamic-libraries-for-ios-and-load-them-at-runtime
[stackoverflow_3]: http://stackoverflow.com/questions/25080914/will-ios-8-support-dynamic-linking
[stackoverflow_4]: http://stackoverflow.com/questions/27899799/ios-static-vs-dynamic-frameworks-clarifications
[stackoverflow_5]: http://stackoverflow.com/questions/27484997/how-to-create-an-umbrella-framework-in-ios-sdk
[iOS8xcode6]: http://www.insert.io/frameworkios8xcode6/
[After_2014_WWDC]: http://foggry.com/blog/2014/06/12/wwdc2014zhi-iosshi-yong-dong-tai-ku/
[removeBundleCache]: https://michelf.ca/blog/2010/killer-private-eraser/
[removeBundleCache_StackOverFlow]: http://stackoverflow.com/questions/13525665/is-there-a-way-to-invalidate-nsbundle-localization-cache-withour-restarting-app


# 第 2 階段（2016/08/~ 開始）

0. 了解目前 Ooxx 系列專案產生遊戲 .a library 的方式。
1. 專案的 ooxx 的動態 library 如何產生？
2. 專案可載入動態 library 並且可以 work。
3. 專案可使用下載的方式，下載動態 library 並起可以加入 bundle 、並且可以 work。


# 第 3 階段（?）

1. 將一系列專案改成此架構。
2. .....
3. 

PS：第 2、3 階段步驟可以視瓶頸來調整步驟，但方向不變。


## 參考文獻
（待補）

