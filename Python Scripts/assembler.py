import re

def reg_to_bin(reg_name):
    return format(int(reg_name[1:]), '04b')

def imm_to_bin(imm_value, bits, signed=False):
    value = int(imm_value)
    if signed and value < 0:
        value = (1 << bits) + value
    return format(value, '0{}b'.format(bits))

def assemble_instruction(instruction):
    parts = re.split(r'[ ,]+', instruction)
    opcode = ''
    funct = ''
    rd = ''
    rs1 = ''
    rs2 = ''
    imm = ''
    
    if parts[0] in ['add', 'sub']:
        opcode = '000'
        funct = '0' if parts[0] == 'add' else '1'
        rd = reg_to_bin(parts[1])
        rs1 = reg_to_bin(parts[2])
        rs2 = reg_to_bin(parts[3])
        machine_code = f'{opcode}{funct}0000{rd}{rs1}{rs2}'
        
    elif parts[0] in ['addi', 'lw']:
        opcode = '001'
        funct = '0' if parts[0] == 'addi' else '1'
        rd = reg_to_bin(parts[1])
        rs1 = reg_to_bin(parts[2])
        imm = imm_to_bin(parts[3], 4, signed=True)
        machine_code = f'{opcode}{funct}{rd}{rs1}{imm}'
        
    elif parts[0] == 'sw':
        opcode = '010'
        rs2 = reg_to_bin(parts[1])
        rs1 = reg_to_bin(parts[2])
        imm = imm_to_bin(parts[3], 5)
        machine_code = f'{opcode}{rs1}{rs2}{imm}'
        
    elif parts[0] in ['beq', 'bgt']:
        opcode = '011'
        funct = '0' if parts[0] == 'beq' else '1'
        rs1 = reg_to_bin(parts[1])
        rs2 = reg_to_bin(parts[2])
        imm = imm_to_bin(parts[3], 4, signed=True)
        machine_code = f'{opcode}{funct}{rs1}{rs2}{imm}'
        
    elif parts[0] == 'jal':
        opcode = '100'
        rd = reg_to_bin(parts[1])
        imm = imm_to_bin(parts[2], 9, signed=True)
        machine_code = f'{imm}{rd}{opcode}'[:16]
        
    else:
        raise ValueError(f"Unsupported instruction: {parts[0]}")
    
    return format(int(machine_code, 2), '016b')
