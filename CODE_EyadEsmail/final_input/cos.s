@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: cos.s
@ description:  calculates cos in radians of angle stored in r0
@ r0 contains x
@ s0 contains r0
@ s1 contains 1/2!
@ s2 contains 1/4!
@ s3 contains 1.000 
@ returns
@ r0 cos x
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global cos
.text				
cos:
	VMUL.F32 s4, s0	,s0	@x^2 IN S4
	VMUL.F32 s4, s4, s1 	@x^2 * 1/2!
	VMUL.F32 s5, s0, s0	@X^2 
	VMUL.F32 s5, s5, s0 	@X^3	
	VMUL.F32 s5, s5, s0 	@X^4
	VMUL.F32 s5, s5, s2	@x^4 * 1/4!	
	VSUB.F32 s3, s3, s4	@ 1 - x^2 * 1/2! 
	VADD.F32 s3, s3, s5	@ 1 - x^2 * 1/2! + x^4 * 1/4!
	VMOV.F32 s0, s3	
		
done:	vmov	r0,s0
	bx lr
.end
		
		 