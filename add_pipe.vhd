library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_pipe is
  generic (
    width  :     positive := 16);
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    en     : in  std_logic;
    in1    : in  std_logic_vector(width-1 downto 0);
    in2    : in  std_logic_vector(width-1 downto 0);
    output : out std_logic_vector(width downto 0));
end add_pipe;

-- TODO: Implement a behavioral description of a pipelined adder (i.e., an
-- adder with a register on the output). The output should be one bit larger
-- than the input, and should use the "width" generic as opposed to being
-- hardcoded to a specific value.

architecture BHV of add_pipe is
begin
 process(clk, rst)
	 variable temp_out : unsigned ( width downto 0 ); 
  begin
    if(rst = '1') then
      output <= (width downto 0 => '0');
      else
	      if(rising_edge(clk)) then
      if(en = '1') then
        temp_out := resize(unsigned(in2), width+1) + unsigned(in1);
	output <= std_logic_vector (temp_out(width downto 0 ));
      end if;
    end if;
    end if;
  end process;
end BHV;

