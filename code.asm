addi  $s1, $0, 0x7F00	# timer
addi  $s2, $0, 0x7F10	# led
addi  $s3, $0, 0x7F20	# switch
# cp0 init
addi  	$4 ,$0, 64513	# 111111 00000000 0 1
mtc0  	$4, $12
# vars
addi	$3, $0, 1000	# 1s
addi	$5, $0, 9	# start timer, enable interrupt

reload:
lw   	$1, 0($s3)	# base_sec
addi 	$2, $0, 0	# cnt_sec
# set timer
sw	$0, 0($s1)	# 32'b0, mode 0, stop timer
sw	$3, 8($s1)	# set preset time
sw	$5, 0($s1)	# write timer, start timer, enable interrupt

loopchk:
lw   	$6, 0($s3)
beq	$1, $6, loopchk	#if not changed, loop
j	reload		#if changed, reload
