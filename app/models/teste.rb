class Warehouse < ApplicationRecord
    attr_accessor :name, :code, :area

    def
    initialize(name:, code:, city:, area:)
    @name = name
    @code = code
    @city = city
    @area = area
end