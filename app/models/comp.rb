module Comp
  #----------------------------------------------------------------------------
  # Calculate two values with given operator
  # Params: Integer, Integer, Symbol(:+ or :-)
  # Return: Integer
  #----------------------------------------------------------------------------
  def calc(first_value, second_value, operator)
    first_value.send(operator, second_value)
  end
end
