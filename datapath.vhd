library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  generic (
    width     :     positive := 16);
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    valid_in  : in  std_logic;
    valid_out : out std_logic;
    in1       : in  std_logic_vector(width-1 downto 0);
    in2       : in  std_logic_vector(width-1 downto 0);
    in3       : in  std_logic_vector(width-1 downto 0);
    in4       : in  std_logic_vector(width-1 downto 0);
    output    : out std_logic_vector(width*2 downto 0));
end datapath;

-- TODO: Implement the structural description of the datapath shown in
-- datapath.pdf by instantiating your add_pipe and mult_pipe entities. You may
-- also use the provided reg entity, or you can create your own.

architecture STR of datapath is

	signal out_mult1_r : std_logic_vector (width*2-1 downto 0);
	signal out_mult2_r : std_logic_vector (width*2-1 downto 0);
	signal valid_in_r : std_logic;
	signal out_add : std_logic_vector (width*2 downto 0);

begin 
     multiplier_1: entity work.mult_pipe(BHV)
     generic map ( width => width )
   port map ( 
              clk => clk,
	      rst => rst,
	      en  => en,
	      in1 => in1,
	      in2 => in2,
	   output => out_mult1_r
   );

    multiplier_2: entity work.mult_pipe(BHV)
     generic map ( width => width )
   port map ( 
              clk => clk,
	      rst => rst,
	      en  => en,
	      in1 => in3,
	      in2 => in4,
	   output => out_mult2_r
   );

   

   process(clk,rst)
		   begin
			   if(rst ='1')then
				   valid_in_r <= '0';
			   elsif(rising_edge(clk))then
				   valid_in_r <= valid_in;
			   end if;
		   end process;

   adder_1 : entity work.add_pipe(BHV)
    generic map ( width => width*2 )
   port map (
              clk => clk,
	      rst => rst,
	      en  => en,
	      in1 => out_mult1_r,
	      in2 => out_mult2_r,
	   output => out_add
   );
output <= out_add;
 process(clk,rst)
		   begin
			   if(rst ='1')then
				   valid_out <= '1';
			   elsif(rising_edge(clk))then
				   valid_out <= valid_in_r;
			   end if;
		   end process;

 end STR;
