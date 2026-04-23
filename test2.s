# Comprehensive CS154 Lab 3 CPU test
# Tests: add, and, addi, lui, ori, slt, lw, sw, beq
#
# Expected final results:
# mem[0] = 15
# mem[1] = 255
# mem[2] = 305419896    # 0x12345678
# mem[3] = 1
# mem[4] = 123
# mem[5] = 15
# mem[6] = 9
# mem[7] = 777
# $v0    = 777

.text

main:
    # Clear a few regs
    and $t0, $zero, $zero      # $t0 = 0
    and $t1, $zero, $zero      # $t1 = 0
    and $t2, $zero, $zero      # $t2 = 0
    and $t3, $zero, $zero      # $t3 = 0
    and $t4, $zero, $zero      # $t4 = 0
    and $t5, $zero, $zero      # $t5 = 0
    and $t6, $zero, $zero      # $t6 = 0
    and $t7, $zero, $zero      # $t7 = 0
    and $v0, $zero, $zero      # $v0 = 0

    ##################################################
    # Test addi, add, sw
    ##################################################
    addi $t0, $zero, 5         # $t0 = 5
    addi $t1, $zero, 10        # $t1 = 10
    add  $t2, $t0, $t1         # $t2 = 15
    sw   $t2, 0($zero)         # mem[0] = 15

    ##################################################
    # Test lui, ori, sw
    ##################################################
    lui  $t3, 0x1234           # $t3 = 0x12340000
    ori  $t3, $t3, 0x5678      # $t3 = 0x12345678
    addi $t4, $zero, 2
    sw   $t3, 0($t4)           # mem[2] = 0x12345678

    ##################################################
    # Test and, ori, sw
    ##################################################
    ori  $t5, $zero, 0x00FF    # $t5 = 255
    addi $t4, $zero, 1
    sw   $t5, 0($t4)           # mem[1] = 255

    addi $t6, $zero, 15        # $t6 = 15
    and  $t7, $t6, $t5         # $t7 = 15 & 255 = 15
    addi $t4, $zero, 5
    sw   $t7, 0($t4)           # mem[5] = 15

    ##################################################
    # Test slt, sw
    ##################################################
    addi $t0, $zero, 3
    addi $t1, $zero, 8
    slt  $t2, $t0, $t1         # $t2 = 1
    addi $t4, $zero, 3
    sw   $t2, 0($t4)           # mem[3] = 1

    ##################################################
    # Test lw + addi + sw
    ##################################################
    addi $t4, $zero, 0
    lw   $t0, 0($t4)           # $t0 = mem[0] = 15
    addi $t0, $t0, -6          # $t0 = 9
    addi $t4, $zero, 6
    sw   $t0, 0($t4)           # mem[6] = 9

    ##################################################
    # Test beq not taken
    ##################################################
    addi $t0, $zero, 1
    addi $t1, $zero, 2
    beq  $t0, $t1, bad1        # should NOT branch
    addi $t2, $zero, 123
    addi $t4, $zero, 4
    sw   $t2, 0($t4)           # mem[4] = 123

    ##################################################
    # Test beq taken
    ##################################################
    addi $t0, $zero, 7
    addi $t1, $zero, 7
    beq  $t0, $t1, good2       # should branch
    addi $t2, $zero, 999       # should be skipped
    addi $t4, $zero, 7
    sw   $t2, 0($t4)           # should be skipped

good2:
    addi $t2, $zero, 777
    addi $t4, $zero, 7
    sw   $t2, 0($t4)           # mem[7] = 777

    ##################################################
    # Final check value into v0
    ##################################################
    addi $t4, $zero, 7
    lw   $v0, 0($t4)           # $v0 = mem[7] = 777

done:
    beq  $zero, $zero, done    # infinite loop

bad1:
    addi $t2, $zero, 999
    addi $t4, $zero, 4
    sw   $t2, 0($t4)           # if this happens, beq not-taken failed
    beq  $zero, $zero, done
