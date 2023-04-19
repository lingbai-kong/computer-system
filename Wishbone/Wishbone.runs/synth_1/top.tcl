# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.runs/synth_1/top.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.cache/wt [current_project]
set_property parent.project_path G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
add_files G:/document/semester6/ComputerSystemExperiment/Wishbone/bigendian_mips.coe
add_files G:/document/semester6/ComputerSystemExperiment/Wishbone/test.coe
read_verilog -library xil_defaultlib {
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/Asynchronous_D_FF.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/II.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/LLbit_reg.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeDEreg.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeEMreg.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeEXE.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeID.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeIF.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeIR.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeMEM.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeMWreg.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/PipeWB.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/alu.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/clo.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/clz.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/complement.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cp0.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cpmem.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cpu_defines.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cpu.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cpu_top.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/cu.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/sdram/ddr2_func_controller.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/sdram/ddr2_signal_controller.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/decoder.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/direct.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/div.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/divider.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/extend.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/gpio/gpio_defines.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/gpio/gpio_top.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/hi_lo_function.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/mult.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/mux.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/npc.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/pcreg.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/predictor.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/raminfr.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/cpu/regfile.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/flash/sd_func_controller.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/flash/sd_signal_controller.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/seg7x16.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/timescale.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_defines.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_debug_if.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_receiver.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_regs.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_rfifo.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_sync_flops.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_tfifo.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_top.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_transmitter.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/uart/uart_wb.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_defines.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_arb.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_master_if.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_msel.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_pri_dec.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_pri_enc.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_rf.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_slave_if.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/wishbone/wb_conmax_top.v
  G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/new/top.v
}
read_ip -quiet G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/ip/sd_buf/sd_buf.xci
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/sd_buf/sd_buf_ooc.xdc]

read_ip -quiet G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/ip/sdram/sdram.xci
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/sdram/sdram/user_design/constraints/sdram.xdc]
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/sdram/sdram/user_design/constraints/sdram_ooc.xdc]

read_ip -quiet G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ.xci
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ_board.xdc]
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ.xdc]
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_200MHZ/clk_wiz_200MHZ_ooc.xdc]

read_ip -quiet G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ.xci
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ_board.xdc]
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ.xdc]
set_property used_in_implementation false [get_files -all g:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.gen/sources_1/ip/clk_wiz_25MHZ/clk_wiz_25MHZ_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/constrs_1/new/wb.xdc
set_property used_in_implementation false [get_files G:/document/semester6/ComputerSystemExperiment/Wishbone/Wishbone.srcs/constrs_1/new/wb.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top top -part xc7a100tcsg324-1
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }