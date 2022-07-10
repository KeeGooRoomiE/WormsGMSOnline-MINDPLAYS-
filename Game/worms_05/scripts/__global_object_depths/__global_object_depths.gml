function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 999; // draw_c
	global.__objectDepths[1] = -99; // player_o
	global.__objectDepths[2] = -9999; // view_obj
	global.__objectDepths[3] = -9999; // view_xvvv
	global.__objectDepths[4] = 0; // worm_o
	global.__objectDepths[5] = 0; // bass
	global.__objectDepths[6] = 2; // obj_pm_terrain
	global.__objectDepths[7] = 0; // terr_001
	global.__objectDepths[8] = 0; // terr_002
	global.__objectDepths[9] = 0; // terr_003
	global.__objectDepths[10] = 0; // terr_004
	global.__objectDepths[11] = 99; // draw_c2
	global.__objectDepths[12] = -998; // panel_o
	global.__objectDepths[13] = -999; // buttom_g1
	global.__objectDepths[14] = -999; // buttom_g2
	global.__objectDepths[15] = -999; // buttom_g3
	global.__objectDepths[16] = -999; // buttom_g4
	global.__objectDepths[17] = 0; // but
	global.__objectDepths[18] = 98; // clv_o
	global.__objectDepths[19] = 998; // clouds
	global.__objectDepths[20] = -1; // poov_gfx
	global.__objectDepths[21] = -2; // water_o
	global.__objectDepths[22] = 2; // water2_o
	global.__objectDepths[23] = 0; // smoke_o
	global.__objectDepths[24] = 0; // smoke_buzu_o
	global.__objectDepths[25] = -1; // veiw_shake
	global.__objectDepths[26] = -1; // explore_o
	global.__objectDepths[27] = -1; // fire_exp
	global.__objectDepths[28] = 0; // bomba_1_o
	global.__objectDepths[29] = 0; // greenade_o
	global.__objectDepths[30] = 0; // petrol_o
	global.__objectDepths[31] = 0; // mina_o
	global.__objectDepths[32] = -9; // hk_line
	global.__objectDepths[33] = 0; // boshha_o
	global.__objectDepths[34] = 0; // both_o
	global.__objectDepths[35] = 0; // fire_min_o
	global.__objectDepths[36] = 0; // fire_creator


	global.__objectNames[0] = "draw_c";
	global.__objectNames[1] = "player_o";
	global.__objectNames[2] = "view_obj";
	global.__objectNames[3] = "view_xvvv";
	global.__objectNames[4] = "worm_o";
	global.__objectNames[5] = "bass";
	global.__objectNames[6] = "obj_pm_terrain";
	global.__objectNames[7] = "terr_001";
	global.__objectNames[8] = "terr_002";
	global.__objectNames[9] = "terr_003";
	global.__objectNames[10] = "terr_004";
	global.__objectNames[11] = "draw_c2";
	global.__objectNames[12] = "panel_o";
	global.__objectNames[13] = "buttom_g1";
	global.__objectNames[14] = "buttom_g2";
	global.__objectNames[15] = "buttom_g3";
	global.__objectNames[16] = "buttom_g4";
	global.__objectNames[17] = "but";
	global.__objectNames[18] = "clv_o";
	global.__objectNames[19] = "clouds";
	global.__objectNames[20] = "poov_gfx";
	global.__objectNames[21] = "water_o";
	global.__objectNames[22] = "water2_o";
	global.__objectNames[23] = "smoke_o";
	global.__objectNames[24] = "smoke_buzu_o";
	global.__objectNames[25] = "veiw_shake";
	global.__objectNames[26] = "explore_o";
	global.__objectNames[27] = "fire_exp";
	global.__objectNames[28] = "bomba_1_o";
	global.__objectNames[29] = "greenade_o";
	global.__objectNames[30] = "petrol_o";
	global.__objectNames[31] = "mina_o";
	global.__objectNames[32] = "hk_line";
	global.__objectNames[33] = "boshha_o";
	global.__objectNames[34] = "both_o";
	global.__objectNames[35] = "fire_min_o";
	global.__objectNames[36] = "fire_creator";


	// create another array that has the correct entries
	var len = array_length_1d(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}
