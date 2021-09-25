@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: myout.s
@ description: outsputs output values
@ r3 contains bearing aim
@ r5 contains elev aim
@ r7 contains crg 	
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global myout
.text				
myout:	MOV  r0,#0
	@LDR  r0,= BR
	@bl   puts 
	MOV  r0,r3
	bl   v_flt
	LDR  r0,= nline
	bl   puts
	LDR  r0,= EV
	bl   puts
	MOV  r0,r5
	bl   v_flt
	LDR  r0,= nline
	bl   puts
	LDR  r0,=CRG
	bl   puts
	MOV  r0,r7
	bl   v_flt
	LDR  r0,= nline
	bl   puts
	
	
done:
	mov r0,#0
	mov r7,#1
	svc 0
.data
BR : .asciz "Br"
EV : .asciz "Ev"
CRG: .asciz "CRG"
nline: .asciz "\n"

.end
	