defmodule QuickstartWeb.PageView do
  use QuickstartWeb, :view

  @eyes "^ᵒ♥•ಠ°ಥ・$'" |> String.graphemes
  @mouths  "_◡ᴥ□Д益ェω" |> String.graphemes
  @cheeks "()[]{}《》【】||"
          |> String.graphemes
          |> Enum.chunk_every(2)

  def random_hanzi() do
    for _ <- 1..10 do
      ordinal = Enum.random(0x4e00..0x9fff)
      {ordinal, List.to_string([ordinal])}
    end
  end

  def random_faces() do
    for _ <- 1..10 do
      eye = Enum.random @eyes
      mouth = Enum.random @mouths
      [left, right] = Enum.random @cheeks
      Enum.join [left, eye, mouth, eye, right], ""
    end
  end
end
