library ieee;
use ieee.std_logic_1164.all;
Entity mainLogic is 
port( clk ,echoFront,echoBack,echoLeft,echoRight :IN STD_logic;
	control :out std_logic_vector(5 downto 0);
	triggerFront,TriggerBack,TriggerLeft,TriggerRight :out STD_logic;
	buzzer,frontSensor,leftSensor,rightSensor,backSensor:out std_logic;
	enable : IN std_logic;
	outenable : out std_logic);
	end mainLogic;
Architecture func of mainLogic is 
component clean is 
generic (n:Integer:=116280 );
port(clk ,echo: in std_logic ;obstacle, trigger : out std_logic);
end component; 

signal obstacleFront,ObstacleBack,obstacleLeft,obstacleRight:std_logic;
signal obstacleArr:std_logic_vector(2 downto 0);-- front back left right
begin
front: clean  generic map (n=>160000)-- 55 cm
port map (clk,echoFront,obstacle=>obstacleFront,trigger=> triggerFront);


back: clean generic map(n=>16000)-- 55 cm
			port map (clk,echoBack,obstacle=>obstacleBack,trigger=> triggerBack);
			
			
leftSen: clean generic map(n=>87210)--35 cm
port map (clk,echoLeft,obstacle=>obstacleLeft,trigger=> triggerLeft);

rightSen : clean generic map(n=>72674)-- 25 cm
port map (clk,echoRight,obstacle=>obstacleRight,trigger=> triggerRight);

frontSensor<=obstacleFront;
leftSensor<=obstacleleft;
rightSensor<=obstacleright;
backSensor<=obstacleback;


obstacleArr<=(obstacleFront or ObstacleBack)&obstacleLeft&obstacleRight;
outEnable <='1';



process(obstacleArr,enable)
begin 

if(enable='1')then

if(obstacleArr="000" or obstacleArr ="011" )then 
control <="110101";--forward
buzzer<='0';

elsif(obstacleArr="001"   )then
control <="000101";--soft Left
buzzer<='0';

elsif(obstacleArr="010" or obstacleArr="100" )then
control <="110000";--soft right
buzzer<='0';

elsif( obstacleArr="101" )then

control<="101101"; --sharp left
buzzer<='0';

elsif(obstacleArr="110")then
control<="110011"; --sharp right
buzzer<='0';

else
control<="111111";
buzzer<='1'; --stop u can replace it with 100001 it's the same thing force stop 
end if;

else
control<="111111";
buzzer<='0';

end if;
end process;
end func;
	