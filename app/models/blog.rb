class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :author, class_name: 'User', inverse_of: :blogs

  field :title, type: String
  field :content, type: String
  field :status, type: String, default: 'draft'
  field :published_date, type: DateTime

  validates :title, :author_id, presence: true
  validates :status, inclusion: { in: ['draft', 'published'] }

  before_save :set_published_date

  private

  def set_published_date
    self.published_date = DateTime.now if status == 'published' && published_date.nil?
  end
end
