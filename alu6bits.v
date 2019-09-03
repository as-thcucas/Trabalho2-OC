// Write your modules here!
module alu(input [5:0]a,b, input [1:0]op, output [5:0]F);
  wire [5:0]F0,F1;
  wire c0,c1,c2;
  wire [5:0] And,Xor;
  
  assign c0 = ~(op[1] ^ op[0]);
  assign c1 = ~(op[1] ^ op[0]);
  assign c2 = op[1];
  
  assign Xor = {c2,c2,c2,c2,c2,c2} ^b;
  assign And = Xor & {c1,c1,c1,c1,c1,c1};
  
  assign F = (op[1]&~op[0])?F1:F0;
  assign F1 = a&b;
  assign F0 = a + And + c0;
  
endmodule

module altonivel(input [5:0]a,b, input [1:0]op, output [5:0]F);
  wire [5:0]F0,F1;
  assign F = (op[1])?F1:F0;
  assign F1 =(op[0])?a-b:a&b;
  assign F0 =(op[0])?a:a+b+1;

endmodule

module stimulus;
    reg signed [5:0] a,b;
    reg [1:0] c;
    wire signed [5:0] f1,f2;
    altonivel M1(a,b,c,f1);
    alu   M2(a,b,c,f2);
    integer i;     
    initial begin
                
    $monitor(" a=%d,b=%d c=%d f1 %d f2 %d",a,b,c,f1,f2);
      for (i=0; i < 16384 ; i=i+1)
	begin 
          a= i[13:8]; b = i[7:2]; c = i[1:0]; #1;
	  if ( f1 !== f2 ) $display("Falha ! a=%d b=%d c %d",a,b,c);
       	end  // for 
    end  // initial
     
endmodule
