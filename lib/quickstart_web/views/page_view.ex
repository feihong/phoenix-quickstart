defmodule QuickstartWeb.PageView do
  use QuickstartWeb, :view

  def random_hanzi() do
    for n <- 1..10 do
      ordinal = Enum.random(0x4e00..0x9fff)
      {n, ordinal, List.to_string([ordinal])}
    end
  end
end
