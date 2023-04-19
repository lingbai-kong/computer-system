module ddr2_signal_controller(
    input clk,
    input rst,
    input clk_ref_i,
    output ddr2_ck_p,
    output ddr2_ck_n,
    output ddr2_cke,
    output ddr2_cs_n,
    output ddr2_ras_n,
    output ddr2_cas_n,
    output ddr2_we_n,
    output [1:0] ddr2_dm,
    output [2:0] ddr2_ba,
    output [12:0] ddr2_addr,
    inout [15:0] ddr2_dq,
    inout [1:0] ddr2_dqs_p,
    inout [1:0] ddr2_dqs_n,
    output [1:0] rdqs_n,//useless
    output ddr2_odt,

    input [31:0] addr_in,
    input [127:0] data_in,
    input stb_in,
    output reg ack_out,
    output [127:0] app_rd_data,
    output app_rd_data_valid,
    output app_rdy
    );
    wire [26:0] app_addr;
    reg [2:0] app_cmd;
    reg [2:0] app_cmd_wr;
    reg [26:0] app_addr_wr;
    reg app_en_wr;
    wire app_en;
    reg [127:0] app_wdf_data;
    reg app_wdf_end;
    reg app_wdf_wren;

    wire app_rd_data_end;
    wire app_wdf_rdy;
    wire app_sr_active;
    wire app_ref_ack;
    wire app_zq_ack;
    wire ui_clk;
    wire ui_clk_sync_rst;

    reg [2:0] app_cmd_pe;
    reg [26:0] app_addr_pe;
    reg app_en_pe;
    assign app_en = app_en_wr | app_en_pe;
	
    always @(*)
    begin
        if(stb_in&app_en_wr)
        begin
            app_cmd <= app_cmd_wr;
        end
        else if(~stb_in&app_en_pe)
        begin
             app_cmd <= app_cmd_pe;
        end
    end
    assign app_addr={addr_in,3'b0};
    reg [7:0] state;
    parameter IDLE = 8'd0,READ = 8'd1,WRITE = 8'd2;
	
    always @(posedge ui_clk)
    begin
        if(ui_clk_sync_rst) 
        begin
            app_en_pe <= 0;
            app_addr_pe<=0;
			
			app_cmd_wr <= 3'b1;
            app_en_wr <= 1'b0;
            app_wdf_data <= 128'h0;
            app_addr_wr <= 27'h0;
            app_wdf_end <= 1'b0;
            app_wdf_wren <= 1'b0;
            ack_out <= 0;
            state <= IDLE;
        end
        else if(~stb_in) 
		begin
			app_en_wr <= 0;
            app_wdf_wren <= 0;
            app_wdf_end <= 0;
            ack_out <= 0;
            case(state)
				IDLE:
				begin
					app_en_pe <= 1;
					app_addr_pe<={addr_in,3'b0};
					app_cmd_pe <= 3'b001;
					state <= READ;
				end
				READ:
				begin
					if(app_rdy) begin
						app_en_pe <= 1'b0;
						app_addr_pe<={addr_in,3'b0};
						state <= IDLE;
					end
				end
				default:state <= IDLE;
            endcase
        end 
        else 
		begin
            app_en_pe <= 1'b0;
			case(state)
                IDLE:
                begin
                    if(app_rdy & app_wdf_rdy) 
					begin
                        app_wdf_data <= data_in;
                        app_cmd_wr <= 3'b0;
                        app_addr_wr <= {addr_in,3'b0};
                        app_wdf_wren <= 1'b1;
                        app_wdf_end <= 1'b1;
                        app_en_wr <= 1'b1;
                        ack_out <= 0;
                        state <= WRITE;
                    end
                    else state <= IDLE; 
                end
                WRITE:
				begin
                    app_en_wr <= 1'b0;
                    app_cmd_wr <= 3'b1;
                    ack_out <= 1;
                    app_wdf_wren <= 1'b0;
                    app_wdf_end <= 0;
                    state <= IDLE;
                end
                default:state <= IDLE;
            endcase
        end 
    end
sdram ddr2_ram (
    .ddr2_addr(ddr2_addr),
    .ddr2_ba(ddr2_ba),
    .ddr2_cas_n(ddr2_cas_n),
    .ddr2_ck_n(ddr2_ck_n),
    .ddr2_ck_p(ddr2_ck_p),
    .ddr2_cke(ddr2_cke),
    .ddr2_ras_n(ddr2_ras_n),
    .ddr2_we_n(ddr2_we_n),   
    .ddr2_dq(ddr2_dq),
    .ddr2_dqs_n(ddr2_dqs_n),
    .ddr2_dqs_p(ddr2_dqs_p),
    .init_calib_complete(init_calib_complete),
    .ddr2_cs_n(ddr2_cs_n),
    .ddr2_dm(ddr2_dm),
    .ddr2_odt(ddr2_odt),
    .app_addr(app_addr),
    .app_cmd(app_cmd),
    .app_en(app_en),
    .app_wdf_data(app_wdf_data),
    .app_wdf_end(app_wdf_end),
    .app_wdf_wren(app_wdf_wren),
    .app_rd_data(app_rd_data),
    .app_rd_data_end(app_rd_data_end),
    .app_rd_data_valid(app_rd_data_valid),
    .app_rdy(app_rdy),
    .app_wdf_rdy(app_wdf_rdy),
    .app_sr_req(1'b0),
    .app_ref_req(1'b0),
    .app_zq_req(1'b0),
    .app_sr_active(app_sr_active),
    .app_ref_ack(app_ref_ack),
    .app_zq_ack(app_zq_ack),
    .ui_clk(ui_clk),
    .ui_clk_sync_rst(ui_clk_sync_rst),
    .app_wdf_mask(16'h0000),
    .sys_clk_i(clk),
    .clk_ref_i(clk_ref_i),
    .sys_rst(rst)
);
endmodule