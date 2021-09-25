@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: elev.s
@ description:  calculates elev
@ r0 contains Raim
@ r1 contains vprojxy
@ r2 contains tflight corrected
@ returns
@ r0 to be processed in arccos 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global elev
.text				
elev:  
	VMUL.F32 s1, s1, s2	 @Vprojxy * tflight corrected
	VDIV.F32 s0,s0,s1     	 @raim / vprojxy * flight corrected
	vmov	r0,s0
done:
	bx lr
.end
	