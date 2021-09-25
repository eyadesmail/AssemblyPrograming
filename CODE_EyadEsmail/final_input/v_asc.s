.global v_asc
.text

v_asc:	mov	R0,#1		@ Code for stdout (standard output, i.e., monitor display)
	mov	R7,#4		@ Linux service command code to write string.
	svc	0		@ Issue command to display string on stdout
	bx	LR		@ Return to the calling program
	.end