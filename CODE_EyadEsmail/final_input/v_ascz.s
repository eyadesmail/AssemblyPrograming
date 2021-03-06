  
	.global	v_ascz		@ Provide subroutine entry address to linker

@	Subroutine v_ascz will display a string of characters
@		R1: Points to beginning of ASCII string
@		    End of string will be marked by a null byte
@		LR: Contains the return address
@		All register contents will be preserved

v_ascz: push	{R0-R8,LR}	@ Save contents of registers R0 through R8, LR
	sub	R2,R1,#1	@ R2 will be index while searching string for null.
hunt4z:	ldrb	R0,[R2,#1]!	@ Load next character from string (and increment R2 by 1)
	cmp	R0,#0		@ Set Z status bit if null found
	bne	hunt4z		@ If not null, go examine next character.
	sub	R2,R1		@ Get number of bytes in message (not counting null)
	mov	R0,#1		@ Code for stdout (standard output, i.e., monitor display)
	mov	R7,#4		@ Linux service command code to write string.
	svcne	0		@ Issue command to display string on stdout

	pop	{R0-R8,LR}	@ Restore saved register contents
	bx	LR		@ Return to the calling program
	.end