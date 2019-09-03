// Write your modules here!
module alu(input [3:0]a,b, input [1:0]op, output [3:0]F);
  wire [3:0]F0,F1;
  wire c0;
  
  assign c0 = ~op[1]&op[0];
  
  assign F = (~op[1])?F1:F0;
  assign F1 = a+b+c0;
  assign F0 = (op[0])?a|b:a&b;
  
endmodule

module altonivel(input [3:0]a,b, input [1:0]op, output [3:0]F);
  wire [3:0]F0,F1;
  
  assign F = (op[1])?F1:F0;
  assign F1 = (op[0])?a|b:a&b;
  assign F0 = (op[0])?a+b+1:a+b;
  
endmodule

module stimulus;
    reg  [3:0] a,b;
    reg [1:0] c;
    wire [3:0] f1,f2;
    altonivel M1(a,b,c,f1);
    alu   M2(a,b,c,f2);
    integer i;     
    initial begin
                
    $monitor(" a=%d,b=%d c=%d f1 %d f2 %d",a,b,c,f1,f2);
      for (i=0; i < 1024 ; i=i+1)
	begin 
          a= i[9:6]; b = i[5:2]; c = i[1:0]; #1;
	  if ( f1 !== f2 ) $display("Falha ! a=%d b=%d c %d",a,b,c);
       	end  // for 
    end  // initial
     
endmodule
