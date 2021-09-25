@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: b_aim.s
@ description:  calculates b aim
@ r0 contains Rx
@ r1 contains ry
@ r2 contains dx
@ r3 contains dy
@ returns
@ r0 b aim
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global b_aim
.text				
b_aim:  
	vmov s1,r0 @Rx
	vmov s2,r1 @Ry
	vmov s3,r2 @Dx
	vmov s4,r3 @Dy
	VADD.F32 s5, s1, s3	 @(Rx+Dx)
	VADD.F32 s6,s2,s4     	 @(Ry + Dy)
	VDIV.F32 s7,s6,s5	 @ (Ry+Dy)/(Rx+Dx)
	vmov	r0,s7
done:
	bx lr
.end
	