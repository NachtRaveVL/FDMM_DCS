env.setErrorMessageBoxEnabled(false);
env.info("---FDMM_MissionStart Start---");

require('FDMM_Config');
require('FDMM_PortOps');

do
  trigger.action.outText("FDMM Started", 10)
  -- TODO: Me.
end

env.info("---FDMM_MissionStart End---");
