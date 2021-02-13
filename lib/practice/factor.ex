defmodule Practice.Factor do
  def factor(divisor, dividend) do
    cond do
      dividend / divisor == 1 -> [divisor]
      rem(dividend, divisor) == 0 -> [divisor | factor(divisor, div(dividend, divisor))]
      true -> factor(divisor + 1, dividend)
    end
  end
end

