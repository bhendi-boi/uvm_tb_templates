class env extends uvm_env;
    `uvm_component_utils(env)

    agnt agent;
    scb  scoreboard;

    function new(string name = "env", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Env", "Constructed environment", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Env", "Build phase environment", UVM_HIGH)
        agent = agnt::type_id::create("agent", this);
        scoreboard = scb::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("Env", "Connect phase environment", UVM_HIGH)

        // ? STEP 9: Change analysis imp port name if you've changed it in monitor or scoreboard
        agent.monitor.monitor_port.connect(scoreboard.scoreboard_port);
    endfunction


endclass
