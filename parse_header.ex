defmodule ParseHeader do

  defmodule Header do
    defstruct [:header_type_flag, :granule_position, :bitstream_serial_number, :page_sequence_number, :crc_checksum, :page_segment, :segment_table]
  end

  # def create(header) do
  #   capture_pattern = "OggS"
  #   version = <<0>>
  # end

  def parse(header) do
    <<"OggS", <<0>>, header_type_flag::8, granule_position::64, bitstream_serial_number::32, page_sequence_number::32, crc_checksum::32, page_segment::8, segment_table::8>> = header
    %Header{header_type_flag: header_type_flag,
      granule_position: granule_position,
      bitstream_serial_number: bitstream_serial_number,
      page_sequence_number: page_sequence_number,
      crc_checksum: crc_checksum,
      page_segment: page_segment,
      segment_table: segment_table}
  end

  def print(header) do
    IO.inspect(parse(header))
  end
end

header1 = <<79, 103, 103, 83, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 185, 49, 196, 35, 0, 0, 0, 0, 189, 30, 84, 210, 1, 19>>
ParseHeader.print(header1)

header2 = <<79, 103, 103, 83, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 44, 76, 51, 105, 0, 0, 0, 0, 147, 123, 90, 82, 1, 19>>
ParseHeader.print(header2)
