@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: Sine.s
@ description:  calculates sine in radians of angle stored in r0
@ r0 contains x
@ s0 contains r0
@ s1 contains 1/3!
@ s2 contains 1/5!
@ returns
@ r0 sin x
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global sine
.text				
sine:
	VMOV.F32 s3, s0		@x IN S3
	VMUL.F32 s4, s3, s3 	@x^2 
	VMUL.F32 s4, s4, s3 	@x^3
	VMUL.F32 s4, s4, s1 	@x^3 * 1/3!
	VMUL.F32 s5, s3, s3	@X^2 
	VMUL.F32 s5, s5, s3 	@X^3	
	VMUL.F32 s5, s5, s3 	@X^4
	VMUL.F32 s5, s5, s3 	@X^5
	VMUL.F32 s5, s5, s2	@x^5 * 1/5!
	VSUB.F32 s3, s3, s4	@ x - x^3 * 1/3! 
	VADD.F32 s3, s3, s5	@ x - x^3 * 1/3! + x^5 * 1/5!
	VMOV.F32 s0, s3	
		
done:	vmov	r0,s0
	bx lr
.end
		
		 