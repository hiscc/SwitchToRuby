Ruby 使用符号来标识方法参数：

```rb
redirect_to :action => "edit", :id => params[:id]
```

### 方法

```rb
def say_goodnight(name)
  result = 'Good night, ' + name
  return result
end

# Time for bed...
puts say_goodnight('Mary-Ellen') # => 'Goodnight, Mary-Ellen'
puts say_goodnight('John-Boy') # => 'Goodnight, John-Boy'
```

return 可选， 如忽略则默认返回表达式最后一行。 注释以 *#* 开始

### 数据类型

Ruby 中所有东东都是对象， 有一些拥有特殊的语法。

#### String

```rb
def say_goodnight(name)
  "Good night, #{name.capitalize}"
end
puts say_goodnight('pa')
```
参数以 *#{...}* 的形式使用。


#### Array, Hashes

Ruby 中的 Array 和 Hashes 是索引集合类。 都可以储存对象集合并通过键来访问到。 在 Array 中键是整型， 而在 Hashes 中键可以是任何对象。 它们都可以根据需要来添加新元素。 在 Array 中存取元素很有效， 而 Hashes 更具弹性。 Array, Hashes 可以填充不同类型的对象。

```rb
a = [ 1, 'cat', 3.14 ]  # array with three elements
a[0]                    # access the first element (1)
a[2] = nil              # set the third element
                        # array now [ 1, 'cat', nil ]
```

*nil* 不同于其它语言， 它在 Ruby 中是一个对象表示没有任何东东。

<<() 方法经常用于数组， 来添加接收到的值：

```rb
ages = []
for person in @people
  ages << person.age
end
```

Ruby 有一个创建数组的简写：

```rb
a = [ 'ant', 'bee', 'cat', 'dog', 'elk' ]
# this is the same:
a = %w{ ant bee cat dog elk }
```

Ruby Hashes 用大括号来表示， 每一项包含两个对象： 一个是键， 一个是值。

```rb
inst_section = {
  :cello    => 'string',
  :clarinet => 'woodwind',
  :drum     => 'percussion',
  :oboe     => 'woodwind',
  :trumpet  => 'brass',
  :violin   => 'string'
}
```

箭头左边为键， 右面为其对应的值。 键必须唯一； 如果有两个相同的键， 后面的将覆盖前面的。 键和值可以是任意对象， 数组之类的。

许多 Rails 已经巧妙地修改过， 你可以使用 String 作为键了而非符号, 因为在 hash 中使用符号特别平常， 所以 Ruby 为它搞了一个特别的语法：

```rb
inst_section = {
  cello:    'string',
  clarinet: 'woodwind',
  drum:     'percussion',
  oboe:     'woodwind',
  trumpet:  'brass',
  violin:   'string'
}
```

使用冒号语法。

需要注意的是， 如果你的键不是符号时， 你需要使用箭头语法。 当值是符号时， 在值前面加上冒号：

```rb
inst_section = {
  cello:    :string,
  clarinet: :woodwind,
  drum:     :percussion,
  oboe:     :woodwind,
  trumpet:  :brass,
  violin:   :string
}
```

```rb
inst_section[:oboe]     #=> 'woodwind'
inst_section[:cello]    #=> 'string'
inst_section[:bassoon]  #=> nil
```

你可以在调用方法时将 hash 作为参数。 Ruby 允许你省略大括号， 但是只有在 hash 是最后一个参数时才行。 Rails 扩展了这个用法。 下面的代码段展示了两个元素的 hash 被传入 *redirect_to()* 方法。 注意这和 Ruby 2.0.0 的语法一致， 但它可以在 Ruby 1.9.3 内用：

```rb
redirect_to action: 'show', id: product.id
```

#### Regular Expressions

正则允许你指定字符串模式来匹配字符串。 在 Ruby 中， 你可以 */pattern/* 或 *%r{pattern}* 。

例如， 我们可以使用 */Perl|Python/* 来匹配文本内有 *Perl* 或 *Python* 的字符串。

```rb
if line =~ /P(erl|ython)/
  puts "There seems to be another scripting language here"
end
```

用 *=~* 来匹配操作符来匹配。


### Logic

#### 控制结构

```rb
if count > 10
  puts "Try again"
elsif tries == 3
  puts "You lose"
else
  puts "Enter a number"
end

# or while

while weight < 100 and num_pallets <= 30
  pallet = next_pallet()
  weight += pallet.weight
  num_pallets += 1
end
```

Ruby 也有一些变量 *unless* 和 *if* 相似， 用于检查条件不为真。 *until* 类似于 *while* ， 直到条件为真。

声明修饰符的简写：

```rb
puts "Danger, Will Robinson" if radiation > 3000
distance = distance * 1.2 while distance < 100
```

#### Blocks, Iterators

代码块存在于大括号内或 *do...end* 中间。 一项平常的约定是单行用大括号， 多行用块：

```rb
{ puts "Hello" }    # this is a block

do                  ###
  club.enroll(person) # and so is this
  person.socialize    #
end                 ###
```   

给方法传入一个块， 在参数后放置块就行啦：

```rb
greet { puts "Hi" }

# has parameters
verbose_greet("Dave", "loyal customer") { puts "Hi" }
```

一个方法可以通过 *yield* 语句来多次调用一个相的块。

```rb
animals = %w( ant bee cat dog elk ) # create an array
animals.each {|animal| puts animal } # iterate over the contents

3.times { print "Ho! " } #=> Ho! Ho! Ho!
```

*&* 前缀操作符允许方法捕获一个传入的块作为参数：

```rb
def wrap &b
  print "Santa says: "
  3.times(&b)
  print "\n"
end

wrap { print "Ho! " } # Santa says: Ho! Ho! Ho!
```

#### Exceptions

异常来自异常对象或它的子类。 *raise* 方法产生一个出现的异常。

```rb
begin
  content = load_blog_data(file_name)
rescue BlogDataNotFound
  STDERR.puts "File #{file_name} not found"
rescue BlogDataFormatError
  STDERR.puts "Invalid blog data in #{file_name}"
rescue Exception => exc
  STDERR.puts "General error loading #{file_name}: #{exc.message}"
end
```

*rescue* 可以直接处理最外层的定义方法， 且不需要闭合内容块。

### Organizing Structures

Ruby 对组织方法有两个基本的概念： 类， 模块。

#### 类

```rb
1 class Order < ApplicationRecord
-   has_many :line_items
-   def self.find_all_unpaid
-     self.where('paid = 0')
5   end
-   def total
-     sum = 0
-     line_items.each {|li| sum += li.total}
-     sum
10  end
- end
```

类定义以 *class* 关键字开始，然后是类名(首字母必须大写)。 *Order* 类为 *ApplicationRecord* 的子类。

Rails 严重使用类级声明。 *has_many* 是活动记录定义的方法。 它被 *Order* 类所调用。 一般来说， 这些方法会断言类， 我们叫做声明。

在类中你可以定义类方法及实例方法。 *self.* 前缀的方法为类方法。 它们一般被类调用。 本例中， 我们可在任何地方这样调用这个方法：

```rb
to_collect = Order.find_all_unpaid
```

类对象有它自己的实例变量。 这些变量以 *@* 开始， 所有这个类的实例都可访问。 每个对象有它自己的一套实例变量。

实例变量不能再类外直接被访问。 可以使用方法来访问到：

```rb
class Greeter
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end
end

g = Greeter.new("Barney")
g.name    # => Barney
g.name = "Betty"
g.name    # => Betty
```

Ruby 提供了一种方便的方法来写这些获取方法：

```rb
class Greeter
  attr_accessor :name     # create reader and writer methods
  attr_reader   :greeting # create reader only
  attr_writer   :age      # create writer only
end
```

类的实例方法默认是公共的； 可以被重写：

```rb
class MyClass
  def m1    # this method is public
  end
  protected
  def m2    # this method is protected
  end
  private
  def m3    # this method is private
  end
end
```

*private* 指令是最严格的； 私有方法只能在相同的实例内调用， Protected 方法可以在相同的实例或其他相同类的实例中调用。

#### Modules

模块有点像拥有方法， 常量， 模块及类定义的集合类， 当然你不能像创建类一样基于模块创建对象。

模块有两个目的： 提供命名空间， 共享类的功能。

辅助方法就是 Rails 使用模块的一个实例。

例如你想为 store 控制器写一个辅助方法需要这样命名 *store_helper.rb* 在 *app/helpers* 内：

```rb
module store_helper
  def capitalize_words(string)
    string.split(' ').map{|word| word.capitalize}.join(' ')
  end
end
```

#### YAML
YAML 是一个递归缩写。 在 Rails 中， YAML 是一种配置东东的简便方式。

```rb
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000
```

YAML 的缩进很重要， 这里定义了一个开发环境， 它有四个键值对以冒号分割。

### Marshhaling Objects

Ruby 可以拿到对象并把它转换为 Bytes 流放在方程式外。 这个过程就叫封送。

封送时有两个问题， 一是绑定内的对象在摧毁时会出现错误， 二是当你加载一个封送时 Ruby 需要知道这个对象类的定义。

Rails 使用封送来储存会话数据。


### Pulling It All Together

```rb
class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
```
