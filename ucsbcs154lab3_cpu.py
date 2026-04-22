import pyrtl

# ucsbcs154lab3
# All Rights Reserved
# Copyright (c) 2023 Regents of the University of California
# Distribution Prohibited


# Initialize your memblocks here: 
i_mem = pyrtl.MemBlock(bitwidth=32, addrwidth=32, name='i_mem')
d_mem = pyrtl.MemBlock(bitwidth=32, addrwidth=32, name='d_mem')
rf    = pyrtl.MemBlock(bitwidth=32, addrwidth=5, name='rf')

pc = pyrtl.Register(bitwidth=32, name='pc')

instr = i_mem[pc]

# When working on large designs, such as this CPU implementation, it is
# useful to partition your design into smaller, reusable, hardware
# blocks. We have indicated where you should put different hardware blocks 
# to help you get write your CPU design. You have already worked on some 
# parts of this logic in prior labs, like the decoder and alu.

## DECODER
# decode the instruction
op = instr[26:32]
rs = instr[21:26]
rt = instr[16:21]
rd = instr[11:16]
imm = instr[0:16]
funct = instr[0:6]

## CONTROLLER
# define control signals for the following instructions
# add, and, addi, lui, ori, slt, lw, sw, beq
is_rtype = op == 0
is_add  = is_rtype & (funct == 32)
is_and  = is_rtype & (funct == 36)
is_slt  = is_rtype & (funct == 42)
is_addi = op == 8
is_lui  = op == 15
is_ori  = op == 13
is_lw   = op == 35
is_sw   = op == 43
is_beq  = op == 4

reg_dst
branch
mem_to_reg
alu_op
mem_write
alu_src
reg_write

## WRITE REGISTER mux
# create the mux to choose among rd and rt for the write register
wr_reg = pyrtl.select(reg_dst, rt, rd)

## READ REGISTER VALUES from the register file
# read the values of rs and rt registers from the register file
rs_val = rf[rs]
rt_val = rf[rt]

## ALU INPUTS
# define the ALU inputs after reading values of rs and rt registers from
# the register file
# Hint: Think about ALU inputs for instructions that use immediate values 
alu_a = rs_val
alu_b = pyrtl.mux(alu_src, rt_val, imm.sign_extended(32), imm.zero_extended(32))

## FIND ALU OUTPUT
# find what the ALU outputs are for the following instructions:
# add, and, addi, lui, ori, slt, lw, sw, beq
# Hint: you want to find both ALU result and zero. Refer the figure in the
# lab document
alu_out = pyrtl.WireVector(bitwidth=32)
alu_zero = pyrtl.WireVector(bitwidth=1)

with pyrtl.conditional_assignment:
    with alu_op == 0:
        alu_out |= alu_a + alu_b
    with alu_op == 1:
        alu_out |= alu_a & alu_b
    with alu_op == 2:
        alu_out |= alu_b << 16 
    with alu_op == 3:
        alu_out |= alu_a | alu_b  
    with alu_op == 4:
        alu_out |= alu_a < alu_b  
    with alu_op == 5:
        alu_out |= alu_a - alu_b  

alu_zero <<= (alu_out == 0)

## DATA MEMORY WRITE
# perform the write operation in the data memory. Think about which 
# instructions will need to write to the data memory
with pyrtl.conditional_assignment:
    with mem_write:
        d_mem[alu_out] |= rt_val

## REGISTER WRITEBACK
# Create the mux to select between ALU result and data memory read.
# Writeback the selected value to the register file in the 
# appropriate write register 
wb_data = pyrtl.select(mem_to_reg, alu_out, d_mem[alu_out])

with pyrtl.conditional_assignment:
    with reg_write:
        rf[wr_reg] |= wb_data

## PC UPDATE
# finally update the program counter. Pay special attention when updating 
# the PC in the case of a branch instruction. 
pc_next = pc + 1
branch_next = pc_next + imm_se

pc.next <<= pyrtl.select(branch & alu_zero, pc_next, branch_next)

if __name__ == '__main__':

    """

    Here is how you can test your code.
    This is very similar to how the autograder will test your code too.

    1. Write a MIPS program. It can do anything as long as it tests the
       instructions you want to test.

    2. Assemble your MIPS program to convert it to machine code. Save
       this machine code to the "i_mem_init.txt" file. You can use the 
       "mips_to_hex.sh" file provided to assemble your MIPS program to 
       corresponding hexadecimal instructions.  
       You do NOT want to use QtSPIM for this because QtSPIM sometimes
       assembles with errors. Another assembler you can use is the following:

       https://alanhogan.com/asu/assembler.php

    3. Initialize your i_mem (instruction memory).

    4. Run your simulation for N cycles. Your program may run for an unknown
       number of cycles, so you may want to pick a large number for N so you
       can be sure that all instructions of the program are executed.

    5. Test the values in the register file and memory to make sure they are
       what you expect them to be.

    6. (Optional) Debug. If your code didn't produce the values you thought
       they should, then you may want to call sim.render_trace() on a small
       number of cycles to see what's wrong. You can also inspect the memory
       and register file after every cycle if you wish.

    Some debugging tips:

        - Make sure your assembly program does what you think it does! You
          might want to run it in a simulator somewhere else (SPIM, etc)
          before debugging your PyRTL code.

        - Test incrementally. If your code doesn't work on the first try,
          test each instruction one at a time.

        - Make use of the render_trace() functionality. You can use this to
          print all named wires and registers, which is extremely helpful
          for knowing when values are wrong.

        - Test only a few cycles at a time. This way, you don't have a huge
          500 cycle trace to go through!

    """

    # Start a simulation trace
    sim_trace = pyrtl.SimulationTrace()

    # Initialize the i_mem with your instructions.
    i_mem_init = {}
    with open('i_mem_init.txt', 'r') as fin:
        i = 0
        for line in fin.readlines():
            i_mem_init[i] = int(line, 16)
            i += 1

    sim = pyrtl.Simulation(tracer=sim_trace, memory_value_map={
        i_mem : i_mem_init
    })

    # Run for an arbitrarily large number of cycles.
    for cycle in range(500):
        sim.step({})

    # Use render_trace() to debug if your code doesn't work.
    # sim_trace.render_trace()

    # You can also print out the register file or memory like so if you want to debug:
    # print(sim.inspect_mem(d_mem))
    # print(sim.inspect_mem(rf))

    # Perform some sanity checks to see if your program worked correctly
    assert(sim.inspect_mem(d_mem)[0] == 10)
    assert(sim.inspect_mem(rf)[8] == 10)    # $v0 = rf[8]
    print('Passed!')
