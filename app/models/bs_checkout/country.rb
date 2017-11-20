module BsCheckout
  class Country < ApplicationRecord
    default_scope { order(name: :asc) }
  end
end
