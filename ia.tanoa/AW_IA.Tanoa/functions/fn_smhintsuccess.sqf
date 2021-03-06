	private ["_veh","_vehName","_vehVarname","_completeText","_reward","_GAU","_rabbit","_mortar"];

smRewards =
[
	["an Armed Blackfish", "B_T_VTOL_01_armed_F"],
	["a Blackfoot", "B_Heli_Attack_01_F"],
	["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],
	["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],
	["an AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F"],
	["an MBT-52 Kuma", "I_MBT_03_cannon_F"],
	["an Offroad (Repair)", "C_Offroad_01_repair_F"],
	["a Strider HMG", "I_MRAP_03_hmg_F"],
	["a Mobile Mortar Truck", "B_G_Offroad_01_repair_F"],
	["an MI-48 Kajman", "O_Heli_Attack_02_black_F"],
	["a PO-30 Orca", "O_Heli_Light_02_F"],
	["a WY-55 Hellcat", "I_Heli_light_03_F"],
	["an AH-9 Pawnee", "B_Heli_Light_01_armed_F"],
	["an IFV-6a Cheetah", "B_APC_Tracked_01_AA_F"],
	["an AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F"],
	["an MI-290 Taru (Transport)", "O_Heli_Transport_04_covered_F"],
	["an MI-290 Taru (Bench)", "O_Heli_Transport_04_bench_F"]
];
opforRewards = ["I_APC_tracked_03_cannon_F",
				"I_APC_Wheeled_03_cannon_F",
				"I_MBT_03_cannon_F",
				"I_MRAP_03_hmg_F",
				"O_Heli_Attack_02_black_F",
				"O_Heli_Light_02_F",
				"I_Heli_light_03_F",
				"O_Heli_Transport_04_covered_F",
				"O_Heli_Transport_04_bench_F"
];

smMarkerList =
["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 10-15 minutes.</t>",_vehName];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

[_completeText] remoteExec ["AW_fnc_globalHint",0,false];
["CompletedSideMission", sideMarkerText] remoteExec ["AW_fnc_globalNotification",0,false];
_rewardtext = format["Your team received %1!", _vehName];
["Reward",_rewardtext] remoteExec ["AW_fnc_globalNotification",0,false];


if (_reward isKindOf "B_Heli_Light_01_armed_F") exitWith { 
	_reward setObjectTexture[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'];
};
if (_reward isKindOf "B_G_Offroad_01_repair_F") exitWith {
	_mortar = createVehicle ["B_Mortar_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_mortar attachTo [_reward,[0,-2.5,.3]];
};

{
	if (_reward isKindOf _x) then {
		_reward setVariable ["tf_side", "west", true];
	}
} foreach opforRewards;


{
	_x addCuratorEditableObjects [[_reward], false];
} foreach allCurators;