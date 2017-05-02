class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "results"

  field :bib, type: Integer
  field :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, type: Placing
  field :group, type: Placing

  embeds_many :results, class_name: "LegResult", order: [:"event.o".asc], after_add: :update_total

  def update_total(result)
  	self.secs = results.reduce(0) do |total, result|
  		total + result.secs.to_i
  	end
  end
end
