# Initialize memory and registers
InstMem = [0] * 1024  # Instruction memory
Reg = [0] * 16        # 16 registers
Mem = [0] * 1024      # Data memory

# Program Counter
PC = 0
def reset():
    global Reg, Mem, PC
    Reg = [0] * 16
    Mem = [0] * 1024
    PC = 0
# Helper function for sign-extension
def SE(value):
    if value & 0x8:  # If the highest bit (bit 3) is set
        return value | 0xFFF0  # Extend with 1s
    return value

# Instruction Functions
def addi():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    imm = SE((inst >> 4) & 0xF)
    Reg[inst & 0xF] = a + imm
    PC += 2

def add():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    b = Reg[(inst >> 4) & 0xF]
    Reg[inst & 0xF] = a + b
    PC += 2

def sw():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    b = Reg[(inst >> 4) & 0xF]
    imm = SE(inst & 0xF)
    Mem[a + imm] = b
    PC += 2

def lw():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    imm = SE((inst >> 4) & 0xF)
    Reg[inst & 0xF] = Mem[a + imm]
    PC += 2

def bgt():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    b = Reg[(inst >> 4) & 0xF]
    imm = SE(inst & 0xF) << 1
    target = PC + imm
    if a > b:
        PC = target
    else:
        PC += 2  # Increment PC if condition is not met


def beq():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    b = Reg[(inst >> 4) & 0xF]
    imm = SE(inst & 0xF) << 1
    target = PC + imm
    if a == b:
        PC = target
    else:
        PC += 2

def jal():
    global PC
    inst = InstMem[PC]
    imm = SE((inst >> 8) & 0xFF) << 1
    PC += imm

def sub():
    global PC
    inst = InstMem[PC]
    a = Reg[(inst >> 8) & 0xF]
    b = Reg[(inst >> 4) & 0xF]
    Reg[inst & 0xF] = a - b
    PC += 2

# Test routines
def run_tests():
    # Reset memory and registers between tests
    global Reg, Mem, PC

    def reset():
        global Reg, Mem, PC
        Reg = [0] * 16
        Mem = [0] * 1024
        PC = 0

    # Test for 'addi'
    print("Testing 'addi'")
    reset()
    InstMem[0] = (1 << 8) | (3 << 4) | 2  # addi: R2 = R1 + 3; assuming R1=1
    Reg[1] = 1
    addi()
    assert Reg[2] == 4, "addi failed"
    print("addi passed")

    # Test for 'add'
    print("Testing 'add'")
    reset()
    InstMem[0] = (1 << 8) | (2 << 4) | 3  # add: R3 = R1 + R2; assuming R1=1, R2=2
    Reg[1] = 1
    Reg[2] = 2
    add()
    assert Reg[3] == 3, "add failed"
    print("add passed")

    # Test for 'sw'
    print("Testing 'sw'")
    reset()
    InstMem[0] = (1 << 8) | (2 << 4) | 3  # sw: Mem[R1+3] = R2; assuming R1=1, R2=5
    Reg[1] = 1
    Reg[2] = 5
    sw()
    assert Mem[4] == 5, "sw failed"
    print("sw passed")

    # Test for 'lw'
    print("Testing 'lw'")
    reset()
    Mem[4] = 8
    InstMem[0] = (1 << 8) | (3 << 4) | 3  # lw: R3 = Mem[R1+3]; assuming R1=1, Mem[4]=8
    Reg[1] = 1
    lw()
    assert Reg[3] == 8, "lw failed"
    print("lw passed")

    # Test for 'bgt'
    print("Testing 'bgt'")
    reset()
    InstMem[0] = (2 << 8) | (1 << 4) | 2  # bgt: if R2 > R1, PC += 4; assuming R1=1, R2=3
    Reg[1] = 1
    Reg[2] = 3
    bgt()
    assert PC == 4, "bgt failed"
    print("bgt passed")

    # Test for 'beq'
    print("Testing 'beq'")
    reset()
    InstMem[0] = (1 << 8) | (1 << 4) | 2  # beq: if R1 == R1, PC += 4; assuming R1=1
    Reg[1] = 1
    beq()
    assert PC == 4, "beq failed"
    print("beq passed")
    
    # Test for 'jal'
    print("Testing 'jal'")
    reset()
    InstMem[0] = (3 << 8)  # jal: PC += 6; immediate = 3
    jal()
    assert PC == 6, "jal failed"
    print("jal passed")

    # Test for 'sub'
    print("Testing 'sub'")
    reset()
    InstMem[0] = (2 << 8) | (1 << 4) | 3  # sub: R3 = R2 - R1; assuming R1=1, R2=3
    Reg[1] = 1
    Reg[2] = 3
    sub()
    assert Reg[3] == 2, "sub failed"
    print("sub passed")

    print("All tests passed!")


def encode_instruction(opcode, r1, r2, imm):
    return (opcode << 12) | (r1 << 8) | (r2 << 4) | imm

def mini_program_test():
    # Reset memory and registers
    reset()

    # Initializing an array in memory
    array = [1, 2, 3, 4, 5]  # Example array
    array_address = 10        # Starting address of the array in memory
    Mem[array_address:array_address + len(array)] = array

    # Writing a mini-program using our instruction set to calculate the sum
    # Assuming we use R1 for the sum, R2 for array elements, R3 as index, R4 for array size
    Reg[3] = array_address    # Starting address of the array
    Reg[4] = len(array)       # Size of the array

    # Program instructions
    program = [
        encode_instruction(1, 0, 0, 1),  # addi R1, R1, 0 (initialize R1 to 0)
        encode_instruction(3, 2, 3, 2),  # lw R2, R3 (R2 = Mem[R3])
        encode_instruction(2, 1, 1, 2),  # add R1, R1, R2 (R1 = R1 + R2)
        encode_instruction(1, 3, 3, 3),  # addi R3, R3, 1 (R3 = R3 + 1)
        encode_instruction(4, 4, 3, 0xFB),  # bgt R4, R3, -10 (if R4 > R3, jump back 10 bytes to continue loop)

    ]

    for i, inst in enumerate(program):
        InstMem[i * 2] = inst

    # Run the mini-program
    while PC < len(program) * 2:
        inst = InstMem[PC]
        opcode = inst >> 12
        print(f"Executing instruction at PC={PC}, inst={inst:04x}, opcode={opcode}")  # Enhanced debug output
        if opcode == 1:
            addi()
        elif opcode == 2:
            add()
        elif opcode == 3:
            lw()
        elif opcode == 4:
            bgt()
        else:
            print(f"Unrecognized opcode: {opcode}")
            break

    # Verify the result
    expected_sum = sum(array)
    assert Reg[1] == expected_sum, f"Mini-program failed, expected sum {expected_sum}, got {Reg[1]}"
    print(f"Mini-program passed, correctly calculated the sum of {array} as {Reg[1]}")

if __name__ == "__main__":
    run_tests()
    print("Running Mini-Program Test")
    mini_program_test()