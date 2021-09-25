@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: getinput.s
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global getinput
.text	
			
getinput:
	ldr r12,=inmemory
	ldr r0,=rng
	bl  puts
	ldr r0,=inbuff
	bl gets
	mov r1,r0
	bl c_flt
	str r0,[r12]
	ldr r0,=br
	bl puts
	ldr r0,=inbuff
	bl gets
	mov r1,r0
	bl c_flt
	str r0,[r12,#4]
	ldr r0,=sp
	bl puts
	ldr r0,=inbuff
	bl gets
	mov r1,r0
	bl c_flt
	str r0,[r12,#8]
	ldr r0,=dir
	bl puts
	ldr r0,=inbuff
	bl gets
	mov r1,r0
	bl c_flt
	str r0,[r12,#12]
	
		
done:
	
	bx lr


.data
rng: .asciz "Enter Range in format xxxxx.xx >>" @prompt
br: .asciz "Enter Bearing in format xxx.xx >>" @prompt
sp: .asciz "Enter Speed in format xx.xx >>" @prompt
dir: .asciz "Enter Direction in format xxx.xx >>" @prompt
inbuff: .space 128
inmemory: .word 0,0,0,0,0
.end
		
		 