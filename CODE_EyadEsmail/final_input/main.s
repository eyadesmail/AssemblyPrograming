.global main
.text				
main:

	bl	  getinput
	LDR 	  r0,   =Lbarrel
	LDR       r1,   =tbarrel
	LDR       r2,	=two
	VLDR.F32  S0,[R0]
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	VMUL.F32  s1,s1,s1		@t^2
	VMUL.F32  s0,s0,s2		@2L
	VDIV.F32  s3,s0,s1		@2l/t^2 = Aprojectile
	VLDR.F32  s1,[R1]
	VMUL.F32  s0,s3,s1		@Aproj * Tbarrel = velocity at S0
	vmov r11,s0	
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@  r11 has velocity @@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#4]	
	LDR       r1,   =pidiv180
	bl	  to_rad		@converting br to radian stored in r0	
	LDR       r1,   =onefact2
	LDR       r2,   =onefact4
	LDR	  r3, 	=one
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	VLDR.F32  s3,[r3]
	bl        cos				
	mov 	  r10,r0
	vmov	  s0,r10
	vmov	  s1,r11
	VMUL.F32  s0,s0,s1		@v cos (br)
	vmov 	  r10,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@  r10 has Vxy      @@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#4]	
	LDR       r1,   =pidiv180
	bl	  to_rad	
	LDR       r1,   =onefact3
	LDR       r2,   =onefact5
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	bl	  sine
	mov 	  r9,r0
	vmov	  s0,r9
	vmov	  s1,r11
	VMUL.F32  s0,s0,s1		@V sin (br)
	vmov 	  r9,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@    r9 has Vz      @@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	vmov	  s0,r9
	LDR       r1, =two
	LDR       r2, =ninepointeight
	VLDR.F32  s1,[r1]
	VLDR.F32  s2,[r2]
	VMUL.F32  s3,s0,s1
	VDIV.F32  s4,s3,s2
	vmov	  r8,s4
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@ tflight uncrr in r8 @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	vmov 	  s0,r8
	vmov	  s1,r10
	VMUL.F32  s0,s0,s1
	vmov	  r7,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@ Rproj uncrr in r7   @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
	LDR 	  r0,   [r12,#4]	
	LDR       r1,   =pidiv180
	bl	  to_rad		@converting br to radian stored in r0	
	LDR       r1,   =onefact2
	LDR       r2,   =onefact4
	LDR	  r3, 	=one
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	VLDR.F32  s3,[r3]
	bl        cos	
	vmov      s5,r7
	VMUL.F32  s0,s0,s5
	vmov	  r6,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@      Rx  in r6      @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#4]	
	LDR       r1,   =pidiv180
	bl	  to_rad	
	LDR       r1,   =onefact3
	LDR       r2,   =onefact5
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	bl	  sine
	vmov	  s5,r7
	VMUL.F32  s0,s0,s5
	vmov	  r5,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@      Ry  in r5      @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#8]
	VLDR.F32  s0,[R0]
	vmov 	  s1, r8
	VMUL.F32  s0,s0,s1
	vmov 	  r4,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@       D  in r4      @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#12]	
	LDR       r1,   =pidiv180
	bl	  to_rad		@converting br to radian stored in r0	
	LDR       r1,   =onefact2
	LDR       r2,   =onefact4
	LDR	  r3, 	=one
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	VLDR.F32  s3,[r3]
	bl 	  cos	
	vmov	  s4,r4
	VMUL.F32  s0,s0,s4
	vmov	  r7,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@       Dx  in r7     @@@@@@@	replacing R projectile with Dx 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	LDR 	  r0,   [r12,#12]	
	LDR       r1,   =pidiv180
	bl	  to_rad	
	LDR       r1,   =onefact3
	LDR       r2,   =onefact5
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	bl	  sine
	vmov 	  s4,r4
	VMUL.F32  s0,s0,s4
	vmov	  r9,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@       Dy  in r9     @@@@@@@	replacing Vz with Dy 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	mov	  r0,r6
	mov	  r1,r5
	mov 	  r2,r7
	mov 	  r3,r9
	bl 	  r_aim
	mov	  r12,r0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@     Raim  in r12    @@@@@@@	 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	mov 	  r0,r6
	mov	  r1,r5
	mov 	  r2,r7
	mov	  r3,r9
	bl	  b_aim
	LDR       r1,   =onediv3
	LDR       r2,   =onediv5
	VLDR.F32  s1,[R1]
	VLDR.F32  s2,[r2]
	bl	  arctan
	LDR 	  r1, = oneeightydivpi
	VLDR.F32  s1,[R1]
	bl	  to_deg
	mov	  r3,r12		@raim in r3
	ldr 	  r12,=mymem
	str	  r0,[r12]		@stores value of bearing in memory slot 1
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@  bearing in memory  @@@@@@@	 
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	vmov 	  s0,r4			@D
	vmov	  s1,r11		@Vinit
	vmov	  s2,r8			@tflight uncorrected
	VDIV.F32  s0,s0,s1		@d/Vinit
	VADD.F32  s0,s0,s2		@D/vinit+tflight uncorrected
	vmov	  r8,s0
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@    tflight in r8    @@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	vmov 	  s0,r3
	vmov	  s1,r10
	vmov	  s2,r8
	bl	  elev
	LDR 	  r1,=piovertwo
	VLDR.F32  s1,[R1]
	vmov 	  r1,s1
	LDR 	  r1,=onedivsix
	VLDR.F32  s2,[R1]
	vmov 	  r1,s2
	LDR 	  r1,=threedivfourty
	VLDR.F32  s3,[R1]
	vmov 	  r1,s3
	bl	  arccos
	LDR 	  r1, = oneeightydivpi
	VLDR.F32  s1,[R1]
	bl	  to_deg
	str	  r0,[r12,#4]		@stor elev aim in memory slot 4
	ldr	  R1, = Lbarrel
	VLDR.F32  s1,[R1]		@s1 has lbarrel
	LDR	  R1, = Mprojectile
	VLDR.F32  s2,[R1]		@s2 has Mprojectile
	LDR	  R1, = kcharge
	VLDR.F32  s3,[R1]		@s3 has kcharge
	VMOV	  s4,R8	
	LDR	  R1, = two
	VLDR.F32  s5,[R1]		@s3 has kcharge
	bl 	  actmass
	str	  r0,[r12,#8]
	ldr 	  r3,[r12]
	ldr	  r5,[r12, #4]
	ldr 	  r7,[r12, #8]	
	bl 	  myout	

done:	mov r0,#0
	mov r7,#1
	svc 0

.data 

@sample input data

rng:.float 43761.12
br: .float 12.21
sp: .float 22.33
dir:.float 55.2

@project constants

kcharge: .float 200e6
Lbarrel: .float 10
Mprojectile: .float 100
tbarrel: .float 0.10
@calculation data for sine,cosine etc. 
oneeightydivpi: .float 57.29577951
one: .float 1.0000000
two: .float 2.0000000
ninepointeight: .float 9.8
onefact2: .float 0.5
onefact3: .float 0.166666667
onefact4: .float 0.04166666667
onefact5: .float 8.3333333e-3
pidiv180: .float 0.01745329252
onediv3 : .float 0.33333333333333
onediv5 : .float 0.20
threedivfourty: .float 0.075
onedivsix: .float 0.1666666666667
piovertwo: .float 1.570796327

@ output strings
@tar: .asciz "Tar: \n"
@BR : .asciz "Br: \n"
@EV : .asciz "Ev: \n"
@CRG: .asciz "CRG: \n"
@nline: .asciz " \n"

@memory
mymem: .word 0,0,0,0,0,0,0,0
.end

