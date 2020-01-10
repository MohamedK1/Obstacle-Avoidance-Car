 Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity clean is 
generic (n:Integer:=116280 );
port(clk ,echo: in std_logic ;obstacle, trigger : out std_logic);
end clean; 


architecture func of clean is 
constant us20 : integer :=1000 ; 
constant ms100 : integer :=5000000;
signal counter_echo:Integer :=0;
signal counter_cycle : integer :=0;
signal notecho:std_logic;
signal output :std_logic:='0';
begin 
notecho<= not echo;
process (clk)
begin 

if (clk'event and clk='1') then 
	if(counter_cycle < us20) then 
		counter_cycle <= counter_cycle +1 ; 
		trigger <= '1';
	elsif (counter_cycle <= (ms100+us20)) then 
		counter_cycle<=counter_cycle +1;
		trigger <='0';
		if(echo='1')then
	--if(notecho='0')then
		
	counter_echo<=counter_echo+1;
		
		end if ;
	
	else --i finished my cycle
	
		counter_cycle <=0;
	--	if(counter_echo<116280)then-- 40 cm detection
	if(counter_echo<n)then-- 40 cm detection
		
	output<='1';
		else
		output<='0';
		end if;
	counter_echo<=0;
		
	end if;	
end if;



end process;
obstacle<=output;
end func; 
 