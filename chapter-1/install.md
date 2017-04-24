## install Ruby on Rails

Windows 上安装 Ruby on Rails

首先需要有 Node.js 及 Git。 然后：

1. 在官网上安装 Ruby
2. 安装相应的 Ruby devkit
3. cd 到 devkit 的文件夹内， 运行 *ruby dk.rb init*, *ruby dk.rb install*
4. 安装 Rails *gem install rails --version=5.0.0.1 --no-ri --no-rdoc*
5. 顺便安装一个 sqlite-3 数据库 https://github.com/luislavena/sqlite3-ruby

基本上就可以使用 Rails 了， 但毕竟 Windows ╮(╯-╰)╭， 我在安装时出现了 *Hitting TZInfo::DataSourceNotFound: No timezone data source could be found. with a fresh install of rail* 问题， 所以要在 Gemfile 中改变成这样： *gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]* ， 然后运行 *bundle update*。

## 启动新欢迎页

1. cd first rails
2. rails new demo
3. cd demo

然后创建一个简单的欢迎页
1. ruby bin/rails about
2. bin/rails server 开启服务器查看效果


## 启动新项目
1. bin/rails generate controller Say hello goodbye 在 Say 视图下创建两个页面。 在 *http://localhost:3000/say* 查看已有两条路由。
http://localhost:3000/say/hello, http://localhost:3000/say/goodbye

在 views 文件夹内有两个模板 hello 和 goodbye 了， 后缀为 erb 类似于 ejs ， 所以基本和 ejs 的语法一致。

在 controllers 内有 say 的控制器， 负责 say 视图下的 hello 和 goodbye 模板的逻辑控制。

### 在模板内启动动态内容， 因为 erb 类似于 [ejs](http://ejs.co/) 模板引擎， 所以我们可以这样输入：
 *<%= Time.now %>* ， 当然模板内写逻辑是不好滴， 我们在控制器里定义 @time 变量：

 ```rb
class SayController < ApplicationController
  def hello
➤ @time = Time.now
  end

  def goodbye
  end
end
 ```
然后直接在对应的模板内引入 @time：

```js
<%= @time %>
```

一样的效果。 我们在 hello 页面的控制器内定义了一个变量 @time ， 然后再模板内引入。


### 在模板内启用超链接

模板内使用超链接依然可以使用 a 标签来跳转， 相比用 a 标签写死路径， 我们可以使用 Rails 的辅助函数 link_to 来达到相同的效果：

```js
<%= link_to "Goodbye", say_goodbye_path %>
```

link_to 后的 "Goodbye" 相当于 a 标签内的文本， say_goodbye_path 相当于 href= "say/hello"， say_goodbye_path 会自动查找。
