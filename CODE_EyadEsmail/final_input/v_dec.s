.global	v_dec		@ Provide program starting address to linker

@	Subroutine v_dec will display a 32-bit register in decimal digits
@		R0: contains a number to be displayed in decimal
@		    If negative (bit 31 = 1), then a minus sign will be output
@		LR: Contains the return address
@		All register contents will be preserved

v_dec:	push	{R0-R7}		@ Save contents of registers R0 through R7

	mov	R3,R0		@ R3 will hold a copy of input word to be displayed.
	mov	R2,#1		@ Number of characters to be displayed at a time.
	mov	R0,#1		@ Code for stdout (standard output, i.e., monitor display)
	mov	R7,#4		@ Linux service command code to write string.

@	If bit-31 is set, then register contains a negative number and "-" should be output.

	cmp	R3,#0		@ Determine if minus sign is needed.
	bge	absval		@ If positive number, then just display it.
	ldr	R1,=msign	@ Address of minus sign in memory
	svc	0		@ Service call to write string to stdout device
	rsb	R3,R3,#0	@ Get absolute value (negative of negative) for display.
absval:	cmp	R3,#10		@ Test whether only one's column is needed
	blt	onecol		@ Go output "final" column of display

@	Get highest power of ten this number will use (i.e., is it greater than 10?, 100?, ...)

	ldr	R6,=pow10+8	@ Point to hundred's column of power of ten table.
high10:	ldr	R5,[R6],#4	@ Load next higher power of ten
	cmp	R3,R5		@ Test if we've reached the highest power of ten needed
	bge	high10		@ Continue search for power of ten that is greater.
	sub	R6,#8		@ We stepped two integers too far.

@	Loop through powers of 10 and output each to the standard output (stdout) monitor display.

nxtdec:	ldr	R1,=dig-1	@ Point to 1 byte before "0123456789" string
	ldr	R5,[R6],#-4	@ Load next lower power of 10 (move right 1 dec column) 

@	Loop through the next base ten digit to be displayed (i.e., thousands, hundreds, ...)

mod10:	add	R1,#1		@ Set R1 pointing to the next higher digit '0' through '9'.
	subs	R3,R5		@ Do a count down to find the correct digit.
	bge	mod10		@ Keep subtracting current decimal column value
	addlt	R3,R5		@ We counted one too many (went negative)
	svc	0		@ Write the next digit to display
	cmp	R5,#10		@ Test if we've gone all the way to the one's column.
	bgt	nxtdec		@ If 1's column, go output rightmost digit and return.

@	Finish decimal display by calculating the one's digit.

onecol:	ldr	R1,=dig		@ Pointer to "0123456789"
	add	R1,R3		@ Generate offset into "0123456789" for one's digit.
	svc	0		@ Write out the final digit.

	pop	{R0-R7}		@ Restore saved register contents
	bx	LR		@ Return to the calling program

	.data
pow10:	.word	1		@ 10^0
	.word	10		@ 10^1
	.word	100		@ 10^2
	.word	1000		@ 10^3  (thousand)
	.word	10000		@ 10^4
	.word	100000		@ 10^5
	.word	1000000		@ 10^6  (million)
	.word	10000000	@ 10^7
	.word	100000000	@ 10^8
	.word	1000000000	@ 10^9  (billion)
	.word	0x7FFFFFFF	@ Largest integer in 31 bits (2,147,483,647)
dig:	.ascii	"0123456789"	@ ASCII string of digits 0 through 9.
msign:	.ascii	"-"		@ needed for negative decimal numbers.
	.end
