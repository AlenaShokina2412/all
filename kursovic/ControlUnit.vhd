library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
	
	entity ControlUnit is
		port(
			X		:in	std_logic_vector(2 downto 0);	--Логические условия
			kop 	:in   std_logic;	-- Кодоперации
			sno	:in	std_logic;	-- Сигнал начала операции
			reset	:in	std_logic;	-- Сигнал сброса
			clk	:in	std_logic;	-- Синхросигнал
			Y		:out	std_logic_vector(4 downto 0);	-- Управляющие сигналы
			sko	:out	std_logic	-- Сигнал окончания операции
		);	
	end entity;
	architecture rtl of ControlUnit is
		type state_type is(s0, s1, s2, s3, s4);	-- Состояния автомата
		signal state :state_type;	-- Текущее состояние
	
	begin
		process(clk, reset)	-- Процесс формирования следующего состояния автомата
		begin
			if reset= '1' then	-- Сброс автомата в начальное состояние
				state<= s0;
			elsif (rising_edge(clk)) then	-- По восходящему фронту синхросигнала
				case state is
					when s0 =>
						if sno= '1' then	-- Сигнал начала операции
							state<= s1;
						else
							state<= s0;
						end if;
					when s1 =>
						if kop = '1' then	
							state<= s2;
						else
							state<= s4;
						end if;					
					when s2 =>
						if  x(0)='1' then
							state<= s3;	
						else 
							state<= s3;
						end if;
					when s3 =>
						if X(1) = '0' then
							state<= s2;
						elsif X(1) = '1' AND X(2) = '0'  then
							state<= s4;
						elsif X(1) = '1' AND X(2) = '1'  then
							state<= s4;
						end if;	
					when s4 =>
						state<= s0;	
				end case;
			end if;
		end process;
	
	
		process(state, X, sno, kop)	-- Процесс формирования управляющих сигналов
		begin
			case state is
			when s0 =>
						if sno= '1' then	-- Сигнал начала операции
							Y <="00001";	-- Пропуск такта
						else
							Y <="00000";	-- Пропуск такта
						end if;
						sko <= '0';
					when s1 =>
						if kop = '0' then	
							Y <="10000";	-- Пропуск такта
						else
							Y <="00000";	-- Пропуск такта
						end if;					
					when s2 =>
						if  x(0)='1' then
							Y <="00010";	-- Пропуск такта
						else 
							Y <="00000";	-- Пропуск такта
						end if;
					when s3 =>
						if X(1) = '0' then
							Y <="00100";	-- Пропуск такта
						elsif X(1) = '1' AND X(2) = '0'  then
							Y <="00000";	-- Пропуск такта
						elsif X(1) = '1' AND X(2) = '1'  then
							Y <="01000";	-- Пропуск такта
						end if;	
					when s4 =>
							Y <="00000";	-- Пропуск такта	
						sko<= '1';
			end case;
		end process;
	end rtl;
