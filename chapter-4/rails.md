## 概念
本地代码 <=> 持久层 => 数据库操作的封装 <=> 数据库， 文件

### 一对多， 多对多， 中间表
中间表用于多对多的映射， 起到枢纽的作用。

```rb
class Mother
  has_many :sons
end

class Son
  belong_to :mother
end

a = Son.first => select * from Sons where id = 1
mama = a.mother

select * from mothers
  join sons
  on sons.mother_id = mothers.id
  where sons.id = 1
```

一对一
```rb
class Mother
  belong_to :father
end

class Father
  has_one :mother
end
```

多对多, 利用中间表提供映射

```sql
select teachers.*, students.*, lessons.* from lessons

  join teachers
  on lessons.teacher_id = teachers.id

  join students
  on lessons.student_id = students.id

  where students.name = 'a'
```

```rb
class Student
  has_many :lessons
  has_many :teachers, :through => :lessons

  #has_many :teachers, :class => 'Teachers', :foreign_key => 'teacher_id', :through => :lessons
end

class Teacher
  has_many :lessons
  has_many :students, :through => :lessons
end

# 查找
Student.find_by_name('a').teachers
Teacher.find_by_name('t').students
```


### 控制器

```rb
def index
  name = params[:name]
  @books = Books.where("name is '%#{name}%'")
end
```

```html
<form  action="index.html" method="post">
  <input type="text" name="teacher_name" value="">
  <input type="submit" value="submit">
</form>
```

```rb
def create
  Teacher.create :name => params[:teacher_name]
  # render :text => 'ok'
  redirect_to books_path
end
```


```
  <% @teachers.each do |t| %>
    <%= t.inspect%>
    <%= link_to 'deit', edit_book_path(:id => t.id)%>
    <%= link_to 'delete', "/book/#{t.id}", :method => 'delete'%>
  <%end%>
```

三种写法查询对象

```rb
def edit
  @teacher = Teacher.where("id = #{params[:id]}").first
  @teacher = Teacher.where("id = ?", params[:id]).first
  @teacher = Teacher.find(params[:id])
end
```

### rails 多约定少配置

控制器定义接通模型与视图关系， 只定义逻辑操作。 在控制器内各种操作
模型与视图互通
辅助方法， destroy 方法特殊配置。


## 操作

为已存在的表添加索引

**rails g migration add_index_to_email_users**

在 db/migrate 文件内使用 add_index 方法， 并确定唯一性： unique: true

在读写操作前的预操作 before_save { email.downcase! } 全写为 { self.email = email.downcase }

在模型内添加密码哈希计算 has_secure_password 会在数据库内自动添加 password_digest 列。 在表单域内须有 password_digest 属性。 并且我们会获得 authenticate 方法， 密码正确返回对象否则为 false。

为了添加 password_digest 属性我们需要再次修改数据模型

rails g migration add_password_digest_to_users password_digest:string

为 users 添加 password_digest 列


bcrypt 无法载入的问题

1. gem uninstall bcrypt => uninstall all versions
2. gem i bcrypt --platform=ruby
3. add *gem 'bcrypt', platforms: :ruby* to Gemfile
