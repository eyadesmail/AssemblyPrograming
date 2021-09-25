@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: to_deg.s
@ description: converts angle to radian
@ r0 contains x
@ r1 contains 180/pi
@ returns
@ r0 rad x
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


.global to_deg
.text				
to_deg:		
	vmov	 S0,R0		@send x to s registers
	VMUL.F32 S0,S1		@mult 180/pi by x	
done:	vmov	 r0,s0
	bx lr
.end
		
		 