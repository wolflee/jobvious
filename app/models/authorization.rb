class Authorization < ActiveRecord::Base
  belongs_to :user

  after_create :fetch_details

  # nice little trick saved for future
  def fetch_details
    self.send("fetch_details_from_#{self.provider.downcase}")
  end

  def fetch_details_from_linkedin
  end
end
