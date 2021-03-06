class Species < ActiveRecord::Base
  extend FriendlyId
  include ResourceName
  include ResourcePaths
  include LastUpdate
  include AuditCommentable

  GROWTH_TYPES = %w(single group)
  NUTRITIVE_GROUPS = %w(parasitic mycorrhizal saprotrophic parasitic-saprotrophic saprotrophic-parasitic)
  NAME_GENUS_VALIDATION_ERROR = '- genus combination must be unique'
  GROWTH_TYPE_VALIDATION_ERROR = "has to be one of: #{GROWTH_TYPES.inspect}"
  NUTRITIVE_GROUPS_VALIDATION_ERROR = "has to be one of: #{NUTRITIVE_GROUPS.inspect}"

  SYSTEMATICS = [:name, :genus, :familia, :ordo, :subclassis, :classis, :subphylum, :phylum]
  PUBLIC_FIELDS = [:name, :genus, :familia, :ordo, :subclassis, :classis, :subphylum, :phylum, :synonyms, :growth_type, :nutritive_group, :square_pic]

  has_many :characteristics, dependent: :destroy
  has_many :specimens

  audited except: [:url]
  mount_uploader :square_pic, SquarePicUploader

  before_validation :generate_url

  friendly_id :url

  self.per_page = 20

  validates :name, presence: true, uniqueness: { scope: :genus, case_sensitive: false, message: NAME_GENUS_VALIDATION_ERROR }
  validates :genus, presence: true
  validates :familia, presence: true
  validates :ordo, presence: true
  validates :subclassis, presence: true
  validates :classis, presence: true
  validates :subphylum, presence: true
  validates :phylum, presence: true
  # validates :url, presence: true, uniqueness: true

  validates :growth_type, allow_blank: true, inclusion: { in: GROWTH_TYPES, message: GROWTH_TYPE_VALIDATION_ERROR }
  validates :nutritive_group, allow_blank: true, inclusion: { in: NUTRITIVE_GROUPS, message: NUTRITIVE_GROUPS_VALIDATION_ERROR }

  class << self
    def with_systematics(s)
      s ? where('genus = ? or familia = ? or ordo = ? or subclassis = ? or classis = ? or subphylum = ? or phylum = ?', s, s, s, s, s, s, s) : where({})
    end

    def with_nutritive_group(ng)
      ng ? where(nutritive_group: ng) : where({})
    end

    def with_growth_type(gt)
      gt ? where(growth_type: gt) : where({})
    end
  end

  def full_name
    "#{self.genus} #{self.name}"
  end
  alias_method :resource_title, :full_name
  alias_method :audit_title, :full_name


  def systematics
    [:name, :genus, :familia, :ordo, :subclassis, :classis, :subphylum, :phylum].map { |s| self.send(s) }
  end

  def combined_characteristics(locale=I18n.locale)
    hash = {
      fruiting_body: [],
      microscopy: [],
      flesh: [],
      chemistry: [],
      note: [],
      habitats: [],
      substrates: [],
      edible: [],
      cultivated: [],
      poisonous: [],
      medicinal: []
    }

    characteristics_keys = hash.keys

    self.characteristics.each do |c|
      characteristics_keys.each do |key|
        unless c.send(key).blank?
          if Characteristic::FLAGS.include?(key) && c.send(key) || [:habitats, :substrates].include?(key)
            hash[key] << { value: c.send(key), reference_id: c.reference_id }
          elsif c.send(key).is_a?(Hash) && !c.send(key)[locale].blank?
            hash[key] << { value: c.send(key)[locale], reference_id: c.reference_id }
          end
        end
      end
    end

    hash
  end

  protected

  def generate_url
    self.url = "#{self.genus}-#{self.name}".strip.gsub(' ', '_').gsub('.', '').downcase
  end

end

# == Schema Information
#
# Table name: species
#
#  id                   :integer          not null, primary key
#  name                 :string(255)      not null
#  genus                :string(255)      not null
#  familia              :string(255)      not null
#  ordo                 :string(255)      not null
#  subclassis           :string(255)      not null
#  classis              :string(255)      not null
#  subphylum            :string(255)      not null
#  phylum               :string(255)      not null
#  synonyms             :text(65535)
#  growth_type          :string(255)
#  nutritive_group      :string(255)
#  url                  :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  square_pic           :string(255)
#  square_pic_reference :string(255)
#
# Indexes
#
#  index_species_on_url  (url)
#
