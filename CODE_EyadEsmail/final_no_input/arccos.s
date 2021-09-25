@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: arccos.s
@ description:  calculates arccos in radians of angle stored in r0
@ r0 contains x
@ s0 contains r0
@ s1 contains pi/2
@ s2 contains 1/6
@ s3 contains 3/40
@ returns
@ r0 arctan x
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global arccos
.text				
arccos:
	vmov	 s0, r0
	VMUL.F32 s5, s0, s0	@x^2
	VMUL.F32 s5, s5, s0 	@x^3 
	VMUL.F32 s5, s5, s2 	@x^3 * 1/6
	VMUL.F32 s6, s0, s0 	@x^2
	VMUL.F32 s6, s6, s0	@x^3
	VMUL.F32 s6, s6, s0	@x^4
	VMUL.F32 s6, s6, s0	@x^5
	VMUL.F32 s6, s6, s3	@x^5 * 3/40
	VADD.F32 s0, s0, s5	@ x + x^3*1/6
	VADD.F32 s0, s0, s6	@ x + x^3*1/6 + x^5*3/40
	VSUB.F32 s1, s1, s0	@ pi/2 - (x + x^3*1/6 + x^5*3/40)
	VMOV.F32 s0, s1
		
done:
	vmov	r0,s0
	bx lr
.end
		
		 