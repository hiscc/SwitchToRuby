## 启动项目

### 创建 Rails 方程式

**rails new depot**


### 启动 SQLite 3 数据库

**rails generate scaffold Product title:string description:text image_url:string price: decimal**

创建商品表， 定义灭个属性的类型


```rb
#rails50/depot_a/db/migrate/20160330000001_create_products.rb

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

**rails db:migrate**

### 查看商品列表

**rails server**

**rails db:rollback**

### Validates

在 /app/models/p.rb 内添加验证

```rb
class P < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif\jpg\png)\Z}i, message: 'must be a URL for GIF'
  }
end
```

### Creating the Catalog Listing

**rails g controller Store index**

设置根节点为 store_index：

```rb
# config/routes.rb
Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  resources :ps
end
```

**rails dev:cache**

设置缓存
