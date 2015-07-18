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

require 'elasticsearch/model'


class Media < ActiveRecord::Base
  attr_accessible :description, :name, :url, :content, :public, :media_type
  
  belongs_to :user
  validates :name, :description, presence: true
  validates_inclusion_of :media_type, :in => [0, 1]
  validates :url, presence: true, :if => Proc.new {|media| media.media_type == 1}
  validates :content, presence: true, :if => Proc.new {|media| media.media_type ==0}

  has_attached_file :content
  validates_attachment_content_type :content, :content_type => /\Aimage/
  validates_attachment_file_name :content, :matches => [/png\Z/, /jpe?g\Z/]
  do_not_validate_attachment_file_type :content

  scope :videos, where(media_type: 1)
  scope :images, where(media_type: 0)
  scope :public, where(public: true)

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(options={})
    as_json(
      only: [:id, :name, :description]
    )
  end

  module Type
  	Video = 1
  	Image = 0
  end

  def is_image?
  	self.media_type == Type::Image
  end

  def is_video?
  	self.media_type == Type::Video
  end

  def video_id
  	self.url.split("=").last
  end
end

Media.import