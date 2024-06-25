module top ();

    import uvm_pkg::*;

    dut_if dut_if1();
    dut my_dut(._if(dut_if1));

    initial begin
        run_test("test");
    end
endmodule : top
