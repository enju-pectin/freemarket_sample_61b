class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  def self.search(search_word)
    Product.where(['name LIKE ? OR description LIKE ?', "%#{search_word}%", "%#{search_word}%"])
  end

  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_expense
  belongs_to_active_hash :delivery_method
  belongs_to_active_hash :area
  belongs_to_active_hash :shipdate

  has_many :photos, dependent: :destroy
  belongs_to_active_hash :status
  has_one :transaction_record
  has_many :photos, dependent: :delete_all
  
  accepts_nested_attributes_for :category, allow_destroy: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :brand, allow_destroy: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: true
  validates :size_id, presence: true
  validates :condition_id, presence: true
  validates :delivery_expense_id, presence: true
  validates :delivery_method_id, presence: true
  validates :area_id, presence: true
  validates :shipdate_id, presence: true
  validates :price, presence: true, inclusion: 300..9999999


  def previous
    user.products.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    user.products.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end  
end
