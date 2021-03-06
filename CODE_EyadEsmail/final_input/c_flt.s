@	Subroutine c_flt will convert input buffer to floating point format
@		R1: Points to string containing "real number" of form 123.456
@		LR: Contains the return address
@		R0: Returned with floating point value (converted from ASCII input string)
@		R1: Returned pointing to first character after number.
@		All register contents except R0 and R1 will be preserved.

	.global	c_flt		@ Enable linker to see subroutine entry point.
c_flt:	push	{R2-R6}		@ Save contents of registers R0 through R6.

@	Register usage in this subroutine
@		R0: Contents of next ASCII "digit" from input buffer
@		R1: Points to next byte in input buffer
@		R2: Number of digits right of decimal point
@		R3: Accumulated value of significant being constructed
@		R4: =10: Decimal base value needed to "shift" digits
@		R5: "Flag" (=1) indicating decimal point present

	mov	R2,#0		@ Count of number of digits right of decimal point
	mov	R3,#0		@ Initialize R3 for value of real number being converted.
	mov	R4,#10		@ Decimal, base 10, used to "shift" value in significant
	mov	R5,#0		@ 0 => no decimal point, 1 => decimal point encountered

@	Loop to read each of the significant digits of the floating point number

nxtdig:	ldrb	R0,[R1],#1	@ Load next character from input buffer.
	subs	R0,#'0'		@ Subtract the ASCII character bias.
	blt	notdig		@ Check if end of string of digits has been reached.
	cmp	R0,#9		@ Check upper limit of digits range.
	bgt	notdig		@ Go exit if end of string of digits found.
	mla	R3,R4,R3,R0	@ Shift accumulated value and add. [R3] = [R4]*[R3] + [R0]
	add	R2,R5		@ Increment number of places right of decimal point.
	b	nxtdig		@ Continue loop with next digit from input buffer.

@	If non-digit is the decimal point, set flag to start counting digits

notdig:	add	R0,#'0'		@ Restore the character bias.
	cmp	R0,#'.'		@ Test for decimal point
	moveq	R5,#1		@ Value of R5 to be added to count in R2
	beq	nxtdig		@ Continue converting base, but count decimal places, too.

@	Combine significant and decimal shift count using the floating point processor.

	vmov	S3,R3		@ Move integer significant into floating point register.
	vcvt.f32.s32 S0,S3	@ Convert significant from integer to floating point.
	subs	R2,#1		@ Decrement number of places right of decimal point.
	blt	cpy2R0		@ If none, then go copy "whole" floating point number.
	vldr	S1,point1	@ Copy decimal 0.1 into floating point register.
	beq	combbe		@ For 1 decimal place, go multiply significant times .1
	vmov	S2,S1		@ Extra copy of 0.10 needed for multiplication loop.
pow10:	vmul.f32 S1,S2		@ Change final value by a factor of 10
	subs	R2,#1		@ Decrement number of decimal places to "shift"
	bgt	pow10		@ Continue loop to "shift decimal point" 
combbe:	vmul.f32 S0,S1		@ Finish by combining significant and exponent.
cpy2R0:	vmov	R0,S0		@ Move finished floating pointer number for return.
	sub	R1,#1		@ Set R1 pointing to character that stopped scan.

	pop	{R2-R6}		@ Reload saved register contents.
	bx	LR		@ Return to the calling program.

point1:	.float	0.1		@ Floating point value to "shift" number to the right 1 place.
	.end
