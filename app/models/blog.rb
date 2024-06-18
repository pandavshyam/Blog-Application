class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :author, class_name: 'User', inverse_of: :blogs
  has_many :comments

  field :title, type: String
  field :content, type: String
  field :status, type: String, default: 'draft'
  field :published_date, type: DateTime

  mount_uploader :asset, AssetUploader

  validates :title, :author_id, :content, presence: true
  validates :title, length: { maximum: 255 }
  validates :content, length: { maximum: 2056 }
  validates :status, inclusion: { in: ['draft', 'published'] }

  before_save :set_published_date

  private

  def set_published_date
    self.published_date = DateTime.now if status == 'published' && published_date.nil?
  end
end
