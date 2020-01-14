env.info('---FDMM_MissionStart Start---')
env.setErrorMessageBoxEnabled(false)

fdmm = {}

require('FDMM_Config')
require('FDMM_MISTAdditions')
require('FDMM_MooseAdditions')
require('FDMM_Utils')
require('FDMM_Territory')
require('FDMM_Port')

do --FDMM_MissionStart

  fdmm.territory.createTerritories()

  fdmm.territory.dumpTerritories()

  trigger.action.outText('FDMM Started', 10)

end --FDMM_MissionStart

env.info('---FDMM_MissionStart End---')
