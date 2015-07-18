# == Schema Information
#
# Table name: media
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  description          :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  media_type           :integer
#  url                  :string(255)
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  content_updated_at   :datetime
#

class Image < Media
	
end
