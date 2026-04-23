
	USER TEXT SEGMENT
[0x00400000]	0x20000005  addi $0, $0, 5                  ; 12: addi $zero, $zero, 5       # should do nothing
[0x00400004]	0x20080000  addi $8, $0, 0                  ; 13: addi $t0, $zero, 0         # if $zero is correct, $t0 = 0
[0x00400008]	0xac080000  sw $8, 0($0)                    ; 14: sw   $t0, 0($zero)         # mem[0] = 0
[0x0040000c]	0x20090004  addi $9, $0, 4                  ; 19: addi $t1, $zero, 4         # $t1 = 4
[0x00400010]	0x200a0006  addi $10, $0, 6                 ; 20: addi $t2, $zero, 6         # $t2 = 6
[0x00400014]	0x012a5820  add $11, $9, $10                ; 21: add  $t3, $t1, $t2         # $t3 = 10
[0x00400018]	0x200c0001  addi $12, $0, 1                 ; 22: addi $t4, $zero, 1
[0x0040001c]	0xad8b0000  sw $11, 0($12)                  ; 23: sw   $t3, 0($t4)           # mem[1] = 10
[0x00400020]	0x340d00f0  ori $13, $0, 240                ; 28: ori  $t5, $zero, 0x00F0    # $t5 = 240
[0x00400024]	0x340e000f  ori $14, $0, 15                 ; 29: ori  $t6, $zero, 0x000F    # $t6 = 15
[0x00400028]	0x01ae7824  and $15, $13, $14               ; 30: and  $t7, $t5, $t6         # $t7 = 0
[0x0040002c]	0x200c0002  addi $12, $0, 2                 ; 31: addi $t4, $zero, 2
[0x00400030]	0xad8f0000  sw $15, 0($12)                  ; 32: sw   $t7, 0($t4)           # mem[2] = 0
[0x00400034]	0x3c10abcd  lui $16, -21555                 ; 37: lui  $s0, 0xABCD           # $s0 = 0xABCD0000
[0x00400038]	0x36101234  ori $16, $16, 4660              ; 38: ori  $s0, $s0, 0x1234      # $s0 = 0xABCD1234
[0x0040003c]	0x200c0003  addi $12, $0, 3                 ; 39: addi $t4, $zero, 3
[0x00400040]	0xad900000  sw $16, 0($12)                  ; 40: sw   $s0, 0($t4)           # mem[3] = 0xABCD1234
[0x00400044]	0x20110003  addi $17, $0, 3                 ; 45: addi $s1, $zero, 3
[0x00400048]	0x20120009  addi $18, $0, 9                 ; 46: addi $s2, $zero, 9
[0x0040004c]	0x0232982a  slt $19, $17, $18               ; 47: slt  $s3, $s1, $s2         # 1
[0x00400050]	0x200c0004  addi $12, $0, 4                 ; 48: addi $t4, $zero, 4
[0x00400054]	0xad930000  sw $19, 0($12)                  ; 49: sw   $s3, 0($t4)           # mem[4] = 1
[0x00400058]	0x0251a02a  slt $20, $18, $17               ; 51: slt  $s4, $s2, $s1         # 0
[0x0040005c]	0x200c0005  addi $12, $0, 5                 ; 52: addi $t4, $zero, 5
[0x00400060]	0xad940000  sw $20, 0($12)                  ; 53: sw   $s4, 0($t4)           # mem[5] = 0
[0x00400064]	0x200c0001  addi $12, $0, 1                 ; 58: addi $t4, $zero, 1
[0x00400068]	0x8d950000  lw $21, 0($12)                  ; 59: lw   $s5, 0($t4)           # $s5 = mem[1] = 10
[0x0040006c]	0x22b50007  addi $21, $21, 7                ; 60: addi $s5, $s5, 7           # $s5 = 17
[0x00400070]	0x200c0006  addi $12, $0, 6                 ; 61: addi $t4, $zero, 6
[0x00400074]	0xad950000  sw $21, 0($12)                  ; 62: sw   $s5, 0($t4)           # mem[6] = 17
[0x00400078]	0x20080001  addi $8, $0, 1                  ; 67: addi $t0, $zero, 1
[0x0040007c]	0x20090002  addi $9, $0, 2                  ; 68: addi $t1, $zero, 2
[0x00400080]	0x11090019  beq $8, $9, 100 [bad_not_taken-0x00400080]; 69: beq  $t0, $t1, bad_not_taken
[0x00400084]	0x200a006f  addi $10, $0, 111               ; 70: addi $t2, $zero, 111
[0x00400088]	0x200c0007  addi $12, $0, 7                 ; 71: addi $t4, $zero, 7
[0x0040008c]	0xad8a0000  sw $10, 0($12)                  ; 72: sw   $t2, 0($t4)           # mem[7] = 111
[0x00400090]	0x20080008  addi $8, $0, 8                  ; 77: addi $t0, $zero, 8
[0x00400094]	0x20090008  addi $9, $0, 8                  ; 78: addi $t1, $zero, 8
[0x00400098]	0x11090003  beq $8, $9, 12 [good_taken-0x00400098]; 79: beq  $t0, $t1, good_taken
[0x0040009c]	0x200a03e7  addi $10, $0, 999               ; 80: addi $t2, $zero, 999       # should be skipped
[0x004000a0]	0x200c0008  addi $12, $0, 8                 ; 81: addi $t4, $zero, 8
[0x004000a4]	0xad8a0000  sw $10, 0($12)                  ; 82: sw   $t2, 0($t4)           # should be skipped
[0x004000a8]	0x200a00de  addi $10, $0, 222               ; 85: addi $t2, $zero, 222
[0x004000ac]	0x200c0008  addi $12, $0, 8                 ; 86: addi $t4, $zero, 8
[0x004000b0]	0xad8a0000  sw $10, 0($12)                  ; 87: sw   $t2, 0($t4)           # mem[8] = 222
[0x004000b4]	0x20100000  addi $16, $0, 0                 ; 93: addi $s0, $zero, 0         # counter = 0
[0x004000b8]	0x20110005  addi $17, $0, 5                 ; 94: addi $s1, $zero, 5         # limit = 5
[0x004000bc]	0x20120009  addi $18, $0, 9                 ; 95: addi $s2, $zero, 9         # address = 9
[0x004000c0]	0xae400000  sw $0, 0($18)                   ; 96: sw   $zero, 0($s2)         # mem[9] = 0
[0x004000c4]	0x8e530000  lw $19, 0($18)                  ; 99: lw   $s3, 0($s2)           # load mem[9]
[0x004000c8]	0x22730001  addi $19, $19, 1                ; 100: addi $s3, $s3, 1
[0x004000cc]	0xae530000  sw $19, 0($18)                  ; 101: sw   $s3, 0($s2)           # mem[9]++
[0x004000d0]	0x22100001  addi $16, $16, 1                ; 103: addi $s0, $s0, 1           # counter++
[0x004000d4]	0x12110001  beq $16, $17, 4 [loop_done-0x004000d4]; 104: beq  $s0, $s1, loop_done   # if counter == 5, exit
[0x004000d8]	0x1000fffa  beq $0, $0, -24 [loop-0x004000d8]; 105: beq  $zero, $zero, loop    # backward branch
[0x004000dc]	0x200c0009  addi $12, $0, 9                 ; 111: addi $t4, $zero, 9
[0x004000e0]	0x8d820000  lw $2, 0($12)                   ; 112: lw   $v0, 0($t4)           # $v0 = mem[9] = 5
[0x004000e4]	0x1000ffff  beq $0, $0, -4 [done-0x004000e4]; 115: beq  $zero, $zero, done
[0x004000e8]	0x200a03e7  addi $10, $0, 999               ; 118: addi $t2, $zero, 999
[0x004000ec]	0x200c0007  addi $12, $0, 7                 ; 119: addi $t4, $zero, 7
[0x004000f0]	0xad8a0000  sw $10, 0($12)                  ; 120: sw   $t2, 0($t4)           # if this happens, branch-not-taken failed
[0x004000f4]	0x1000fffb  beq $0, $0, -20 [done-0x004000f4]; 121: beq  $zero, $zero, done
