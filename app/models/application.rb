class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  validates :resume, presence: true

  mount_uploader :resume, ResumeUploader
end
