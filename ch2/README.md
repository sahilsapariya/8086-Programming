# Chapter 2: Basics of 8086 Programming

Here, we will going to learn only important things about this chapter.

## Addressing modes of 8086

- Implicit Addressing
- Register Addressing
- Immediate Addressing
- Memory Addressing
    - Direct Addressing
    - Register Indirect Addressing
    - Based Realtive Addressing
    - Indexed Realtive Addressing
    - Based Indexed Realtive Addressing

### 1. Implicit Addressing Mode

Instruction specify their function and operand both implicitly within the mnemonic itself.

Eg. STC, CLC, CMC, STD etc.

### 2. Register Addressing Mode

- The operand to be accessed is specified as residing in an internal register of the 8086.
- Both the source and the destination operands have been
specified as the contents of internal registers of the 8086

### 3. Immediate Addressing Mode

- If a source operand is part of the instruction instead of the contents of a register or memory location, it represents what is called the immediate operand and is accessed using immediate addressing mode.

- Typically immediate operand represents constant data Immediate operands can be either a byte or word of data

Examples: 

    MOV AL, 15H (2 BYTES)    
    MOV CX, 4AC2H (3 BYTES)

### 4. Memory Addressing Mode

- One of the operands must be in memory.
- We have to specify the address.
- Address is generally specified as segment:offset.
- Segment part shows the base address of the segment.
- Offset part shows the displacement or distance from the segment base and is also known as effective address.
- Different memory addressing modes specifies how an effective address is computed for an operand stored in a memory which then combines with segment address to generate physical address.

<center><h2>IMP</h2></center>

### 4.1 Direct Addressing Mode

- Physical address = {Segment}:{direct address}
- Default Segment register is DS.
- Direct address is 16-bit offset address provided in the instruction.
- Ex. MOV CX, [1000H]

### 4.2 Register indirect Addressing Mode

- Physical address = {Segment} : {BX or BP or SI or DI}
- Effective address of an operand is indirectly given in one of the register.
- Default Segment register is DS if register used are BX,SI or DI.
- If BP is used to store effective address then SS is default Segment.
- Ex. 
    - MOV AX, [BX]
    - MOV ES:[DI], AL
    - ADD CX, [SI]
    - OR CH, [BP]

### 4.3 Base Addressing Mode

- Physical address={Segment}:{BX or BP}+{8-bit or 16-bit displacement}
- Effective address of an operand is specified using BX/BP plus 16-bit/8-bit displacement value.
- Default Segment register is DS if BX register is used.
- If BP is used to store address then SS is default Segment.
- Ex.
    - MOV AX, 80H[BX]
    - MOV [BP + 2], AL
    - AND ARRAY[BX], AX

### 4.4 Index Addressing Mode

- Physical address={Segment}:{SI or DI}+{8-bit or 16-bit displacement}
- Effective address of an operand is specified using indexed registers plus 16-bit/8-bit displacement value.
- Default Segment register is DS.
- Ex.
    - MOV AL,[SI + 34h]
    - MOV [DI + 1234h], AX

### 4.5 Base-Index Addressing Mode

- PA ={Segment}:{BX or BP} + {SI or DI} + {8-bit or 16-bit displacement}
- Default Segment register is DS, if BX is used in effective address.
- Default Segment register is SS, if BP is used.
- Ex.
    - MOV AL, [BX + SI] or MOV AL ,[BX][SI]
    - ADD CL, [BP + SI + 1234h]

> #### Ques. Determine the addressing mode for following 8086 instruction.
> 
> 1. MOV CL, [BP] → Base Address
> 2. MOV [SI], AX → Index Address
> 3. ADD BX, ES:[1234H] → Direct addressing
> 4. MOV [SI + 12H], CH → index addressing
