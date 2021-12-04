defmodule Membrane.Ogg.Payloader do
  @moduledoc """
  This module holds various helper functions for all of the different Ogg payloaders.

  It should not be used directly.
  """

  use Bitwise, only_operators: true

  alias __MODULE__.Native

  def init(random_serial_number?) do
    if random_serial_number? do
      stream_identifier() |> Native.create()
    else
      Native.create(4_210_672_757)
    end
  end

  def make_pages(buffer, native, position, packet_number, header_type) do
    Native.make_pages(
      buffer,
      native,
      position,
      packet_number,
      encode_header_type(header_type)
    )
  end

  def flush(native) do
    Native.flush(native)
  end

  def make_pages_and_flush(buffer, native, position, packet_number, header_type) do
    with {:ok, page} <- make_pages(buffer, native, position, packet_number, header_type),
         {:ok, flushed} <- flush(native) do
      {:ok, page <> flushed}
    end
  end

  defp encode_header_type(header_type) do
    case header_type do
      :cont -> 0
      :bos -> 1
      :eos -> 2
    end
  end

  defp stream_identifier do
    :rand.uniform(1 <<< 32) - 1
  end
end
