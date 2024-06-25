import uvm_pkg::*;
class test extends uvm_test;
    `uvm_component_utils(test)

    env env_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(string name, uvm_component parent);
        env_h = env::type_id::create("env_h", this);
    endfunction : build_phase

endclass : test
