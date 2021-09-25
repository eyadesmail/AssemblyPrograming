@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: to_rad.s
@ description: converts angle to radian
@ r0 contains x
@ r1 contains pi/180
@ returns
@ r0 rad x
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


.global to_rad
.text				
to_rad:	@push {r1}	
	@LDR r1, = pidiv180	@load value pi/180
	VLDR.F32 S0,[R0]	@send x to s registers
	VLDR.F32 S1,[R1]	@send pi/180 to s registers
	VMUL.F32 S0,S1		@mult pi/180 by x	
done:	vmov	r0,s0
	@pop {r1}
	bx lr
.end
		
		 