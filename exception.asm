# interrupt
# .ktext	0x00004180
sw	$3, 4($s1)	# set preset time	
sw	$5, 0($s1)	# write timer
addi	$2, $2, 1	# cnt_sec++
addu	$7, $7, $2	# base_sec+=cnt_sec
sw	$7, 0($s2)	# display base_sec
eret
