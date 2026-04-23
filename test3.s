# Test Program 2
# Focus: branches + zero-register protection + full instruction coverage

.text

main:
    ##################################################
    # 1. Zero register protection
    # If your CPU wrongly allows writes to $zero,
    # everything after this can go weird.
    ##################################################
    addi $zero, $zero, 5       # should do nothing
    addi $t0, $zero, 0         # if $zero is correct, $t0 = 0
    sw   $t0, 0($zero)         # mem[0] = 0

    ##################################################
    # 2. Basic add/addi
    ##################################################
    addi $t1, $zero, 4         # $t1 = 4
    addi $t2, $zero, 6         # $t2 = 6
    add  $t3, $t1, $t2         # $t3 = 10
    addi $t4, $zero, 1
    sw   $t3, 0($t4)           # mem[1] = 10

    ##################################################
    # 3. and / ori
    ##################################################
    ori  $t5, $zero, 0x00F0    # $t5 = 240
    ori  $t6, $zero, 0x000F    # $t6 = 15
    and  $t7, $t5, $t6         # $t7 = 0
    addi $t4, $zero, 2
    sw   $t7, 0($t4)           # mem[2] = 0

    ##################################################
    # 4. lui / ori
    ##################################################
    lui  $s0, 0xABCD           # $s0 = 0xABCD0000
    ori  $s0, $s0, 0x1234      # $s0 = 0xABCD1234
    addi $t4, $zero, 3
    sw   $s0, 0($t4)           # mem[3] = 0xABCD1234

    ##################################################
    # 5. slt true + false
    ##################################################
    addi $s1, $zero, 3
    addi $s2, $zero, 9
    slt  $s3, $s1, $s2         # 1
    addi $t4, $zero, 4
    sw   $s3, 0($t4)           # mem[4] = 1

    slt  $s4, $s2, $s1         # 0
    addi $t4, $zero, 5
    sw   $s4, 0($t4)           # mem[5] = 0

    ##################################################
    # 6. lw / sw round trip
    ##################################################
    addi $t4, $zero, 1
    lw   $s5, 0($t4)           # $s5 = mem[1] = 10
    addi $s5, $s5, 7           # $s5 = 17
    addi $t4, $zero, 6
    sw   $s5, 0($t4)           # mem[6] = 17

    ##################################################
    # 7. beq not taken
    ##################################################
    addi $t0, $zero, 1
    addi $t1, $zero, 2
    beq  $t0, $t1, bad_not_taken
    addi $t2, $zero, 111
    addi $t4, $zero, 7
    sw   $t2, 0($t4)           # mem[7] = 111

    ##################################################
    # 8. beq taken
    ##################################################
    addi $t0, $zero, 8
    addi $t1, $zero, 8
    beq  $t0, $t1, good_taken
    addi $t2, $zero, 999       # should be skipped
    addi $t4, $zero, 8
    sw   $t2, 0($t4)           # should be skipped

good_taken:
    addi $t2, $zero, 222
    addi $t4, $zero, 8
    sw   $t2, 0($t4)           # mem[8] = 222

    ##################################################
    # 9. negative branch offset loop
    # counts mem[9] up to 5 using a backward beq
    ##################################################
    addi $s0, $zero, 0         # counter = 0
    addi $s1, $zero, 5         # limit = 5
    addi $s2, $zero, 9         # address = 9
    sw   $zero, 0($s2)         # mem[9] = 0

loop:
    lw   $s3, 0($s2)           # load mem[9]
    addi $s3, $s3, 1
    sw   $s3, 0($s2)           # mem[9]++

    addi $s0, $s0, 1           # counter++
    beq  $s0, $s1, loop_done   # if counter == 5, exit
    beq  $zero, $zero, loop    # backward branch

loop_done:
    ##################################################
    # 10. Final visible register result
    ##################################################
    addi $t4, $zero, 9
    lw   $v0, 0($t4)           # $v0 = mem[9] = 5

done:
    beq  $zero, $zero, done

bad_not_taken:
    addi $t2, $zero, 999
    addi $t4, $zero, 7
    sw   $t2, 0($t4)           # if this happens, branch-not-taken failed
    beq  $zero, $zero, done
