
	USER TEXT SEGMENT
[0x00400000]	0x00004024  and $8, $0, $0                  ; 19: and $t0, $zero, $zero      # $t0 = 0
[0x00400004]	0x00004824  and $9, $0, $0                  ; 20: and $t1, $zero, $zero      # $t1 = 0
[0x00400008]	0x00005024  and $10, $0, $0                 ; 21: and $t2, $zero, $zero      # $t2 = 0
[0x0040000c]	0x00005824  and $11, $0, $0                 ; 22: and $t3, $zero, $zero      # $t3 = 0
[0x00400010]	0x00006024  and $12, $0, $0                 ; 23: and $t4, $zero, $zero      # $t4 = 0
[0x00400014]	0x00006824  and $13, $0, $0                 ; 24: and $t5, $zero, $zero      # $t5 = 0
[0x00400018]	0x00007024  and $14, $0, $0                 ; 25: and $t6, $zero, $zero      # $t6 = 0
[0x0040001c]	0x00007824  and $15, $0, $0                 ; 26: and $t7, $zero, $zero      # $t7 = 0
[0x00400020]	0x00001024  and $2, $0, $0                  ; 27: and $v0, $zero, $zero      # $v0 = 0
[0x00400024]	0x20080005  addi $8, $0, 5                  ; 32: addi $t0, $zero, 5         # $t0 = 5
[0x00400028]	0x2009000a  addi $9, $0, 10                 ; 33: addi $t1, $zero, 10        # $t1 = 10
[0x0040002c]	0x01095020  add $10, $8, $9                 ; 34: add  $t2, $t0, $t1         # $t2 = 15
[0x00400030]	0xac0a0000  sw $10, 0($0)                   ; 35: sw   $t2, 0($zero)         # mem[0] = 15
[0x00400034]	0x3c0b1234  lui $11, 4660                   ; 40: lui  $t3, 0x1234           # $t3 = 0x12340000
[0x00400038]	0x356b5678  ori $11, $11, 22136             ; 41: ori  $t3, $t3, 0x5678      # $t3 = 0x12345678
[0x0040003c]	0x200c0002  addi $12, $0, 2                 ; 42: addi $t4, $zero, 2
[0x00400040]	0xad8b0000  sw $11, 0($12)                  ; 43: sw   $t3, 0($t4)           # mem[2] = 0x12345678
[0x00400044]	0x340d00ff  ori $13, $0, 255                ; 48: ori  $t5, $zero, 0x00FF    # $t5 = 255
[0x00400048]	0x200c0001  addi $12, $0, 1                 ; 49: addi $t4, $zero, 1
[0x0040004c]	0xad8d0000  sw $13, 0($12)                  ; 50: sw   $t5, 0($t4)           # mem[1] = 255
[0x00400050]	0x200e000f  addi $14, $0, 15                ; 52: addi $t6, $zero, 15        # $t6 = 15
[0x00400054]	0x01cd7824  and $15, $14, $13               ; 53: and  $t7, $t6, $t5         # $t7 = 15 & 255 = 15
[0x00400058]	0x200c0005  addi $12, $0, 5                 ; 54: addi $t4, $zero, 5
[0x0040005c]	0xad8f0000  sw $15, 0($12)                  ; 55: sw   $t7, 0($t4)           # mem[5] = 15
[0x00400060]	0x20080003  addi $8, $0, 3                  ; 60: addi $t0, $zero, 3
[0x00400064]	0x20090008  addi $9, $0, 8                  ; 61: addi $t1, $zero, 8
[0x00400068]	0x0109502a  slt $10, $8, $9                 ; 62: slt  $t2, $t0, $t1         # $t2 = 1
[0x0040006c]	0x200c0003  addi $12, $0, 3                 ; 63: addi $t4, $zero, 3
[0x00400070]	0xad8a0000  sw $10, 0($12)                  ; 64: sw   $t2, 0($t4)           # mem[3] = 1
[0x00400074]	0x200c0000  addi $12, $0, 0                 ; 69: addi $t4, $zero, 0
[0x00400078]	0x8d880000  lw $8, 0($12)                   ; 70: lw   $t0, 0($t4)           # $t0 = mem[0] = 15
[0x0040007c]	0x2108fffa  addi $8, $8, -6                 ; 71: addi $t0, $t0, -6          # $t0 = 9
[0x00400080]	0x200c0006  addi $12, $0, 6                 ; 72: addi $t4, $zero, 6
[0x00400084]	0xad880000  sw $8, 0($12)                   ; 73: sw   $t0, 0($t4)           # mem[6] = 9
[0x00400088]	0x20080001  addi $8, $0, 1                  ; 78: addi $t0, $zero, 1
[0x0040008c]	0x20090002  addi $9, $0, 2                  ; 79: addi $t1, $zero, 2
[0x00400090]	0x1109000f  beq $8, $9, 60 [bad1-0x00400090]; 80: beq  $t0, $t1, bad1        # should NOT branch
[0x00400094]	0x200a007b  addi $10, $0, 123               ; 81: addi $t2, $zero, 123
[0x00400098]	0x200c0004  addi $12, $0, 4                 ; 82: addi $t4, $zero, 4
[0x0040009c]	0xad8a0000  sw $10, 0($12)                  ; 83: sw   $t2, 0($t4)           # mem[4] = 123
[0x004000a0]	0x20080007  addi $8, $0, 7                  ; 88: addi $t0, $zero, 7
[0x004000a4]	0x20090007  addi $9, $0, 7                  ; 89: addi $t1, $zero, 7
[0x004000a8]	0x11090003  beq $8, $9, 12 [good2-0x004000a8]; 90: beq  $t0, $t1, good2       # should branch
[0x004000ac]	0x200a03e7  addi $10, $0, 999               ; 91: addi $t2, $zero, 999       # should be skipped
[0x004000b0]	0x200c0007  addi $12, $0, 7                 ; 92: addi $t4, $zero, 7
[0x004000b4]	0xad8a0000  sw $10, 0($12)                  ; 93: sw   $t2, 0($t4)           # should be skipped
[0x004000b8]	0x200a0309  addi $10, $0, 777               ; 96: addi $t2, $zero, 777
[0x004000bc]	0x200c0007  addi $12, $0, 7                 ; 97: addi $t4, $zero, 7
[0x004000c0]	0xad8a0000  sw $10, 0($12)                  ; 98: sw   $t2, 0($t4)           # mem[7] = 777
[0x004000c4]	0x200c0007  addi $12, $0, 7                 ; 103: addi $t4, $zero, 7
[0x004000c8]	0x8d820000  lw $2, 0($12)                   ; 104: lw   $v0, 0($t4)           # $v0 = mem[7] = 777
[0x004000cc]	0x1000ffff  beq $0, $0, -4 [done-0x004000cc]; 107: beq  $zero, $zero, done    # infinite loop
[0x004000d0]	0x200a03e7  addi $10, $0, 999               ; 110: addi $t2, $zero, 999
[0x004000d4]	0x200c0004  addi $12, $0, 4                 ; 111: addi $t4, $zero, 4
[0x004000d8]	0xad8a0000  sw $10, 0($12)                  ; 112: sw   $t2, 0($t4)           # if this happens, beq not-taken failed
[0x004000dc]	0x1000fffb  beq $0, $0, -20 [done-0x004000dc]; 113: beq  $zero, $zero, done
