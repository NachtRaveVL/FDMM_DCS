# FDMM_DCS
Fully Dynamic Multiplayer Mission for DCS: World.

**FDMM_DCS v0.02-alpha**  
**CURRENTLY UNDER DEVELOPMENT / PROPOSAL**

DCS: World multiplayer mission for server admins and air combat ethusiasts.  
Licensed under the non-restrictive MIT license.

Created by NachtRaveVL, Jan 5th, 2020.

------

FDMM aims to create a fully dynamic multiplayer mission for the DCS: World combat flight simulator that server admins can utilize for their own.

FDMM is visualized as, in time, including (and granted some of these items may turn out to not be as easy to accomplish as we necessarily hope, and may involve a good bit of time and effort):
- A raging Red vs. Blue ground & sea war with AI-enhanced battle groups that move, attack, defend, and patrol somewhat intelligently, units of which can encircle and capture enemy bases, take control of related infastructure, assault & defend high valued assets, set up defensive perimeters, etc. - all of which is heavily influenced by player actions through on-the-fly automated mission tasking and player-based AFAC.
- Actually useful JTAC/AWACS that operates on the basis of engaging players with missions based on their desired aircraft and play-style - players get to pick whatever mission style they want to participate in (if not wanting to be automatically assigned to one based on combat sitation), and the AI automatically attempts to create the combat situation if necessary for such a mission to have relevance.
- AI automatically scales conflict zones based on number of players active - war slows down and AI units focus more on patrols during off-hours when only a few players are around (or goes into total cease-fire mode when no players are active), and speeds up during on-hours when more players are active.
- Persistent map between server resets - a single full playthrough can take any length of time to determine the overall winner.
- Semi-realistic combat formations, unit naming, and force compositions based on real-life OoBs.
- No more infinite spawn or infinite resources - land, sea, air, and railway convoys spawn in at key map-edge locations that must be protected as they move to their intended drop-off locations in order for planes, ammunition, equipment, and fuel to be utilized by players.
- Downed pilots who get downed in enemy territory must escape said territory by catching a ride at a nearby roadway or risk being taken prisoner by enemy units that get dispatched to the downed pilot location - in the case downed pilots are captured then the enemy team is given random knowledge on positions of the opposite team's players and convoys.
- A command token reward system that gives players spendable tokens for completing missions related to the overall war effort that can be used to purchase support units (such as convoy escorts and target-lasing predator drones), combat actions (such as damaged unit repair and forward force replenishment), AI-assisted specialty missions (such as long range bomber strike attempts), player-based battlegroup AFAC, and even side-specific powers.
- Battlefield contains per-team command centers, air operation centers, repair centers, drone control stations, communication towers, etc. that have a real effect on what players can and can't do (for example, a team that loses their drone control station cannot request a drone fly-over to lase ground targets with).
- Repeatable base missions, such as air patrols, reconnaissance missions, etc. that allows for players to always have something to do and be rewarded for it.
- Random server-wide side missions that occur over time including fighting off rogue nation insurgents, assisting/defending against high-seas pirates, rescuing/breakout of POWs, etc. that gives players extra rewards for completing.
- Specialty missions for helicopters including search and rescue, base resupply, base building, infantry air assualt, ground & ship-borne SAR, and sub-hunting ASW missions including sonar buoy drops, sonar cable dips, and torpedo drops.
- Realistic weather that uses real-life weather data from real-life Georgia for determining in-game weather conditions, including an actual night mode for players who play late at night.
- Custom voice-overed radio repeater stations, including reports containing wind direction & speed, ground barometric pressure, etc.
- TV/radio stations, communication antennas, oil dericks, and oil pumps that can be destroyed, captured, & repaired, which affects how well friendly units in that area are able to coordinate together, and how much jet fuel is available for convoys to transport.

Additionally, FDMM will allow:
- Configurable server scripts that allows server admins to customize their server, set MOTD, set radio channels, and setup how the AI plays.
- Configurable time-era limitation (Korea, Vietnam, Cold War, Modern) to control what kinds of units are allowed to spawn (with reasonable fallbacks in case a particular unit type is not yet available in DCS).
- Configurable auto-kick and auto-warn scripts that automatically punishes players who don't fly safe.
- Friendly fire -punish and -forgive mechanics to allow players a choice in how to handle FF incidents.
- PvP and PvE support, with configurable AI difficulty, aggressiveness, etc.
- Other bells & whistles not listed here.

Other systems that FDDM is due to support:
- AIRBOSS (for ATC)
- Civilian Air Traffic (with some modification)
- Automated JTAC Lasing (for drones)
- (more to come soon)

**Currently under development, please check back later for updates.**

------

Help wanted: Are you a DCS script developer, livery artist, or other skilled mission editing guru? I can help you with some $(doe) if you can help me with some work on this project. Contact NachtRaveVL for details (her contact info can be found on her GitHub profile).
