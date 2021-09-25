@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: r_aim.s
@ description:  calculates r aim
@ r0 contains Rx
@ r1 contains ry
@ r2 contains dx
@ r3 contains dy
@  contains 1.000 
@ returns
@ r0 raim
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global r_aim
.text				
r_aim:  vmov s1,r0 @Rx
	vmov s2,r1 @Ry
	vmov s3,r2 @Dx
	vmov s4,r3 @Dy
	VADD.F32 s5, s1, s3	 @(Rx+Dx)
	VMUL.F32 s5,s5 		 @(Rx+Dx)^2
	VADD.F32 s6,s2,s4     	 @(Ry + Dy)
	VMUL.F32 s6,s6		 @(Ry+Dy)^2
	VADD.F32 s7,s6,s5	 @(Rx+Dx)^2 + (Ry+Dy)^2
	VSQRT.F32 s8,s7
done:	vmov	r0,s8
	bx lr
.end
	