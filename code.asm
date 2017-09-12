addi  $s1, $0, 0x7F00	# timer
addi  $s2, $0, 0x7F10	# led
addi  $s3, $0, 0x7F20	# switch
# cp0 init
addu  	$4 ,$0, 1025	# 000001 00000000 0 1
mtc0  	$4, $12
# vars
addi	$3, $0, 1000	# 1s
addi	$5, $0, 9	# start timer, enable interrupt

reload:
lw   	$7, 0($s3)	# base_sec
addi 	$2, $0, 0	# cnt_sec
addi	$8, $7, 0	# buff old key
# set timer
sw	$0, 0($s1)	# 32'b0, mode 0, stop timer
sw	$3, 4($s1)	# set preset time
sw	$5, 0($s1)	# write timer, start timer, enable interrupt

loopchk:
lw   	$6, 0($s3)
beq	$8, $6, loopchk	#if not changed, loop
j	reload		#if changed, reload
