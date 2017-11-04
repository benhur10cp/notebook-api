class Contact < ApplicationRecord
  belongs_to :kind #, optional: true
  has_many :phones
  has_one :address
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  # def name_complete
  #   self.name + " " + self.email
  # end
  #
  # def kind_description
  #   self.kind.description
  # end
  #
  # def as_json(options={})
  #   super(methods: [:name_complete, :kind_description],
  #         root: true
  #         #include: {kind: {only: :description}}
  #         )
  # end

  # def to_br
  #   {
  #     name: self.name,
  #     email: self.email,
  #     birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #   }
  # end

  def as_json(options={})
    h = super(options)
    h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    h
  end
end
