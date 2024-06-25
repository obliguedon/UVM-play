import uvm_pkg::*;
class driver extends uvm_driver;
    `uvm_component_utils(driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : driver
