library ieee;
use ieee.std_logic_1164.all;

entity dec2to4 is
  port (
    input  : in  std_logic_vector(1 downto 0);
    output : out std_logic_vector(3 downto 0));
end dec2to4;

-- Implement the decoder using a with-select statement

architecture WITH_SELECT of dec2to4 is
begin
	with input select
		output <= "0001" when "00",
			  "0010" when "01",
			  "0100" when "10",
			  "1000" when others;
		        

end WITH_SELECT;

-- Implement the decoder using a when-else statement

architecture WHEN_ELSE of dec2to4 is
begin
	output <= "0001" when input = "00" else 
		  "0010" when input = "01" else
		  "0100" when input = "10" else 
		  "1000" when input = "11" else
		  "0000";

end WHEN_ELSE;

-- Implement the decoder using an if statement

architecture IF_STATEMENT of dec2to4 is
begin
	process(input)
	begin
		if ( input="00")    then
			output <= "0001";

		elsif ( input="01") then
			output <= "0010";
			
		elsif ( input="10") then
			output <= "0100";

		else    output <= "1000";
		end if;
	end process;

        end IF_STATEMENT;

-- Implement the decoder using a case statement

architecture CASE_STATEMENT of dec2to4 is
begin
process(input)
begin
case input is
when "00" => 
	output <="0001"; 
when "01" => 
	output <= "0010"; 
when "10" => 
	output <= "0100"; 
when "11" => 
	output <= "1000";
when others => 
	null;
end case;
end process;
end CASE_STATEMENT;
