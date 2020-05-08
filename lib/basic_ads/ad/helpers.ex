defmodule TSVectorType do
  @behaviour Ecto.Type

  def type, do: :tsvector

  def cast(tsvector), do: {:ok, tsvector}
  def load(tsvector), do: {:ok, tsvector}
  def dump(tsvector), do: {:ok, tsvector}
end

