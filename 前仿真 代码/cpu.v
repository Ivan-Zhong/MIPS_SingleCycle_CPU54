module cpu (
    input clk,
    input rst,
    input [31:0] inst,
    input [31:0] DM_data_out,
    output [31:0] pc,
    output DM_cs,
    output DM_R,
    output DM_W_W,
    output DM_W_H,
    output DM_W_B,
    output [10:0] DM_addr,
    output [31:0] DM_data_in
);

wire [3:0] aluc;
wire [2:0] M1;
wire M2;
wire [1:0] M3;
wire [3:0] M4;
wire [1:0] M5;
wire [2:0] M6;
wire [2:0] M7;
wire RF_W;
wire HI_W, LO_W;
wire [31:0] npc;
wire [31:0] newpc;
wire [5:0] op;
wire [4:0] rsc;
wire [4:0] rtc;
wire [4:0] im_rdc;
wire [4:0] sa;
wire [5:0] func;
wire [4:0] ref_rdc;
wire [31:0] ref_rd;
wire [31:0] alu_a;
wire [31:0] alu_b;
wire [31:0] alu_out;
wire [31:0] rs;
reg [31:0] last_rs;
wire [31:0] rt;
wire [31:0] add_out;
wire [31:0] concat;
wire [31:0] zext5;
wire [31:0] sext16;
wire [31:0] zext16;
wire [31:0] sext18;
wire zero, carry, negative, overflow;
wire exception;
wire [4:0] cause;
wire [31:0] cp0_rdata;
wire [31:0] cp0_status;
wire [31:0] exc_addr;
wire [31:0] clz_output;
wire [31:0] DM_data_out_Z_Ext8;
wire [31:0] DM_data_out_S_Ext8;
wire [31:0] DM_data_out_Z_Ext16;
wire [31:0] DM_data_out_S_Ext16;
wire [31:0] hi_output;
wire [31:0] lo_output;
wire [31:0] hi_input;
wire [31:0] lo_input;
wire [63:0] MULT_result;
wire [63:0] MULTU_result;
reg div_start;
reg divu_start;
wire div_busy;
wire divu_busy;
wire [31:0] div_q;
wire [31:0] div_r;
wire [31:0] divu_q;
wire [31:0] divu_r;
wire [31:0] M1_temp1;
wire [31:0] M1_temp2;
wire [31:0] M1_temp3;
wire [31:0] M1_temp4;
wire [31:0] M3_temp;
wire [31:0] M4_temp1;
wire [31:0] M4_temp2;
wire [31:0] M4_temp3;
wire [31:0] M4_temp4;
wire [31:0] M4_temp5;
wire [31:0] M4_temp6;
wire [31:0] M4_temp7;
wire [31:0] M4_temp8;
wire [31:0] M4_temp9;
wire [31:0] M4_temp10;
wire [31:0] M5_temp;
wire [31:0] M6_temp1;
wire [31:0] M6_temp2;
wire [31:0] M6_temp3;
wire [31:0] M7_temp1;
wire [31:0] M7_temp2;
wire [31:0] M7_temp3;


assign npc = pc + 4;
assign op = inst[31:26];
assign rsc = inst[25:21]; // 指令中的5位rs
assign rtc = inst[20:16]; // 指令中的5位rt
assign im_rdc = inst[15:11]; // 指令中的5位rd
assign sa = inst[10:6];
assign func = inst[5:0];
assign concat = {pc[31:28], inst[25:0], 2'b00};
assign zext5 = {27'b0, sa};
assign sext16 = {{16{inst[15]}}, inst[15:0]};
assign zext16 = {16'b0, inst[15:0]};
assign sext18 = {{14{inst[15]}}, inst[15:0], 2'b0};
assign add_out = sext18 + npc;

wire _add_, _addu_, _sub_, _subu_, _and_, _or_, _xor_, _nor_, _slt_, _sltu_, _sll_, _srl_, _sra_, _sllv_, _srlv_, _srav_, _jr_;
wire _addi_, _addiu_, _andi_, _ori_, _xori_, _lw_, _sw_, _beq_, _bne_, _slti_, _sltiu_, _lui_, _j_, _jal_;
wire _div_, _divu_, _mul_, _mult_, _multu_, _bgez_, _jalr_, _lbu_, _lb_, _lhu_, _lh_, _sb_, _sh_, _break_, _syscall_, _eret_, _mfhi_, _mflo_, _mthi_, _mtlo_, _mfc0_, _mtc0_, _clz_, _teq_;

assign _add_ = (op == 6'b000000 && func == 6'b100000) ? 1'b1 : 1'b0;
assign _addu_ = (op == 6'b000000 && func == 6'b100001) ? 1'b1 : 1'b0;
assign _sub_ = (op == 6'b000000 && func == 6'b100010) ? 1'b1 : 1'b0;
assign _subu_ = (op == 6'b000000 && func == 6'b100011) ? 1'b1 : 1'b0;
assign _and_ = (op == 6'b000000 && func == 6'b100100) ? 1'b1 : 1'b0;
assign _or_ = (op == 6'b000000 && func == 6'b100101) ? 1'b1 : 1'b0;
assign _xor_ = (op == 6'b000000 && func == 6'b100110) ? 1'b1 : 1'b0;
assign _nor_ = (op == 6'b000000 && func == 6'b100111) ? 1'b1 : 1'b0;
assign _slt_ = (op == 6'b000000 && func == 6'b101010) ? 1'b1 : 1'b0;
assign _sltu_ = (op == 6'b000000 && func == 6'b101011) ? 1'b1 : 1'b0;
assign _sll_ = (op == 6'b000000 && func == 6'b000000) ? 1'b1 : 1'b0;
assign _srl_ = (op == 6'b000000 && func == 6'b000010) ? 1'b1 : 1'b0;
assign _sra_ = (op == 6'b000000 && func == 6'b000011) ? 1'b1 : 1'b0;
assign _sllv_ = (op == 6'b000000 && func == 6'b000100) ? 1'b1 : 1'b0;
assign _srlv_ = (op == 6'b000000 && func == 6'b000110) ? 1'b1 : 1'b0;
assign _srav_ = (op == 6'b000000 && func == 6'b000111) ? 1'b1 : 1'b0;
assign _jr_ = (op == 6'b000000 && func == 6'b001000) ? 1'b1 : 1'b0;
assign _addi_ = (op == 6'b001000) ? 1'b1 : 1'b0;
assign _addiu_ = (op == 6'b001001) ? 1'b1 : 1'b0;
assign _andi_ = (op == 6'b001100) ? 1'b1 : 1'b0;
assign _ori_ = (op == 6'b001101) ? 1'b1 : 1'b0;
assign _xori_ = (op == 6'b001110) ? 1'b1 : 1'b0;
assign _lw_ = (op == 6'b100011) ? 1'b1 : 1'b0;
assign _sw_ = (op == 6'b101011) ? 1'b1 : 1'b0;
assign _beq_ = (op == 6'b000100) ? 1'b1 : 1'b0;
assign _bne_ = (op == 6'b000101) ? 1'b1 : 1'b0;
assign _slti_ = (op == 6'b001010) ? 1'b1 : 1'b0;
assign _sltiu_ = (op == 6'b001011) ? 1'b1 : 1'b0;
assign _lui_ = (op == 6'b001111) ? 1'b1 : 1'b0;
assign _j_ = (op == 6'b000010) ? 1'b1 : 1'b0;
assign _jal_ = (op == 6'b000011) ? 1'b1 : 1'b0;
assign _div_ = (op == 6'b000000 && func == 6'b011010) ? 1'b1 : 1'b0;
assign _divu_ = (op == 6'b000000 && func == 6'b011011) ? 1'b1 : 1'b0;
assign _mul_ = (op == 6'b011100 && func == 6'b000010) ? 1'b1 : 1'b0;
assign _mult_ = (op == 6'b000000 && func == 6'b011000) ? 1'b1 : 1'b0;
assign _multu_ = (op == 6'b000000 && func == 6'b011001) ? 1'b1 : 1'b0;
assign _bgez_ = (op == 6'b000001) ? 1'b1 : 1'b0;
assign _jalr_ = (op == 6'b000000 && func == 6'b001001) ? 1'b1 : 1'b0;
assign _lbu_ = (op == 6'b100100) ? 1'b1 : 1'b0;
assign _lhu_ = (op == 6'b100101) ? 1'b1 : 1'b0;
assign _lb_ = (op == 6'b100000) ? 1'b1 : 1'b0;
assign _lh_ = (op == 6'b100001) ? 1'b1 : 1'b0;
assign _sb_ = (op == 6'b101000) ? 1'b1 : 1'b0;
assign _sh_ = (op == 6'b101001) ? 1'b1 : 1'b0;
assign _break_ = (op == 6'b000000 && func == 6'b001101) ? 1'b1 : 1'b0;
assign _syscall_ = (op == 6'b000000 && func == 6'b001100) ? 1'b1 : 1'b0;
assign _eret_ = (inst == 32'b010000_10000_00000_00000_00000_011000) ? 1'b1 : 1'b0;
assign _mfhi_ = (op == 6'b000000 && func == 6'b010000) ? 1'b1 : 1'b0;
assign _mflo_ = (op == 6'b000000 && func == 6'b010010) ? 1'b1 : 1'b0;
assign _mthi_ = (op == 6'b000000 && func == 6'b010001) ? 1'b1 : 1'b0;
assign _mtlo_ = (op == 6'b000000 && func == 6'b010011) ? 1'b1 : 1'b0;
assign _mfc0_ = (op == 6'b010000 && rsc == 5'b00000) ? 1'b1 : 1'b0;
assign _mtc0_ = (op == 6'b010000 && rsc == 5'b00100) ? 1'b1 : 1'b0;
assign _clz_ = (op == 6'b011100 && func == 6'b100000) ? 1'b1 : 1'b0;
assign _teq_ = (op == 6'b000000 && func == 6'b110100) ? 1'b1 : 1'b0;

always@(posedge clk)
begin
    if(_div_ && div_start == 0 && !div_busy)
        div_start <= 1;
    else if(_div_ && div_start == 1)
        div_start <= 0;
    else
        div_start <= 0;
end

always@(posedge clk)
begin
    if(_divu_ && divu_start == 0 && !divu_busy)
        divu_start <= 1;
    else if(_divu_ && divu_start == 1)
        divu_start <= 0;
    else
        divu_start <= 0;
end

always @(posedge clk) begin
    last_rs <= rs;
end

assign exception = _break_ || _syscall_ || (_teq_ && rs == rt);

assign cause = _syscall_ ? 5'b1000 : (_break_ ? 5'b1001 : (_teq_ ? 5'b1101 : 5'b00000));

assign aluc[3] = _sll_ || _lui_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _sra_ || _srav_ || _srl_ || _srlv_;

assign aluc[2] = _ori_ || _sll_ || _and_ || _andi_ || _nor_ || _or_ || _sllv_ || _sra_ || _srav_ || _srl_ || _srlv_ || _xor_ || _xori_;

assign aluc[1] = _sll_ || _add_ || _addi_ || _nor_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _sub_ || _xor_ || _xori_ || _sw_ || _lw_ || _lbu_ || _lb_ || _lh_ || _lhu_ || _sb_ || _sh_;

assign aluc[0] = _subu_ || _ori_ || _nor_ || _or_ || _slt_ || _slti_ || _srl_ || _srlv_ || _sub_ || _beq_ || _bne_;

assign M1[2] = _break_ || _syscall_ || _eret_ || (_teq_ && rs == rt) || (_div_ && div_start) || (_div_ && div_busy) || (_divu_ && divu_start) || (_divu_ && divu_busy);

assign M1[1] = _addu_ || _subu_ || _ori_ || _sll_ || _lw_ || _sw_ || _j_ || _add_ || _addi_ || _addiu_ || _and_ || _andi_ || _jal_ || _lui_ || _nor_ || _or_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _sra_ || _srav_ || _srl_ || _srlv_ || _sub_ || _xor_ || _xori_ || _mul_ || _mult_ || _multu_ || _lbu_ || _lhu_ || _lb_ || _lh_ || _sb_ || _sh_ || _mfhi_ || _mflo_ || _mthi_ || _mtlo_ || _mfc0_ || _mtc0_ || _clz_ || (_teq_ && rs != rt) || (_beq_ && zero == 0) || (_bne_ && zero == 1) || (_div_ && !div_busy && !div_start) || (_divu_ && !divu_busy && !divu_start) || (_bgez_ && rs[31] == 1);

assign M1[0] = (_beq_ == 1 && zero == 1) || (_j_ == 1) || (_bne_ == 1 && zero == 0) || (_jal_ == 1) || (_bgez_ == 1 && rs[31] == 0) || (_div_ && div_start) || (_div_ && div_busy) || (_divu_ && divu_start) || (_divu_ && divu_busy);

assign M2 = _addu_ || _subu_ || _ori_ || _lw_ || _sw_ || _beq_ || _add_ || _addi_ || _addiu_ || _and_ || _andi_ || _bne_ || _nor_ || _or_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _srav_ || _srlv_ || _sub_ || _xor_ || _xori_ || _lbu_ || _lhu_ || _lb_ || _lh_ || _sb_ || _sh_;

assign M3[1] = _lw_ || _sw_ || _addi_ || _addiu_ || _slti_ || _lhu_ || _lbu_ || _lh_ || _lb_ || _sb_ || _sh_;

assign M3[0] = _ori_ || _andi_ || _lui_ || _sltiu_ || _xori_;

assign M4[3] = _mul_ || _mfhi_ || _mflo_ || _mfc0_;

assign M4[2] = _lw_ || _jal_ || _jalr_ || _lhu_ || _lh_;

assign M4[1] = _lw_ || _jal_ || _mul_ || _jalr_ || _lbu_ || _lb_ || _mflo_;

assign M4[0] = _addu_ || _subu_ || _ori_ || _sll_ || _add_ || _addi_ || _addiu_ || _and_ || _andi_ || _jal_ || _lui_ || _nor_ || _or_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _sra_ || _srav_ || _srl_ || _srlv_ || _sub_ || _xor_ || _xori_ || _mul_ || _lbu_ || _lhu_ || _mfhi_ || _jalr_;

assign M5[1] = _jal_;

assign M5[0] = _ori_ || _lw_ || _addi_ || _addiu_ || _andi_ || _lui_ || _slti_ || _sltiu_ || _xori_ || _lbu_ || _lhu_ || _lb_ || _lh_ || _mfc0_;

assign M6[2] = _divu_;

assign M6[1] = _div_ || _multu_;

assign M6[0] = _div_ ||_mult_;

assign M7[2] = _divu_;

assign M7[1] = _div_ || _multu_;

assign M7[0] = _div_ ||_mult_;

assign RF_W = _addu_ || _subu_ || _ori_ || _sll_ || _lw_ || _add_ || _addi_ || _addiu_ || _and_ || _andi_ || _jal_ || _mul_ || _mfhi_ || _mflo_ || _mfc0_ || _clz_ || _lui_ || _nor_ || _or_ || _sllv_ || _slt_ || _slti_ || _sltiu_ || _sltu_ || _sra_ || _srav_ || _srl_ || _srlv_ || _sub_ || _xor_ || _xori_ || _jalr_ || _lbu_ || _lhu_ || _lb_ || _lh_;

assign DM_cs = _lw_ || _sw_ || _lb_ || _lbu_ || _lh_ || _lhu_ || _sb_ || _sh_;

assign DM_R = _lw_ || _lb_ || _lbu_ || _lh_ || _lhu_;

assign DM_W_W = _sw_;
assign DM_W_H = _sh_;
assign DM_W_B = _sb_;

assign HI_W = _div_ || _divu_ || _mult_ || _multu_ || _mthi_;

assign LO_W = _div_ || _divu_ || _mult_ || _multu_ || _mtlo_;

assign M1_temp1 = (M1[0] == 1) ? add_out : last_rs;
assign M1_temp2 = (M1[0] == 1) ? concat : npc;
assign M1_temp3 = (M1[0] == 1) ? pc : exc_addr;
assign M1_temp4 = (M1[1] == 1) ? M1_temp2 : M1_temp1;
assign newpc = (M1[2] == 1) ? M1_temp3 : M1_temp4;

assign alu_a = M2 ? rs : zext5;

assign M3_temp = M3[0] ? zext16 : rt;
assign alu_b = M3[1] ? sext16 : M3_temp;

assign M4_temp1 = M4[0] ? alu_out : clz_output;
assign M4_temp2 = M4[0] ? DM_data_out_Z_Ext8 : DM_data_out_S_Ext8;
assign M4_temp3 = M4[0] ? DM_data_out_Z_Ext16 : DM_data_out_S_Ext16;
assign M4_temp4 = M4[0] ? npc : DM_data_out;
assign M4_temp5 = M4[0] ? hi_output : cp0_rdata;
assign M4_temp6 = M4[0] ? MULT_result[31:0] : lo_output;
assign M4_temp7 = M4[1] ? M4_temp2 : M4_temp1;
assign M4_temp8 = M4[1] ? M4_temp4 : M4_temp3;
assign M4_temp9 = M4[1] ? M4_temp6 : M4_temp5;
assign M4_temp10 = M4[2] ? M4_temp8 : M4_temp7;
assign ref_rd = M4[3] ? M4_temp9 : M4_temp10;

assign M5_temp = M5[0] ? rtc : im_rdc;
assign ref_rdc = M5[1] ? 31 : M5_temp;

assign M6_temp1 = M6[0] ? MULT_result[31:0] : rs;
assign M6_temp2 = M6[0] ? div_q : MULTU_result[31:0];
assign M6_temp3 = M6[1] ? M6_temp2 : M6_temp1;
assign lo_input = M6[2] ? divu_q : M6_temp3;

assign M7_temp1 = M7[0] ? MULT_result[63:32] : rs;
assign M7_temp2 = M7[0] ? div_r : MULTU_result[63:32];
assign M7_temp3 = M7[1] ? M7_temp2 : M7_temp1;
assign hi_input = M7[2] ? divu_r : M7_temp3;

assign DM_addr = alu_out;

assign DM_data_in = rt;

assign DM_data_out_Z_Ext8 = {24'b0, DM_data_out[7:0]};
assign DM_data_out_S_Ext8 = {{24{DM_data_out[7]}}, DM_data_out[7:0]};
assign DM_data_out_Z_Ext16 = {16'b0, DM_data_out[15:0]};
assign DM_data_out_S_Ext16 = {{16{DM_data_out[15]}}, DM_data_out[15:0]};

alu ALU(.a(alu_a), .b(alu_b), .aluc(aluc), .r(alu_out), .zero(zero), .carry(carry), .negative(negative), .overflow(overflow));

regfile cpu_ref(.clk(clk), .rst(rst), .RF_W(RF_W), .rd(ref_rd), .rdc(ref_rdc), .rtc(rtc), .rsc(rsc), .rs(rs), .rt(rt));

pcreg PCREG(.clk(clk), .rst(rst), .newpc(newpc), .pc(pc));

cp0 CP0(.clk(clk), .rst(rst), .exception(exception), .mfc0(_mfc0_), .mtc0(_mtc0_), .eret(_eret_), .pc(pc), .rd(im_rdc), .wdata(rt), .cause(cause), .rdata(cp0_rdata), .status(cp0_status), .exc_addr(exc_addr));

clz clz_inst(.input_data(rs), .zero_number(clz_output));
    
hi hi_inst(.clk(clk), .rst(rst), .HI_W(HI_W), .hi_input(hi_input), .hi_output(hi_output));
lo lo_inst(.clk(clk), .rst(rst), .LO_W(LO_W), .lo_input(lo_input), .lo_output(lo_output));

MULT1 MULT1_inst(.a(rs), .b(rt), .result(MULT_result));
MULTU1 MULTU1_inst(.a(rs), .b(rt), .result(MULTU_result));

DIV DIV_inst(.dividend(rs), .divisor(rt), .start(div_start), .clock(clk), .reset(rst), .q(div_q), .r(div_r), .busy(div_busy));
DIVU DIVU_inst(.dividend(rs), .divisor(rt), .start(divu_start), .clock(clk), .reset(rst), .q(divu_q), .r(divu_r), .busy(divu_busy));
endmodule