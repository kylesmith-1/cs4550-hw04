defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  #Returns Pirority of operator
  def op_priority(op) do
    cond do
      op == "+" or op == "-" -> 0
      op == "*" or op == "/" -> 1
      true -> -1
    end
  end

  #Returns :op or :num
  def op_or_num(str) do
    if str == "+" or str == "-" or str == "*" or str == "/" do
      :op
    else
      :num
    end
  end

  def toPostfix(keyList, stack, postfix) do
    if keyList == [] do
      postfix ++ stack
    else
      curKey = elem(hd(keyList), 0)
      curVal = elem(hd(keyList), 1)
      if curKey == :num do #number
        toPostfix(tl(keyList), stack, postfix ++ [curVal])
      else #operator
        cond do
          stack != [] and op_priority(curVal) <= op_priority(hd(stack)) -> toPostfix(keyList, tl(stack), postfix ++ [hd(stack)])
          true -> toPostfix(tl(keyList), [curVal | stack], postfix)
        end
      end
    end
  end

  def evalPostfix(postfix, stack) do
    if postfix == [] do
      hd(stack)
    else
      cur = hd(postfix)
      if (op_or_num(cur) == :num) do #num
        evalPostfix(tl(postfix), [parse_float(cur) | stack])
      else #op
        val1 = (hd(stack))
        val2 = (hd(tl(stack)))
        cond do
          cur == "+" -> evalPostfix(tl(postfix), [val2 + val1 | tl(tl(stack))])
          cur == "-" -> evalPostfix(tl(postfix), [val2 - val1 | tl(tl(stack))])
          cur == "*" -> evalPostfix(tl(postfix), [val2 * val1 | tl(tl(stack))])
          cur == "/" -> evalPostfix(tl(postfix), [val2 / val1 | tl(tl(stack))])
        end
      end
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(fn(x) -> {op_or_num(x), x} end)
    |> toPostfix([], [])
    |> evalPostfix([])

    #|> hd
    #|> parse_float
    #|> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
