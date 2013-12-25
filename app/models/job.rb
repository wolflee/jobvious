class Job < ActiveRecord::Base
  belongs_to :user
  has_many :applications

  validates :title, presence: true
  validates :description, presence: true
  validates :contact, presence: true
  validates :company, presence: true

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true) do
      query { string params[:q] } if params[:q].present?
      #not quite working here, tire to blame
      #highlight :title, :description, options: { tag: '<strong class="highlight">' }
      sort { by :created_at, 'desc' }
      page = (params[:page] || 1).to_i
      search_size = params[:per_page] || 20
      from (page - 1) * search_size
      size search_size
    end
  end

  after_save do
    tire.update_index
  end

  mapping do
    indexes :id,          index: :not_analyzed
    indexes :title,       type: 'string', analyzer: 'snowball'
    indexes :location,    type: 'string', analyzer: 'snowball'
    indexes :description, type: 'string', analyzer: 'snowball'
    indexes :contact,     type: 'string', analyzer: 'snowball'
    indexes :company,     type: 'string', analyzer: 'snowball'
    indexes :url,         type: 'string', analyzer: 'simple'
    indexes :created_at,  type: 'date',   include_in_all: false
  end
end
