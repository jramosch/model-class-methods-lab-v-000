class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where('id in (?)', sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
  end
end
