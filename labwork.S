  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  # Changed by Maximilian Nyberg 2020
  #


.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #
  .global delay
  .global time2string
  .global enable_interrupt
.data
.text	#
enable_interrupt: 
	ei
	j return
	nop
hexasc:  
	li 	$t1, 0x000f		# creates temporary value t1 and assigns it true in the first 4 bits
	and 	$a0,$a0,$t1		# uses masking to only count the 4 lsb of a0
	addi	$t0, $0, 0x9	# creates temporary value t0 that equals to 9. Used to check if a0 corresponds to a number or a letter.
	ble	$a0, $t0, numbers	# checks if a0 is less or equal to 9. If true, jumps down to less9
	nop			# delay slot filler (just in case)
	addiu	$a0, $a0, 0x37	# if the ble above is false, addes 0x37 to a0, to correlate with the correct ascii-coded character
	j 	back
	nop 			# delay slot filler (just in case)
	
	numbers:
	addiu	$a0, $a0, 0x30	# Since a0 is less or equal to 9, adds 0x30 to correspond to the right ascii-coded character
	j 	back
	nop
	
	back:
	add 	$v0, $a0, $0
	
	jr	$ra
	nop			# delay slot filler (just in case)
	
#	delay: 
	#	jr 	$ra
	#	nop
	
delay: 
	addi $t0, $0, 0		# t0 is the i in the for loop
	addi $t1, $0, 5000	# t1 is the constant in the for loop
		whileloop:
		ble  $a0, 0, exit 	# while ms <= 0, exit while loop.
		nop
		
		addi $t0, $0, 0
		sub $a0, $a0, 1	# ms = ms - 1
			forloop:
			beq $t0, $t1, whileloop		# i = 4711 (constant), exit for loop
			nop
			
			addi $t0, $t0, 1		# i = i + 1
			j forloop			# loops the for loop until beq above is true.
			nop
	exit:
	jr $ra
	nop

time2string:
	PUSH	$s1
	PUSH	$s0
	PUSH 	$ra		# since we call hexasc, we must push $ra
	add	$s0, $a0, $0	# copies the timstr to t0
	add	$s1, $a1, $0	# copies the time-info to t1
	
	andi	$t2, $s1, 0xf000	# Checks the 4 MSB of the time info (5), ignores the rest
	srl 	$a0, $t2, 12		# shifts these 4 bits in to the LSB of the timestr
	jal 	hexasc			# calls hexasc that transforms this in to ASCII-code for 5.
	nop
	sb	$v0, 0($s0)
	
	andi 	$t3, $s1, 0x0f00
	srl 	$a0, $t3, 8
	jal	hexasc
	nop
	sb	$v0, 1($s0)
	
	li 	$t4, 0x3A
	sb 	$t4, 2($s0)
	
	andi	$t5, $s1, 0x00f0
	srl 	$a0, $t5, 4
	jal 	hexasc
	nop
	sb 	$v0, 3($s0)
	
	andi	$t6, $s1, 0x000f
	move	$a0, $s1
	jal	hexasc
	nop
	sb	$v0, 4($s0)
	sb 	$0, 5($s0)
	continue:
	POP	$ra
	POP 	$s0
	POP	$s1
	jr  	$ra
	nop

return:
	jr $ra
	nop
