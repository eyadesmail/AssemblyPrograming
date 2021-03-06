@	Subroutine v_flt will display a floating point number in decimal digits.
@		R0: contains the number to be displayed
@		LR: Contains the return address
@		All register contents will be preserved

	.global	v_flt		@ Provide entry point address to linker

v_flt:	push	{R0-R8,LR}	@ Save contents of registers R0 - R8, LR.

@	Output a "minus sign" if number is negative

	ldr	R1,=minus	@ Negative sign character "message"
	mov	R2,#1		@ Number of characters in message.
	movs	R6,R0,lsl #1	@ Move sign bit into "C" flag
	blcs	v_asc		@ Display the "-" if sign bit was set.

@	Initialize the whole number in R0 and fraction in R3.

	mov	R3, R0,lsl #8	@ Left justify normalized mantissa to R3.
	orr	R3,#0x80000000	@ Set the "assumed" high order bit.
	mov	R0,#0		@ Whole part = 0 (Number < .9999...)
	cmp	R6,#0		@ Test if both mantissa and exp = 0.
	beq	disp		@ Go display 0.0 if both mantissa and exp = 0.

@	Get the exponent and remove its bias

	mov	R6,R6,lsr #24	@ Right justify biased exponent.
	subs	R6, #126	@ Remove the exponent bias.
	beq	disp		@ If exponent = 0, need no shifting.
	blt	shiftr		@ Values <.5 must be shifted right.

@	Shift mantissa left: floating point number is greater than (or eq) 1.0

	rsb	R5,R6,#32	@ Convert left shift to right shift count.
	mov	R0,R3,lsr R5	@ Get the whole number potion of the number.
	lsl	R3,R6		@ Get the fractional part of the number
	b	disp		@ Go display both whole number and fraction.

@	Shift mantissa right (floating point number is less than .5).

shiftr:	rsb	R6,R6,#0	@ Calculate positive shift count (to right).
	lsr	R3,R6		@ "Divide by 2" for each bit shifted.

@	The floating point number is now divided into two registers:
@		R0: Has the whole number (left of the decimal point)
@		R3: Has the fraction (right of the decimal point)

@	Display the whole number in base 10.

disp:	bl	v_dec		@ Display the number in R0 in decimal digits.

@	Display decimal point separating the whole number from the fraction.

	ldr	R1,=point	@ Pointer to decimal point.
	bl	v_asc		@ Put decimal point into display.

@	Display the fraction in base 10

	mov	R4,#10		@ Base 10 used to "shift" over each digit.
	ldr	R5,=dig		@ Set R5 pointing to "0123456789" string

@	Loop through powers of 10 and display each digit.

nxtdfd:	umull	R3,R1,R4,R3	@ "Shift" next decimal digit into R1.
	add	R1,R5		@ Set pointer to digit in "0123456789"
	bl	v_asc		@ Write out one digit.
	cmp	R3,#0		@ Set Z flag if mantissa is now zero.
	bne	nxtdfd		@ Go display next decimal digit.

	pop	{R0-R8,LR}	@ Restore saved register contents.
	bx	LR		@ return to the calling program

dig:	.ascii	"0123456789"	@ ASCII string of digits 0 through 9.
minus:	.ascii	"-"		@ Negative sign
point:	.ascii	"."		@ Decimal point
	.end