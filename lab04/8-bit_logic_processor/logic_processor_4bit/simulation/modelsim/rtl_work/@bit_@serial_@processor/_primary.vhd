library verilog;
use verilog.vl_types.all;
entity Bit_Serial_Processor is
    port(
        R               : in     vl_logic_vector(1 downto 0);
        Execute         : in     vl_logic;
        LoadA           : in     vl_logic;
        LoadB           : in     vl_logic;
        Reset           : in     vl_logic;
        Clk             : in     vl_logic;
        F               : in     vl_logic_vector(2 downto 0);
        Aval            : out    vl_logic_vector(7 downto 0);
        Bval            : out    vl_logic_vector(7 downto 0);
        AhexU           : out    vl_logic_vector(6 downto 0);
        AhexL           : out    vl_logic_vector(6 downto 0);
        BhexU           : out    vl_logic_vector(6 downto 0);
        BhexL           : out    vl_logic_vector(6 downto 0);
        LED             : out    vl_logic_vector(3 downto 0)
    );
end Bit_Serial_Processor;
