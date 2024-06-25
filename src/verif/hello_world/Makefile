######################################################################
# Check for sanity to avoid later confusion

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

######################################################################
# Set up variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

SRC_DIR = ../../../src/rtl/hello_world/
UVM_DIR = ../../../uvm-verilator/src/
TEST_DIR = ./
UVM_LINT_CFG = ../../../uvm_pkg_lint_cfg.vlt


# Variables
TOP_MODULE = top
VERILATOR_FLAGS = -Wall # activate all warning
VERILATOR_FLAGS += --binary # tell verilator to do what's necesary to output a executable
VERILATOR_FLAGS += --trace-fst # output an waveform file if $dumpfile and $dumpvars are used in the Test Bench
VERILATOR_FLAGS += --timing # allow timming in the testbench
VERILATOR_FLAGS += -j 0 # Specify the level of parallelism. If zero, uses the number of threads in the current hardware.
VERILATOR_FLAGS += -Wno-fatal # Disable fatal exit on warnings

PACKAGES += $(shell readlink -f $(UVM_DIR)/uvm_pkg.sv)

SOURCES += $(shell readlink -f $(SRC_DIR)/hello_world.sv)

SOURCES += $(shell readlink -f $(TEST_DIR)/dut/dut_if.sv)
SOURCES += $(shell readlink -f $(TEST_DIR)/dut/dut.sv)

SOURCES += $(shell readlink -f $(TEST_DIR)/testbench/driver.sv)
SOURCES += $(shell readlink -f $(TEST_DIR)/testbench/env.sv)
SOURCES += $(shell readlink -f $(TEST_DIR)/testbench/test.sv)
SOURCES += $(shell readlink -f $(TEST_DIR)/testbench/top.sv)

INCDIR += -I$(shell readlink -f $(UVM_DIR))
INCDIR += -I$(shell readlink -f $(TEST_DIR))
INCDIR += -I$(shell readlink -f $(SRC_DIR))

DEFINES += +define+UVM_NO_DPI
# DEFINES += +define+SVA_ON

# Default target
all: run

compile: $(SOURCES) $(PACKAGES)
	$(info ========== compiling sources ==========)
	$(VERILATOR) $(VERILATOR_FLAGS) $(DEFINES) --top-module $(TOP_MODULE) $(UVM_LINT_CFG) $(INCDIR) $(PACKAGES) $(SOURCES)

run: compile
	$(info ========== run the binary ==========)
	@rm -rf log
	@mkdir -p log
	./obj_dir/V$(TOP_MODULE) +trace

clean:
	$(info ========== delete obj_dir ==========)
	@rm -rf obj_dir
