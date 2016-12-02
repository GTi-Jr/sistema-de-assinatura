module BabiesHelper
  def baby_born_to_value(baby)
    baby.born? ? '1' : '0'
  end
end
