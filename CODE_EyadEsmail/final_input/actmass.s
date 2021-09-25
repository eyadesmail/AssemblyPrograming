@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: actmass.s
@ description:  calculates acuall mass
@ s1 contains L barrel
@ s2 contains M projectile
@ s3 contains kCharge
@ s4 has tflight corrected
@ s5 has #2
@ returns
@ r0 mass
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global actmass
.text				
actmass:
	VMUL.F32 s1,s1,s5	@2 x Lbarrel
	VMUL.F32 s1,s1,s2	@2 * LBarrel * M projectile
	VMUL.F32 s4,s4,s4	@tflight ^ 2
	VMUL.F32 s3,s3,s4	@Kcharge * Tflight ^2
	VDIV.F32 s6,s1,s3
		
done:
	vmov	r0,s6
	bx lr
.end
	