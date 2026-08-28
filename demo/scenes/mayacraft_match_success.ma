//Maya ASCII 2025ff03 scene
//Name: mayacraft_match_success.ma
//Last modified: Thu, Aug 27, 2026 08:38:45 PM
//Codeset: 936
requires maya "2025ff03";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2025";
fileInfo "version" "2025";
fileInfo "cutIdentifier" "202607282326-cffc1a54f2";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "A0B1C8B3-4478-9501-AFEE-8EBA28813442";
createNode transform -s -n "persp";
	rename -uid "41DC7D25-4304-9E18-F116-9C810B80BA99";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "5AEB7BF9-4DE8-BBFB-248D-73B47EC84569";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "ED947277-4C2E-8473-E848-459741154762";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "7F611B03-41F6-4202-07A4-7EABB21D0303";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "BD44F7DB-46D3-73C4-8268-A597A05C252D";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "44139BFA-4465-B3E3-424F-BC879801D695";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "8F0DBC93-47DC-8DEE-4835-798E40ECAD6C";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "A424F197-4569-A77E-7F2B-5FBFF0CD3F20";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode joint -n "root_JNT";
	rename -uid "90C1004E-46D5-EBA6-81A4-858F81F7CED4";
	addAttr -ci true -sn "mayacraftDemoScenario" -ln "mayacraftDemoScenario" -dt "string";
	addAttr -ci true -sn "mayacraftExpectedResult" -ln "mayacraftExpectedResult" -dt "string";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".mayacraftDemoScenario" -type "string" "FK_TO_IK_SUCCESS";
	setAttr ".mayacraftExpectedResult" -type "string" "第 12 帧预览 FK→IK 后应用，输出骨架无跳变并生成关键帧";
createNode joint -n "pelvis_JNT" -p "root_JNT";
	rename -uid "9AF92F62-4252-40C2-DB1E-EFA4A4DEFFB4";
	setAttr ".t" -type "double3" 0 10 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "spine_JNT" -p "pelvis_JNT";
	rename -uid "1E225A9B-4E75-5F94-9B38-14961DE51C47";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "chest_JNT" -p "spine_JNT";
	rename -uid "83BE7B0D-463C-D28F-C877-8098C614B66A";
	setAttr ".t" -type "double3" 0 4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "neck_JNT" -p "chest_JNT";
	rename -uid "9F789CFC-494E-B007-3C3F-1ABF13F1B8A3";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "head_JNT" -p "neck_JNT";
	rename -uid "2127D0A7-4368-21D7-3FE8-01993350885A";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_upperArm_JNT" -p "chest_JNT";
	rename -uid "AB63C5A7-43DD-98BB-A402-21A323244E5B";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_forearm_JNT" -p "L_upperArm_JNT";
	rename -uid "5AE0C4CF-43F1-DAAE-3872-DD8DA0FEE64A";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_hand_JNT" -p "L_forearm_JNT";
	rename -uid "A673F1D9-4725-433C-C9B1-4FB2E319B27B";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_upperArm_JNT" -p "chest_JNT";
	rename -uid "F5FED512-4AC3-E907-2692-23A3EE1879BD";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_forearm_JNT" -p "R_upperArm_JNT";
	rename -uid "3868256E-4A6B-0D55-66FC-35A42148F762";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_hand_JNT" -p "R_forearm_JNT";
	rename -uid "8C5A7896-4EFD-3F9A-CC0F-B2BA4A571631";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_thigh_JNT" -p "pelvis_JNT";
	rename -uid "A9D29317-463B-0EE3-E53D-A6BC46C05047";
	setAttr ".t" -type "double3" 3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_calf_JNT" -p "L_thigh_JNT";
	rename -uid "D3228667-467B-4EA3-6315-21B5CDC8779F";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_foot_JNT" -p "L_calf_JNT";
	rename -uid "3638EC76-49A1-9E5C-5D8B-9E97DEA51988";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_thigh_JNT" -p "pelvis_JNT";
	rename -uid "536149B1-4797-7E4C-C56C-CCB0BAC15AA0";
	setAttr ".t" -type "double3" -3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_calf_JNT" -p "R_thigh_JNT";
	rename -uid "55DC24DF-42F9-BE68-3B38-A98FFA109219";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_foot_JNT" -p "R_calf_JNT";
	rename -uid "E133F93B-40A9-4DE1-2209-CE90235ECCFB";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode transform -n "MC_RIG";
	rename -uid "A4659DB8-4474-1979-5C71-448753C9B098";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.root";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "MC_CONTROLS" -p "MC_RIG";
	rename -uid "708D3DF9-437D-EF28-9C57-5C9E14359B76";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.controls";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_arm_MOD" -p "MC_CONTROLS";
	rename -uid "B6251E19-435B-6747-5D0C-0AA4C11A5357";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_upperArm_FK_CTRL" -p "L_arm_MOD";
	rename -uid "311828F1-4133-40E6-F4ED-448A36CFC9DF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 4 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_FK_CTRLShape" -p "L_upperArm_FK_CTRL";
	rename -uid "C7B04686-495A-33ED-EF1D-BE97103B9CB9";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_forearm_FK_CTRL" -p "L_upperArm_FK_CTRL";
	rename -uid "F142892E-4AF6-6987-4FE9-9B97B99D485B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_FK_CTRLShape" -p "L_forearm_FK_CTRL";
	rename -uid "DAB58802-4D36-58E3-BECB-1DBCE7734B34";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_hand_FK_CTRL" -p "L_forearm_FK_CTRL";
	rename -uid "671ADF27-43EF-D8A4-9419-01B644811AA9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode nurbsCurve -n "L_hand_FK_CTRLShape" -p "L_hand_FK_CTRL";
	rename -uid "B4C49700-4B69-F1CD-5263-369FCECED655";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_arm_IK_SPACE" -p "L_arm_MOD";
	rename -uid "5971C594-4CB8-24C5-4048-3B8CD281980D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_hand_IK_CTRL" -p "L_arm_IK_SPACE";
	rename -uid "CB172242-438F-3D5C-1B01-FFBB18BBCA0A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "全局:胸口" -at "enum";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	addAttr -ci true -h true -k true -sn "matchCorr0X" -ln "matchCorr0X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Y" -ln "matchCorr0Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Z" -ln "matchCorr0Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1X" -ln "matchCorr1X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Y" -ln "matchCorr1Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Z" -ln "matchCorr1Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2X" -ln "matchCorr2X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Y" -ln "matchCorr2Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Z" -ln "matchCorr2Z" -at "doubleAngle";
	setAttr ".t" -type "double3" 11 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"customEnum:space\",\"\\u5168\\u5c40:\\u80f8\\u53e3|0\"],[\"customFloat:ikFk\",\"0|0|1\"],[\"customFloat:twist\",\"0|-180|180\"],[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".ikFk";
	setAttr -k on ".twist";
	setAttr -k on ".space";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
	setAttr -k on ".matchCorr0X";
	setAttr -k on ".matchCorr0Y";
	setAttr -k on ".matchCorr0Z";
	setAttr -k on ".matchCorr1X";
	setAttr -k on ".matchCorr1Y";
	setAttr -k on ".matchCorr1Z";
	setAttr -k on ".matchCorr2X";
	setAttr -k on ".matchCorr2Y";
	setAttr -k on ".matchCorr2Z";
createNode nurbsCurve -n "L_hand_IK_CTRLShape" -p "L_hand_IK_CTRL";
	rename -uid "166DB084-4B39-359B-C09F-4696FBE4D8DB";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode ikHandle -n "l_arm_rp_ik_IKH" -p "L_hand_IK_CTRL";
	rename -uid "D6308519-4721-1043-2BAA-1C8B8BF0E1FA";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 -7.2214122865917672e-08 ;
	setAttr ".roc" yes;
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.rp_ik";
	setAttr ".mayacraftRigBehaviorType" -type "string" "rp_ik";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.ik.ctrl|l_arm.pole.ctrl\"],[\"targets\",\"l_arm.ik_joint.0|l_arm.ik_joint.1|l_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_arm_rp_ik_PVC" -p "l_arm_rp_ik_IKH";
	rename -uid "C6890558-445D-EF93-B7AA-9B954B7DF847";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_arm_POLE_CTRLW0" -dv 1 -min 0 -at "double";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".rst" -type "double3" 4 0 4.55 ;
	setAttr -k on ".w0";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode transform -n "L_arm_POLE_CTRL" -p "L_arm_MOD";
	rename -uid "86897E32-49D1-AEBA-D909-6AA5667A5A53";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 8 17 4.55 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.pole.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_arm|left_lower_arm|left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_arm_POLE_CTRLShape" -p "L_arm_POLE_CTRL";
	rename -uid "FDBC49D0-4A8A-AD85-FEE0-CFA5B0848797";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		0 0 1.2
		1.2 0 0
		0 0 -1.2
		-1.2 0 0
		0 0 1.2
		;
createNode transform -n "L_leg_MOD" -p "MC_CONTROLS";
	rename -uid "2A2CA6AC-4834-868F-B42C-47942FACBB83";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_thigh_FK_CTRL" -p "L_leg_MOD";
	rename -uid "63AD33EC-4F94-1617-F4A8-7487F994FC65";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 9 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_FK_CTRLShape" -p "L_thigh_FK_CTRL";
	rename -uid "66B3F84D-4209-1950-D4BF-EE9965571C70";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_calf_FK_CTRL" -p "L_thigh_FK_CTRL";
	rename -uid "8EA41E15-431F-4F69-DA2F-C7A9F6D186D4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_FK_CTRLShape" -p "L_calf_FK_CTRL";
	rename -uid "B48545FF-4789-B098-FF30-B59FA21FCB71";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_foot_FK_CTRL" -p "L_calf_FK_CTRL";
	rename -uid "D6C667DB-4516-BF95-29EB-D995819F4763";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode nurbsCurve -n "L_foot_FK_CTRLShape" -p "L_foot_FK_CTRL";
	rename -uid "8BB72AAB-4318-348D-5F38-139F1E646BF8";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "L_leg_IK_SPACE" -p "L_leg_MOD";
	rename -uid "2493C692-4459-CE46-5D41-189B5A3C7656";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_foot_IK_CTRL" -p "L_leg_IK_SPACE";
	rename -uid "FDBC74A7-4BEB-5E85-D35F-4E88360831A3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "全局:胸口" -at "enum";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	addAttr -ci true -h true -k true -sn "matchCorr0X" -ln "matchCorr0X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Y" -ln "matchCorr0Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Z" -ln "matchCorr0Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1X" -ln "matchCorr1X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Y" -ln "matchCorr1Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Z" -ln "matchCorr1Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2X" -ln "matchCorr2X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Y" -ln "matchCorr2Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Z" -ln "matchCorr2Z" -at "doubleAngle";
	setAttr ".t" -type "double3" 3 1 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"customEnum:space\",\"\\u5168\\u5c40:\\u80f8\\u53e3|0\"],[\"customFloat:ikFk\",\"0|0|1\"],[\"customFloat:twist\",\"0|-180|180\"],[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".ikFk";
	setAttr -k on ".twist";
	setAttr -k on ".space";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
	setAttr -k on ".matchCorr0X";
	setAttr -k on ".matchCorr0Y";
	setAttr -k on ".matchCorr0Z";
	setAttr -k on ".matchCorr1X";
	setAttr -k on ".matchCorr1Y";
	setAttr -k on ".matchCorr1Z";
	setAttr -k on ".matchCorr2X";
	setAttr -k on ".matchCorr2Y";
	setAttr -k on ".matchCorr2Z";
createNode nurbsCurve -n "L_foot_IK_CTRLShape" -p "L_foot_IK_CTRL";
	rename -uid "A3859EBD-4775-FC54-E142-BA8FDC352AA7";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode ikHandle -n "l_leg_rp_ik_IKH" -p "L_foot_IK_CTRL";
	rename -uid "0DEF7A11-4A6E-178A-6512-1797ACA82DA5";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".roc" yes;
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.rp_ik";
	setAttr ".mayacraftRigBehaviorType" -type "string" "rp_ik";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.ik.ctrl|l_leg.pole.ctrl\"],[\"targets\",\"l_leg.ik_joint.0|l_leg.ik_joint.1|l_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_leg_rp_ik_PVC" -p "l_leg_rp_ik_IKH";
	rename -uid "BA6FC43F-4594-370D-49B9-449EE9822720";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_leg_POLE_CTRLW0" -dv 1 -min 0 -at "double";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".rst" -type "double3" 0 -4.6549057100000004 -5.2392456999999997 ;
	setAttr -k on ".w0";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode transform -n "L_leg_POLE_CTRL" -p "L_leg_MOD";
	rename -uid "9A0163C3-4678-E008-04DF-1BB827E8269F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 4.3450942899999996 -5.2392456999999997 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.pole.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_leg|left_lower_leg|left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_leg_POLE_CTRLShape" -p "L_leg_POLE_CTRL";
	rename -uid "0095AD1B-4BA5-58AA-3F37-3EB719504B4D";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		0 0 1.2
		1.2 0 0
		0 0 -1.2
		-1.2 0 0
		0 0 1.2
		;
createNode transform -n "R_arm_MOD" -p "MC_CONTROLS";
	rename -uid "A6ABE3A0-4ABC-5A8B-C24C-589CD2BE0A02";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_upperArm_FK_CTRL" -p "R_arm_MOD";
	rename -uid "C04EAE7A-425D-7C28-9C06-6F86624743BC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -4 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_FK_CTRLShape" -p "R_upperArm_FK_CTRL";
	rename -uid "02E79264-4A4D-9671-8225-C7B9C1F39358";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_forearm_FK_CTRL" -p "R_upperArm_FK_CTRL";
	rename -uid "98E0A143-4ED3-6200-C45D-1896D5515CF4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_FK_CTRLShape" -p "R_forearm_FK_CTRL";
	rename -uid "715B3F08-414E-060A-EE26-F6A331D68CB8";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_hand_FK_CTRL" -p "R_forearm_FK_CTRL";
	rename -uid "93B73FFF-4851-B6FE-8CED-71A3818812F5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode nurbsCurve -n "R_hand_FK_CTRLShape" -p "R_hand_FK_CTRL";
	rename -uid "25B04C72-47FC-040E-46AA-10A75A9128FA";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_arm_IK_SPACE" -p "R_arm_MOD";
	rename -uid "87F697A5-4A2B-23AD-8CDE-EEAFEF2111EE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_hand_IK_CTRL" -p "R_arm_IK_SPACE";
	rename -uid "1AFC6B1D-44A9-9154-C224-31B93AADF8F4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "全局:胸口" -at "enum";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	addAttr -ci true -h true -k true -sn "matchCorr0X" -ln "matchCorr0X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Y" -ln "matchCorr0Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Z" -ln "matchCorr0Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1X" -ln "matchCorr1X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Y" -ln "matchCorr1Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Z" -ln "matchCorr1Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2X" -ln "matchCorr2X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Y" -ln "matchCorr2Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Z" -ln "matchCorr2Z" -at "doubleAngle";
	setAttr ".t" -type "double3" -11 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"customEnum:space\",\"\\u5168\\u5c40:\\u80f8\\u53e3|0\"],[\"customFloat:ikFk\",\"0|0|1\"],[\"customFloat:twist\",\"0|-180|180\"],[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".ikFk";
	setAttr -k on ".twist";
	setAttr -k on ".space";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
	setAttr -k on ".matchCorr0X";
	setAttr -k on ".matchCorr0Y";
	setAttr -k on ".matchCorr0Z";
	setAttr -k on ".matchCorr1X";
	setAttr -k on ".matchCorr1Y";
	setAttr -k on ".matchCorr1Z";
	setAttr -k on ".matchCorr2X";
	setAttr -k on ".matchCorr2Y";
	setAttr -k on ".matchCorr2Z";
createNode nurbsCurve -n "R_hand_IK_CTRLShape" -p "R_hand_IK_CTRL";
	rename -uid "64F82A4C-47EA-EA94-B14D-5685DFAB113D";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode ikHandle -n "r_arm_rp_ik_IKH" -p "R_hand_IK_CTRL";
	rename -uid "4E4CA30F-42C8-208F-7B02-6C860C11481C";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 7.2215905503431838e-08 ;
	setAttr ".roc" yes;
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.rp_ik";
	setAttr ".mayacraftRigBehaviorType" -type "string" "rp_ik";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.ik.ctrl|r_arm.pole.ctrl\"],[\"targets\",\"r_arm.ik_joint.0|r_arm.ik_joint.1|r_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_arm_rp_ik_PVC" -p "r_arm_rp_ik_IKH";
	rename -uid "5657904B-4598-DFE9-1C0C-C78E5961C1A0";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_arm_POLE_CTRLW0" -dv 1 -min 0 -at "double";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".rst" -type "double3" -4 0 -4.55 ;
	setAttr -k on ".w0";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode transform -n "R_arm_POLE_CTRL" -p "R_arm_MOD";
	rename -uid "68FF0F18-45DE-5721-5D0B-058AC3C0E490";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -8 17 -4.55 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.pole.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_arm|right_lower_arm|right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,-4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_arm_POLE_CTRLShape" -p "R_arm_POLE_CTRL";
	rename -uid "54B13594-4E88-4915-2CF1-81BC288790B2";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		0 0 1.2
		1.2 0 0
		0 0 -1.2
		-1.2 0 0
		0 0 1.2
		;
createNode transform -n "R_leg_MOD" -p "MC_CONTROLS";
	rename -uid "A2902001-4DD4-8FB8-3BDE-CE95275A398E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_thigh_FK_CTRL" -p "R_leg_MOD";
	rename -uid "DA357FA8-4236-1A13-CECD-24B788D883E7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 9 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_FK_CTRLShape" -p "R_thigh_FK_CTRL";
	rename -uid "ABF7DEB4-4CB4-2319-1ABC-A0A9C96BFA48";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_calf_FK_CTRL" -p "R_thigh_FK_CTRL";
	rename -uid "80B31995-40DA-9143-0C66-F5AEF2029B46";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_FK_CTRLShape" -p "R_calf_FK_CTRL";
	rename -uid "ED6E6898-4380-822F-8B71-9F99335B8442";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_foot_FK_CTRL" -p "R_calf_FK_CTRL";
	rename -uid "5312FF01-4D52-0A47-7EE3-F4AA7D2734E4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode nurbsCurve -n "R_foot_FK_CTRLShape" -p "R_foot_FK_CTRL";
	rename -uid "EF5C8E42-4BB7-AC9B-ABBC-7488BBF5D0A0";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "R_leg_IK_SPACE" -p "R_leg_MOD";
	rename -uid "9265474F-45F3-5EDC-3DB2-ACA07DCA2497";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_foot_IK_CTRL" -p "R_leg_IK_SPACE";
	rename -uid "3A51A47C-49E6-FFFB-1161-5E8A1E589E47";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "全局:胸口" -at "enum";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	addAttr -ci true -h true -k true -sn "matchCorr0X" -ln "matchCorr0X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Y" -ln "matchCorr0Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr0Z" -ln "matchCorr0Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1X" -ln "matchCorr1X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Y" -ln "matchCorr1Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr1Z" -ln "matchCorr1Z" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2X" -ln "matchCorr2X" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Y" -ln "matchCorr2Y" -at "doubleAngle";
	addAttr -ci true -h true -k true -sn "matchCorr2Z" -ln "matchCorr2Z" -at "doubleAngle";
	setAttr ".t" -type "double3" -3 1 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"customEnum:space\",\"\\u5168\\u5c40:\\u80f8\\u53e3|0\"],[\"customFloat:ikFk\",\"0|0|1\"],[\"customFloat:twist\",\"0|-180|180\"],[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".ikFk";
	setAttr -k on ".twist";
	setAttr -k on ".space";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
	setAttr -k on ".matchCorr0X";
	setAttr -k on ".matchCorr0Y";
	setAttr -k on ".matchCorr0Z";
	setAttr -k on ".matchCorr1X";
	setAttr -k on ".matchCorr1Y";
	setAttr -k on ".matchCorr1Z";
	setAttr -k on ".matchCorr2X";
	setAttr -k on ".matchCorr2Y";
	setAttr -k on ".matchCorr2Z";
createNode nurbsCurve -n "R_foot_IK_CTRLShape" -p "R_foot_IK_CTRL";
	rename -uid "0D39E22F-47BA-7267-7C03-409FD76DF2BD";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode ikHandle -n "r_leg_rp_ik_IKH" -p "R_foot_IK_CTRL";
	rename -uid "FA2F8D8E-48F8-3BAC-BFC1-BE96BAD07BAC";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".roc" yes;
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.rp_ik";
	setAttr ".mayacraftRigBehaviorType" -type "string" "rp_ik";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.ik.ctrl|r_leg.pole.ctrl\"],[\"targets\",\"r_leg.ik_joint.0|r_leg.ik_joint.1|r_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_leg_rp_ik_PVC" -p "r_leg_rp_ik_IKH";
	rename -uid "6384644C-4AE1-75AC-F9B9-46839D6F5F54";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_leg_POLE_CTRLW0" -dv 1 -min 0 -at "double";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".rst" -type "double3" 0 -4.6549057100000004 -5.2392456999999997 ;
	setAttr -k on ".w0";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode transform -n "R_leg_POLE_CTRL" -p "R_leg_MOD";
	rename -uid "91204F15-440A-2556-D8D5-BB9AEAA7CBB9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 4.3450942899999996 -5.2392456999999997 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.pole.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_leg|right_lower_leg|right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_leg_POLE_CTRLShape" -p "R_leg_POLE_CTRL";
	rename -uid "961761B8-4EBC-ED92-C067-50AC7F00E689";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		0 0 1.2
		1.2 0 0
		0 0 -1.2
		-1.2 0 0
		0 0 1.2
		;
createNode transform -n "C_spine_MOD" -p "MC_CONTROLS";
	rename -uid "1C3C3642-4853-83BC-ECD4-FAAAECCB91E0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "C_chest_FK_CTRL" -p "C_spine_MOD";
	rename -uid "A7569AA7-4E51-BBED-7F86-6DB620C3C21A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode nurbsCurve -n "C_chest_FK_CTRLShape" -p "C_chest_FK_CTRL";
	rename -uid "A302CB9D-43E8-D532-6D22-7886CFEC80DB";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "C_head_FK_CTRL" -p "C_chest_FK_CTRL";
	rename -uid "765F5210-40B9-ECE6-6F70-CC952E49767F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 6 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "head.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode nurbsCurve -n "C_head_FK_CTRLShape" -p "C_head_FK_CTRL";
	rename -uid "5A1F66DD-4B7F-8DA0-8D10-D6A14D3E3D3A";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 12 2 no 3
		17 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
		15
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		-6.9384541043613404e-17 0.65421611320128581 1.1331355471948585
		-8.0118366898257647e-17 4.3031566861107558e-16 1.3084322264025705
		-6.9384541043613429e-17 -0.65421611320128525 1.133135547194859
		-4.0059183449128867e-17 -1.1331355471948581 0.65421611320128592
		-5.0571605606661081e-32 -1.3084322264025707 8.2589699563777897e-16
		4.0059183449128787e-17 -1.1331355471948588 -0.6542161132012847
		6.9384541043613379e-17 -0.65421611320128625 -1.1331355471948581
		8.011836689825766e-17 -1.2337002139999739e-15 -1.3084322264025707
		6.9384541043613429e-17 0.65421611320128459 -1.133135547194859
		4.0059183449128928e-17 1.1331355471948574 -0.65421611320128692
		-2.2711671100646748e-32 1.3084322264025712 3.7090973685571215e-16
		-4.0059183449128817e-17 1.1331355471948583 0.65421611320128514
		;
createNode transform -n "MC_DEFORM" -p "MC_RIG";
	rename -uid "9A04E478-4C53-EAB3-8E6B-0EB26DD68266";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "BC090179-4E6B-A5EC-7B12-34A70B78C357";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_FK_DRV_JNT" -p "L_upperArm_FK_DRV_JNT";
	rename -uid "BCF466B6-4711-BBDD-3E71-4E882FAB3169";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_FK_DRV_JNT" -p "L_forearm_FK_DRV_JNT";
	rename -uid "17E2062B-4386-1539-796A-88BA8C48EC33";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "F314F60F-4F07-03C5-4212-568F48BDD578";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 4 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_IK_DRV_JNT" -p "L_upperArm_IK_DRV_JNT";
	rename -uid "B3A2C0C1-48E2-0410-C1CA-828137C28F16";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".r" -type "double3" 0 1.3791881538187516e-06 0 ;
	setAttr ".pa" -type "double3" 0 90 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_IK_DRV_JNT" -p "L_forearm_IK_DRV_JNT";
	rename -uid "01465A9E-4F38-9736-1E13-86A35482C415";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode ikEffector -n "effector1" -p "L_forearm_IK_DRV_JNT";
	rename -uid "9BE0184C-4812-9040-498C-5BA63B979DE7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode joint -n "L_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "F0BBED28-4B96-9969-BE65-B6B94F09A868";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_FK_DRV_JNT" -p "L_thigh_FK_DRV_JNT";
	rename -uid "6C2B6174-473A-AE30-B258-BDB0832DA9C9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_FK_DRV_JNT" -p "L_calf_FK_DRV_JNT";
	rename -uid "458521E5-464E-9C13-A5D2-0BBEBDAEE1AB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "L_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "5201661C-4CAC-2813-542B-6E91E4B8DFD5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 9 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_IK_DRV_JNT" -p "L_thigh_IK_DRV_JNT";
	rename -uid "FA72C88F-4DEB-7BD9-7184-7A8D16F1DC19";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_IK_DRV_JNT" -p "L_calf_IK_DRV_JNT";
	rename -uid "BF3ABA90-4148-6D5D-F85C-D693615DC740";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode ikEffector -n "effector2" -p "L_calf_IK_DRV_JNT";
	rename -uid "63343FE1-4803-DACE-2301-AF8F30328CD1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode joint -n "R_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "4A842342-455D-310D-F1B6-9B949D430014";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_FK_DRV_JNT" -p "R_upperArm_FK_DRV_JNT";
	rename -uid "99FE9F11-4B65-9710-F51E-3B8C6455DC42";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_FK_DRV_JNT" -p "R_forearm_FK_DRV_JNT";
	rename -uid "BF5F3C02-427D-359E-7C23-3498E21E2E71";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "8FFA8BF7-4901-0A27-B225-5E94ABAC213B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -4 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_IK_DRV_JNT" -p "R_upperArm_IK_DRV_JNT";
	rename -uid "654C023F-4BCB-51AC-2409-BF9C91267A5F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".r" -type "double3" 0 1.379222199687406e-06 0 ;
	setAttr ".pa" -type "double3" 0 90 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_IK_DRV_JNT" -p "R_forearm_IK_DRV_JNT";
	rename -uid "21258885-4FD4-6B21-D7D1-4381B75E4F87";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode ikEffector -n "effector3" -p "R_forearm_IK_DRV_JNT";
	rename -uid "A2883459-4E57-3AD7-188C-0DB8BE210A8A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode joint -n "R_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "7D8712F3-41C0-650D-5502-F289402B6447";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_FK_DRV_JNT" -p "R_thigh_FK_DRV_JNT";
	rename -uid "98A99529-4EE3-BBFE-5BD8-F9BE294BABFB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_FK_DRV_JNT" -p "R_calf_FK_DRV_JNT";
	rename -uid "BAF9E80F-4079-6E0F-CDEA-C8BFAB3C0B85";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode joint -n "R_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "23F3F1D7-4029-BF08-E8BC-2DBCC62CCF32";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 9 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_IK_DRV_JNT" -p "R_thigh_IK_DRV_JNT";
	rename -uid "B6F9BD8B-4371-C62D-BD87-3780D1D52975";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_IK_DRV_JNT" -p "R_calf_IK_DRV_JNT";
	rename -uid "FC89CA72-4CC5-6796-0684-BEBC04ECAE9A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode ikEffector -n "effector4" -p "R_calf_IK_DRV_JNT";
	rename -uid "B1A49043-44A9-DF6E-6F89-35B6C3C6BAEF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode joint -n "C_chest_DRV_JNT" -p "MC_DEFORM";
	rename -uid "33C79A12-4A92-B7D6-4BB7-539A827F80D0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode joint -n "C_head_DRV_JNT" -p "C_chest_DRV_JNT";
	rename -uid "188F4321-4F39-22DF-D084-649B7FCB798C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "head.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode transform -n "MC_DELIVERY" -p "MC_RIG";
	rename -uid "CDAF2C79-4DE0-0548-A512-F282FD6E05C2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.delivery";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "C83D840A-47CF-C0D9-159D-62A555CED4E6";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_RESULT_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "E3B73B10-46AB-CCD1-CCC9-E4A82BDED508";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_RESULT_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "32855287-4A1F-1217-4D1E-B486793C1EF7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "52379975-4ED1-16CD-2F0F-92A88BD60464";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_RESULT_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "18EB17F8-408D-82B4-B3E2-758E6D86DFC0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_RESULT_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "E7753570-49C9-9FE4-A18A-2C9552D04020";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "R_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "ADE5EEA8-4F30-A5BA-567A-24A972AA020F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_RESULT_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "7BCD730D-429F-42FE-024A-2FA53A8105D3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_RESULT_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "ED3897AA-4304-624A-A5E6-5AAA4496AD75";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "B6BA12B8-4C3F-9D91-CA22-C09BE2DD2708";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_RESULT_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "37D8BA07-4E27-D675-7715-ACA5E508303F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_RESULT_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "13C15A1F-4A81-CF78-CCE7-368779499EB7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "CEF97BA9-4B54-D028-4768-12A8F240C7DB";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "2AF77F7C-4CB0-E4D9-F282-79ACC0414812";
createNode displayLayer -n "defaultLayer";
	rename -uid "EF1EA49B-4644-5AEC-1C9C-D3A4C9DCF691";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "8A59187A-40ED-EF7D-F45A-FA9BCA663784";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "EB8C520D-4590-6ED8-218A-25BDDE8DA07B";
	setAttr ".g" yes;
createNode multMatrix -n "head_drive_MMX";
	rename -uid "7AE85930-4A26-B22E-6E76-15A4B55B277B";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "head.drive";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"head.ctrl\"],[\"targets\",\"head.deform\"]]";
createNode blendMatrix -n "l_arm_blend_0_BLM";
	rename -uid "342DBF5E-4E15-457B-9A03-3C8756CFEF0D";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.blend.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.0|l_arm.ik_joint.0|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_0_CORRECT_CMP";
	rename -uid "AF0DFAD1-4E3B-65DD-C1AF-859623C7AACD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_CORRECT_MMX";
	rename -uid "51A9DAAF-4900-9B10-5BF4-18B1ABE77D08";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_LOCAL_MMX";
	rename -uid "5A5A7FE1-45B8-D192-5EEA-DFBED62E97BF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode blendMatrix -n "l_arm_blend_1_BLM";
	rename -uid "697F2ECB-40BD-B9AE-76F9-51AD92B7B6A1";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.blend.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.1|l_arm.ik_joint.1|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_1_CORRECT_CMP";
	rename -uid "A61A5F16-447B-DEDA-ED4F-1EB1C07B430F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_CORRECT_MMX";
	rename -uid "B66AEAE1-44A4-EB18-C021-23B87A223273";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_LOCAL_MMX";
	rename -uid "5D6B9444-407C-9A5D-35DD-14AD93519215";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode blendMatrix -n "l_arm_blend_2_BLM";
	rename -uid "DE7A4990-43D4-6952-B8A0-A3AC14436020";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.blend.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.2|l_arm.ik_joint.2|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_2_CORRECT_CMP";
	rename -uid "2AC78366-4A32-E4D9-5AA4-ED944CBE90D7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_CORRECT_MMX";
	rename -uid "9EADF60A-495C-E5C1-9423-7DA222701924";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_LOCAL_MMX";
	rename -uid "2FF165CC-4D49-1920-D2EC-C39CBC65160E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_drive_0_MMX";
	rename -uid "9E98FA77-469B-CAD3-21B4-8BA09612A15F";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.drive.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.0\"],[\"targets\",\"l_arm.fk_joint.0\"]]";
createNode multMatrix -n "l_arm_drive_1_MMX";
	rename -uid "B7F9D9B7-4F7F-93F5-6357-23BD052507DE";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.drive.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.1\"],[\"targets\",\"l_arm.fk_joint.1\"]]";
createNode multMatrix -n "l_arm_drive_2_MMX";
	rename -uid "E60FB7F5-424A-18DE-725A-999F1424DCD3";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.drive.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.2\"],[\"targets\",\"l_arm.fk_joint.2\"]]";
createNode ikRPsolver -n "ikRPsolver";
	rename -uid "0DE14556-4A70-FCC2-3F6D-67AEA93106CD";
createNode unitConversion -n "unitConversion1";
	rename -uid "478086EE-4F43-BD32-8CFC-EEB035A6DF0A";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_arm_space_CHOICE";
	rename -uid "AD969A96-4EA0-333E-A45F-0DB16CC2A640";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.space";
	setAttr ".mayacraftRigBehaviorType" -type "string" "space_switch";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_arm_space_LOCAL_MMX";
	rename -uid "D1E0900C-4D02-7C43-67C5-E7B4C1652BEC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE0_MMX";
	rename -uid "640FC23D-48C0-C56A-80D8-9B9C957F3693";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE1_MMX";
	rename -uid "87334DB5-4B0B-0857-069A-4F9BB838852D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode blendMatrix -n "l_leg_blend_0_BLM";
	rename -uid "8C9B113D-49BD-3FEC-50F6-C192408E2F5B";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.blend.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.0|l_leg.ik_joint.0|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_0_CORRECT_CMP";
	rename -uid "4CAF7193-4C8A-A349-EB20-9ABBB34665EC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_CORRECT_MMX";
	rename -uid "202B75EF-4489-6607-627E-DDAA3EDD181D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_LOCAL_MMX";
	rename -uid "D74AA1C9-41BE-DA1E-3861-528D493BCE76";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode blendMatrix -n "l_leg_blend_1_BLM";
	rename -uid "35597C93-4DD0-6E68-3FA9-2397087AB040";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.blend.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.1|l_leg.ik_joint.1|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_1_CORRECT_CMP";
	rename -uid "869B1415-4AF6-9104-B477-838C00CC3645";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_CORRECT_MMX";
	rename -uid "03D95A00-4DCA-C592-5706-1D952B80180B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_LOCAL_MMX";
	rename -uid "70AF9E90-47EC-F014-323C-52B2B64D572F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode blendMatrix -n "l_leg_blend_2_BLM";
	rename -uid "BF261072-4272-AE4A-F495-B984C45733A9";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.blend.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.2|l_leg.ik_joint.2|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_2_CORRECT_CMP";
	rename -uid "E2F1B91D-4BF6-6FBC-220B-7EBC65265990";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_CORRECT_MMX";
	rename -uid "8B90E0A1-4890-B998-0DBA-3FBBFDABC616";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_LOCAL_MMX";
	rename -uid "D38E28D3-4A92-4BF3-7CBA-4599AF7E8CA4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_drive_0_MMX";
	rename -uid "77E459EE-44B5-24B7-8FB3-19A9E25EBA5E";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.drive.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.0\"],[\"targets\",\"l_leg.fk_joint.0\"]]";
createNode multMatrix -n "l_leg_drive_1_MMX";
	rename -uid "A4C96939-4A15-716F-C565-C396DF8F9702";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.drive.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.1\"],[\"targets\",\"l_leg.fk_joint.1\"]]";
createNode multMatrix -n "l_leg_drive_2_MMX";
	rename -uid "28C48283-423E-6430-64FC-408375BAC052";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.drive.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.2\"],[\"targets\",\"l_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion2";
	rename -uid "EFA3B201-4F47-3DC5-5447-75BC94D6FCB7";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_leg_space_CHOICE";
	rename -uid "B465657D-4F2C-F633-2AEC-F8AEB6802FE7";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.space";
	setAttr ".mayacraftRigBehaviorType" -type "string" "space_switch";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_leg_space_LOCAL_MMX";
	rename -uid "01E94455-4B0C-6D96-6C4E-69A02B2C1563";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE0_MMX";
	rename -uid "69AF47F7-406C-174B-27D5-E0BDF800FAC1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE1_MMX";
	rename -uid "6FE4CD4A-4927-4A88-8F6E-8EA267F2710E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode blendMatrix -n "r_arm_blend_0_BLM";
	rename -uid "92907DED-4281-3683-919E-5AA468F8249C";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.blend.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.0|r_arm.ik_joint.0|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_0_CORRECT_CMP";
	rename -uid "E0B91966-42F4-58A0-9F83-9FB559D6BA25";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_CORRECT_MMX";
	rename -uid "DBB106E1-414C-2ECA-6C7E-F1B9B693D777";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_LOCAL_MMX";
	rename -uid "BD7A81C4-4A63-7D74-D23D-9998F8C6ACF7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode blendMatrix -n "r_arm_blend_1_BLM";
	rename -uid "37E0FE43-4030-5BE3-1D5D-8482FCB82966";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.blend.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.1|r_arm.ik_joint.1|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_1_CORRECT_CMP";
	rename -uid "8B340628-4CDA-C406-43E1-82905E9C7E0F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_CORRECT_MMX";
	rename -uid "6EB124E8-43D7-8BCF-F431-35B054B8A5D7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_LOCAL_MMX";
	rename -uid "19CF93C8-4CBF-9FDF-81C6-93B194452EE5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode blendMatrix -n "r_arm_blend_2_BLM";
	rename -uid "B8AB39AF-4135-5E8C-483F-C3AA26602BAA";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.blend.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.2|r_arm.ik_joint.2|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_2_CORRECT_CMP";
	rename -uid "E3787A00-40AD-3E62-140A-459505C22FAA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_CORRECT_MMX";
	rename -uid "F74CCA9E-4D99-3390-6809-65AEBC725ED6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_LOCAL_MMX";
	rename -uid "287C3373-478B-6CD6-4CA4-53BF53F6A2DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_drive_0_MMX";
	rename -uid "905E6FB8-4E95-FA01-88A5-55A126E8F3D2";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.drive.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.0\"],[\"targets\",\"r_arm.fk_joint.0\"]]";
createNode multMatrix -n "r_arm_drive_1_MMX";
	rename -uid "53D37FC7-4991-4283-DA74-F3AD55FCD806";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.drive.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.1\"],[\"targets\",\"r_arm.fk_joint.1\"]]";
createNode multMatrix -n "r_arm_drive_2_MMX";
	rename -uid "07157FDA-4CF7-3D2B-B6E9-85A1E77844F4";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.drive.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.2\"],[\"targets\",\"r_arm.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion3";
	rename -uid "C6C86E66-48CE-F60C-47B9-03A45BC5DCDE";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_arm_space_CHOICE";
	rename -uid "786511BD-48CD-07D0-6D20-D8B583A529ED";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.space";
	setAttr ".mayacraftRigBehaviorType" -type "string" "space_switch";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_arm_space_LOCAL_MMX";
	rename -uid "61740F29-4234-7401-3AB5-C49613CEE2FA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE0_MMX";
	rename -uid "A32A6F3B-4E6D-BD7A-8EC8-5EAE9491FBB0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE1_MMX";
	rename -uid "EFE50665-46F2-B90B-6358-C1B2A2FDBD4D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode blendMatrix -n "r_leg_blend_0_BLM";
	rename -uid "BB077C00-4448-FE5B-3A13-FA8EB0C280FE";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.blend.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.0|r_leg.ik_joint.0|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_0_CORRECT_CMP";
	rename -uid "746B1CEC-45DB-6252-51F2-6CACFCFF1EA8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_CORRECT_MMX";
	rename -uid "D2971783-4CDE-496C-CC24-C6AB89E22CB3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_LOCAL_MMX";
	rename -uid "32D65D86-4EAD-CD57-D22B-D991533C025C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode blendMatrix -n "r_leg_blend_1_BLM";
	rename -uid "4807F29A-4E81-C82F-3114-D29F37214386";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.blend.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.1|r_leg.ik_joint.1|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_1_CORRECT_CMP";
	rename -uid "B7A954A7-4532-A766-43BA-F6A2B3D45B47";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_CORRECT_MMX";
	rename -uid "C2644121-4E9B-8A4C-7D15-A89159201C79";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_LOCAL_MMX";
	rename -uid "566CFE11-44FB-0D38-2121-8BBE096DA9E4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode blendMatrix -n "r_leg_blend_2_BLM";
	rename -uid "3C526431-4DD6-E5A9-ED4E-D59876A890C7";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.blend.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_blend";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.2|r_leg.ik_joint.2|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_2_CORRECT_CMP";
	rename -uid "6E8ED955-4010-A3B4-693C-DB9BA1D77237";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_CORRECT_MMX";
	rename -uid "5A3DD1DD-41F9-1AD6-94D7-58877EB993FA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_LOCAL_MMX";
	rename -uid "1AFBD382-40E9-69A1-A1D0-3D95FC30D9BA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_drive_0_MMX";
	rename -uid "DDBAB319-4126-1682-5FBB-3590F692887C";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.drive.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.0\"],[\"targets\",\"r_leg.fk_joint.0\"]]";
createNode multMatrix -n "r_leg_drive_1_MMX";
	rename -uid "F0E28A08-48E1-ADD7-F51E-54A7978F0D62";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.drive.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.1\"],[\"targets\",\"r_leg.fk_joint.1\"]]";
createNode multMatrix -n "r_leg_drive_2_MMX";
	rename -uid "3A648068-4C1D-C6AF-38EC-40AC91A6D0A2";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.drive.2";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.2\"],[\"targets\",\"r_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion4";
	rename -uid "B4D5993E-49B2-F05E-6AC6-DF97D4011ECB";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_leg_space_CHOICE";
	rename -uid "1A722A8B-4AB4-6B36-8A0B-E5B68DE598DA";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.space";
	setAttr ".mayacraftRigBehaviorType" -type "string" "space_switch";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_leg_space_LOCAL_MMX";
	rename -uid "040109F3-497C-A435-23C8-378FDDF15A34";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE0_MMX";
	rename -uid "15F8028C-48BA-E3B9-5B69-50A3E9D211AE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE1_MMX";
	rename -uid "2F70D9F0-4D39-F5A0-95BC-A896CBB54141";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "spine_drive_MMX";
	rename -uid "21F5E0CF-4FC5-42B4-58BE-1B9E19A977A8";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max 
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "spine.drive";
	setAttr ".mayacraftRigBehaviorType" -type "string" "matrix_drive";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"spine.ctrl\"],[\"targets\",\"spine.deform\"]]";
createNode animCurveTA -n "L_upperArm_FK_CTRL_rotateZ";
	rename -uid "29133932-4CF3-CAE1-9308-C1ADBA03DB73";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 18 24 -10;
createNode animCurveTA -n "L_forearm_FK_CTRL_rotateZ";
	rename -uid "AA6AA52A-452C-4D5F-DD16-3B936A02BF48";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 -32 24 24.000000000000004;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "B08139D8-4B11-E18D-7B84-F1981439DC1C";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "5575D753-4A52-8CE0-AD4D-9AB4A3E9E88D";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 200 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 12;
	setAttr ".unw" 12;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
	setAttr ".rtfm" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :standardSurface1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -h true -sn "dss" -ln "defaultSurfaceShader" -dt "string";
	setAttr ".dss" -type "string" "standardSurface1";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultColorMgtGlobals;
	setAttr ".cfe" yes;
	setAttr ".cfp" -type "string" "<MAYA_RESOURCES>/OCIO-configs/Maya2022-default/config.ocio";
	setAttr ".vtn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".vn" -type "string" "ACES 1.0 SDR-video";
	setAttr ".dn" -type "string" "sRGB";
	setAttr ".wsn" -type "string" "ACEScg";
	setAttr ".otn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".potn" -type "string" "ACES 1.0 SDR-video (sRGB)";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :ikSystem;
	setAttr -s 4 ".sol";
connectAttr "root_JNT.s" "pelvis_JNT.is";
connectAttr "pelvis_JNT.s" "spine_JNT.is";
connectAttr "spine_JNT.s" "chest_JNT.is";
connectAttr "chest_JNT.s" "neck_JNT.is";
connectAttr "neck_JNT.s" "head_JNT.is";
connectAttr "chest_JNT.s" "L_upperArm_JNT.is";
connectAttr "L_upperArm_JNT.s" "L_forearm_JNT.is";
connectAttr "L_forearm_JNT.s" "L_hand_JNT.is";
connectAttr "chest_JNT.s" "R_upperArm_JNT.is";
connectAttr "R_upperArm_JNT.s" "R_forearm_JNT.is";
connectAttr "R_forearm_JNT.s" "R_hand_JNT.is";
connectAttr "pelvis_JNT.s" "L_thigh_JNT.is";
connectAttr "L_thigh_JNT.s" "L_calf_JNT.is";
connectAttr "L_calf_JNT.s" "L_foot_JNT.is";
connectAttr "pelvis_JNT.s" "R_thigh_JNT.is";
connectAttr "R_thigh_JNT.s" "R_calf_JNT.is";
connectAttr "R_calf_JNT.s" "R_foot_JNT.is";
connectAttr "L_upperArm_FK_CTRL_rotateZ.o" "L_upperArm_FK_CTRL.rz";
connectAttr "L_forearm_FK_CTRL_rotateZ.o" "L_forearm_FK_CTRL.rz";
connectAttr "l_arm_space_LOCAL_MMX.o" "L_arm_IK_SPACE.opm";
connectAttr "L_upperArm_IK_DRV_JNT.msg" "l_arm_rp_ik_IKH.hsj";
connectAttr "effector1.hp" "l_arm_rp_ik_IKH.hee";
connectAttr "ikRPsolver.msg" "l_arm_rp_ik_IKH.hsv";
connectAttr "l_arm_rp_ik_PVC.ctx" "l_arm_rp_ik_IKH.pvx";
connectAttr "l_arm_rp_ik_PVC.cty" "l_arm_rp_ik_IKH.pvy";
connectAttr "l_arm_rp_ik_PVC.ctz" "l_arm_rp_ik_IKH.pvz";
connectAttr "unitConversion1.o" "l_arm_rp_ik_IKH.twi";
connectAttr "l_arm_rp_ik_IKH.pim" "l_arm_rp_ik_PVC.cpim";
connectAttr "L_upperArm_IK_DRV_JNT.pm" "l_arm_rp_ik_PVC.ps";
connectAttr "L_upperArm_IK_DRV_JNT.t" "l_arm_rp_ik_PVC.crp";
connectAttr "L_arm_POLE_CTRL.t" "l_arm_rp_ik_PVC.tg[0].tt";
connectAttr "L_arm_POLE_CTRL.rp" "l_arm_rp_ik_PVC.tg[0].trp";
connectAttr "L_arm_POLE_CTRL.rpt" "l_arm_rp_ik_PVC.tg[0].trt";
connectAttr "L_arm_POLE_CTRL.pm" "l_arm_rp_ik_PVC.tg[0].tpm";
connectAttr "l_arm_rp_ik_PVC.w0" "l_arm_rp_ik_PVC.tg[0].tw";
connectAttr "l_leg_space_LOCAL_MMX.o" "L_leg_IK_SPACE.opm";
connectAttr "L_thigh_IK_DRV_JNT.msg" "l_leg_rp_ik_IKH.hsj";
connectAttr "effector2.hp" "l_leg_rp_ik_IKH.hee";
connectAttr "ikRPsolver.msg" "l_leg_rp_ik_IKH.hsv";
connectAttr "l_leg_rp_ik_PVC.ctx" "l_leg_rp_ik_IKH.pvx";
connectAttr "l_leg_rp_ik_PVC.cty" "l_leg_rp_ik_IKH.pvy";
connectAttr "l_leg_rp_ik_PVC.ctz" "l_leg_rp_ik_IKH.pvz";
connectAttr "unitConversion2.o" "l_leg_rp_ik_IKH.twi";
connectAttr "l_leg_rp_ik_IKH.pim" "l_leg_rp_ik_PVC.cpim";
connectAttr "L_thigh_IK_DRV_JNT.pm" "l_leg_rp_ik_PVC.ps";
connectAttr "L_thigh_IK_DRV_JNT.t" "l_leg_rp_ik_PVC.crp";
connectAttr "L_leg_POLE_CTRL.t" "l_leg_rp_ik_PVC.tg[0].tt";
connectAttr "L_leg_POLE_CTRL.rp" "l_leg_rp_ik_PVC.tg[0].trp";
connectAttr "L_leg_POLE_CTRL.rpt" "l_leg_rp_ik_PVC.tg[0].trt";
connectAttr "L_leg_POLE_CTRL.pm" "l_leg_rp_ik_PVC.tg[0].tpm";
connectAttr "l_leg_rp_ik_PVC.w0" "l_leg_rp_ik_PVC.tg[0].tw";
connectAttr "r_arm_space_LOCAL_MMX.o" "R_arm_IK_SPACE.opm";
connectAttr "R_upperArm_IK_DRV_JNT.msg" "r_arm_rp_ik_IKH.hsj";
connectAttr "effector3.hp" "r_arm_rp_ik_IKH.hee";
connectAttr "ikRPsolver.msg" "r_arm_rp_ik_IKH.hsv";
connectAttr "r_arm_rp_ik_PVC.ctx" "r_arm_rp_ik_IKH.pvx";
connectAttr "r_arm_rp_ik_PVC.cty" "r_arm_rp_ik_IKH.pvy";
connectAttr "r_arm_rp_ik_PVC.ctz" "r_arm_rp_ik_IKH.pvz";
connectAttr "unitConversion3.o" "r_arm_rp_ik_IKH.twi";
connectAttr "r_arm_rp_ik_IKH.pim" "r_arm_rp_ik_PVC.cpim";
connectAttr "R_upperArm_IK_DRV_JNT.pm" "r_arm_rp_ik_PVC.ps";
connectAttr "R_upperArm_IK_DRV_JNT.t" "r_arm_rp_ik_PVC.crp";
connectAttr "R_arm_POLE_CTRL.t" "r_arm_rp_ik_PVC.tg[0].tt";
connectAttr "R_arm_POLE_CTRL.rp" "r_arm_rp_ik_PVC.tg[0].trp";
connectAttr "R_arm_POLE_CTRL.rpt" "r_arm_rp_ik_PVC.tg[0].trt";
connectAttr "R_arm_POLE_CTRL.pm" "r_arm_rp_ik_PVC.tg[0].tpm";
connectAttr "r_arm_rp_ik_PVC.w0" "r_arm_rp_ik_PVC.tg[0].tw";
connectAttr "r_leg_space_LOCAL_MMX.o" "R_leg_IK_SPACE.opm";
connectAttr "R_thigh_IK_DRV_JNT.msg" "r_leg_rp_ik_IKH.hsj";
connectAttr "effector4.hp" "r_leg_rp_ik_IKH.hee";
connectAttr "ikRPsolver.msg" "r_leg_rp_ik_IKH.hsv";
connectAttr "r_leg_rp_ik_PVC.ctx" "r_leg_rp_ik_IKH.pvx";
connectAttr "r_leg_rp_ik_PVC.cty" "r_leg_rp_ik_IKH.pvy";
connectAttr "r_leg_rp_ik_PVC.ctz" "r_leg_rp_ik_IKH.pvz";
connectAttr "unitConversion4.o" "r_leg_rp_ik_IKH.twi";
connectAttr "r_leg_rp_ik_IKH.pim" "r_leg_rp_ik_PVC.cpim";
connectAttr "R_thigh_IK_DRV_JNT.pm" "r_leg_rp_ik_PVC.ps";
connectAttr "R_thigh_IK_DRV_JNT.t" "r_leg_rp_ik_PVC.crp";
connectAttr "R_leg_POLE_CTRL.t" "r_leg_rp_ik_PVC.tg[0].tt";
connectAttr "R_leg_POLE_CTRL.rp" "r_leg_rp_ik_PVC.tg[0].trp";
connectAttr "R_leg_POLE_CTRL.rpt" "r_leg_rp_ik_PVC.tg[0].trt";
connectAttr "R_leg_POLE_CTRL.pm" "r_leg_rp_ik_PVC.tg[0].tpm";
connectAttr "r_leg_rp_ik_PVC.w0" "r_leg_rp_ik_PVC.tg[0].tw";
connectAttr "l_arm_drive_0_MMX.o" "L_upperArm_FK_DRV_JNT.opm";
connectAttr "L_upperArm_FK_DRV_JNT.s" "L_forearm_FK_DRV_JNT.is";
connectAttr "l_arm_drive_1_MMX.o" "L_forearm_FK_DRV_JNT.opm";
connectAttr "L_forearm_FK_DRV_JNT.s" "L_hand_FK_DRV_JNT.is";
connectAttr "l_arm_drive_2_MMX.o" "L_hand_FK_DRV_JNT.opm";
connectAttr "L_upperArm_IK_DRV_JNT.s" "L_forearm_IK_DRV_JNT.is";
connectAttr "L_forearm_IK_DRV_JNT.s" "L_hand_IK_DRV_JNT.is";
connectAttr "L_hand_IK_DRV_JNT.tx" "effector1.tx";
connectAttr "L_hand_IK_DRV_JNT.ty" "effector1.ty";
connectAttr "L_hand_IK_DRV_JNT.tz" "effector1.tz";
connectAttr "L_hand_IK_DRV_JNT.opm" "effector1.opm";
connectAttr "l_leg_drive_0_MMX.o" "L_thigh_FK_DRV_JNT.opm";
connectAttr "L_thigh_FK_DRV_JNT.s" "L_calf_FK_DRV_JNT.is";
connectAttr "l_leg_drive_1_MMX.o" "L_calf_FK_DRV_JNT.opm";
connectAttr "L_calf_FK_DRV_JNT.s" "L_foot_FK_DRV_JNT.is";
connectAttr "l_leg_drive_2_MMX.o" "L_foot_FK_DRV_JNT.opm";
connectAttr "L_thigh_IK_DRV_JNT.s" "L_calf_IK_DRV_JNT.is";
connectAttr "L_calf_IK_DRV_JNT.s" "L_foot_IK_DRV_JNT.is";
connectAttr "L_foot_IK_DRV_JNT.tx" "effector2.tx";
connectAttr "L_foot_IK_DRV_JNT.ty" "effector2.ty";
connectAttr "L_foot_IK_DRV_JNT.tz" "effector2.tz";
connectAttr "L_foot_IK_DRV_JNT.opm" "effector2.opm";
connectAttr "r_arm_drive_0_MMX.o" "R_upperArm_FK_DRV_JNT.opm";
connectAttr "R_upperArm_FK_DRV_JNT.s" "R_forearm_FK_DRV_JNT.is";
connectAttr "r_arm_drive_1_MMX.o" "R_forearm_FK_DRV_JNT.opm";
connectAttr "R_forearm_FK_DRV_JNT.s" "R_hand_FK_DRV_JNT.is";
connectAttr "r_arm_drive_2_MMX.o" "R_hand_FK_DRV_JNT.opm";
connectAttr "R_upperArm_IK_DRV_JNT.s" "R_forearm_IK_DRV_JNT.is";
connectAttr "R_forearm_IK_DRV_JNT.s" "R_hand_IK_DRV_JNT.is";
connectAttr "R_hand_IK_DRV_JNT.tx" "effector3.tx";
connectAttr "R_hand_IK_DRV_JNT.ty" "effector3.ty";
connectAttr "R_hand_IK_DRV_JNT.tz" "effector3.tz";
connectAttr "R_hand_IK_DRV_JNT.opm" "effector3.opm";
connectAttr "r_leg_drive_0_MMX.o" "R_thigh_FK_DRV_JNT.opm";
connectAttr "R_thigh_FK_DRV_JNT.s" "R_calf_FK_DRV_JNT.is";
connectAttr "r_leg_drive_1_MMX.o" "R_calf_FK_DRV_JNT.opm";
connectAttr "R_calf_FK_DRV_JNT.s" "R_foot_FK_DRV_JNT.is";
connectAttr "r_leg_drive_2_MMX.o" "R_foot_FK_DRV_JNT.opm";
connectAttr "R_thigh_IK_DRV_JNT.s" "R_calf_IK_DRV_JNT.is";
connectAttr "R_calf_IK_DRV_JNT.s" "R_foot_IK_DRV_JNT.is";
connectAttr "R_foot_IK_DRV_JNT.tx" "effector4.tx";
connectAttr "R_foot_IK_DRV_JNT.ty" "effector4.ty";
connectAttr "R_foot_IK_DRV_JNT.tz" "effector4.tz";
connectAttr "R_foot_IK_DRV_JNT.opm" "effector4.opm";
connectAttr "spine_drive_MMX.o" "C_chest_DRV_JNT.opm";
connectAttr "C_chest_DRV_JNT.s" "C_head_DRV_JNT.is";
connectAttr "head_drive_MMX.o" "C_head_DRV_JNT.opm";
connectAttr "l_arm_blend_0_LOCAL_MMX.o" "L_upperArm_RESULT_JNT.opm";
connectAttr "L_upperArm_RESULT_JNT.s" "L_forearm_RESULT_JNT.is";
connectAttr "l_arm_blend_1_LOCAL_MMX.o" "L_forearm_RESULT_JNT.opm";
connectAttr "L_forearm_RESULT_JNT.s" "L_hand_RESULT_JNT.is";
connectAttr "l_arm_blend_2_LOCAL_MMX.o" "L_hand_RESULT_JNT.opm";
connectAttr "l_leg_blend_0_LOCAL_MMX.o" "L_thigh_RESULT_JNT.opm";
connectAttr "L_thigh_RESULT_JNT.s" "L_calf_RESULT_JNT.is";
connectAttr "l_leg_blend_1_LOCAL_MMX.o" "L_calf_RESULT_JNT.opm";
connectAttr "L_calf_RESULT_JNT.s" "L_foot_RESULT_JNT.is";
connectAttr "l_leg_blend_2_LOCAL_MMX.o" "L_foot_RESULT_JNT.opm";
connectAttr "r_arm_blend_0_LOCAL_MMX.o" "R_upperArm_RESULT_JNT.opm";
connectAttr "R_upperArm_RESULT_JNT.s" "R_forearm_RESULT_JNT.is";
connectAttr "r_arm_blend_1_LOCAL_MMX.o" "R_forearm_RESULT_JNT.opm";
connectAttr "R_forearm_RESULT_JNT.s" "R_hand_RESULT_JNT.is";
connectAttr "r_arm_blend_2_LOCAL_MMX.o" "R_hand_RESULT_JNT.opm";
connectAttr "r_leg_blend_0_LOCAL_MMX.o" "R_thigh_RESULT_JNT.opm";
connectAttr "R_thigh_RESULT_JNT.s" "R_calf_RESULT_JNT.is";
connectAttr "r_leg_blend_1_LOCAL_MMX.o" "R_calf_RESULT_JNT.opm";
connectAttr "R_calf_RESULT_JNT.s" "R_foot_RESULT_JNT.is";
connectAttr "r_leg_blend_2_LOCAL_MMX.o" "R_foot_RESULT_JNT.opm";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "C_head_FK_CTRL.wm" "head_drive_MMX.i[0]";
connectAttr "C_chest_DRV_JNT.wim" "head_drive_MMX.i[1]";
connectAttr "L_upperArm_FK_DRV_JNT.wm" "l_arm_blend_0_BLM.imat";
connectAttr "l_arm_blend_0_CORRECT_MMX.o" "l_arm_blend_0_BLM.tgt[0].tmat";
connectAttr "L_hand_IK_CTRL.ikFk" "l_arm_blend_0_BLM.tgt[0].wgt";
connectAttr "L_hand_IK_CTRL.matchCorr0X" "l_arm_blend_0_CORRECT_CMP.irx";
connectAttr "L_hand_IK_CTRL.matchCorr0Y" "l_arm_blend_0_CORRECT_CMP.iry";
connectAttr "L_hand_IK_CTRL.matchCorr0Z" "l_arm_blend_0_CORRECT_CMP.irz";
connectAttr "l_arm_blend_0_CORRECT_CMP.omat" "l_arm_blend_0_CORRECT_MMX.i[0]";
connectAttr "L_upperArm_IK_DRV_JNT.wm" "l_arm_blend_0_CORRECT_MMX.i[1]";
connectAttr "l_arm_blend_0_BLM.omat" "l_arm_blend_0_LOCAL_MMX.i[0]";
connectAttr "MC_DELIVERY.wim" "l_arm_blend_0_LOCAL_MMX.i[1]";
connectAttr "L_forearm_FK_DRV_JNT.wm" "l_arm_blend_1_BLM.imat";
connectAttr "l_arm_blend_1_CORRECT_MMX.o" "l_arm_blend_1_BLM.tgt[0].tmat";
connectAttr "L_hand_IK_CTRL.ikFk" "l_arm_blend_1_BLM.tgt[0].wgt";
connectAttr "L_hand_IK_CTRL.matchCorr1X" "l_arm_blend_1_CORRECT_CMP.irx";
connectAttr "L_hand_IK_CTRL.matchCorr1Y" "l_arm_blend_1_CORRECT_CMP.iry";
connectAttr "L_hand_IK_CTRL.matchCorr1Z" "l_arm_blend_1_CORRECT_CMP.irz";
connectAttr "l_arm_blend_1_CORRECT_CMP.omat" "l_arm_blend_1_CORRECT_MMX.i[0]";
connectAttr "L_forearm_IK_DRV_JNT.wm" "l_arm_blend_1_CORRECT_MMX.i[1]";
connectAttr "l_arm_blend_1_BLM.omat" "l_arm_blend_1_LOCAL_MMX.i[0]";
connectAttr "L_upperArm_RESULT_JNT.wim" "l_arm_blend_1_LOCAL_MMX.i[1]";
connectAttr "L_hand_FK_DRV_JNT.wm" "l_arm_blend_2_BLM.imat";
connectAttr "l_arm_blend_2_CORRECT_MMX.o" "l_arm_blend_2_BLM.tgt[0].tmat";
connectAttr "L_hand_IK_CTRL.ikFk" "l_arm_blend_2_BLM.tgt[0].wgt";
connectAttr "L_hand_IK_CTRL.matchCorr2X" "l_arm_blend_2_CORRECT_CMP.irx";
connectAttr "L_hand_IK_CTRL.matchCorr2Y" "l_arm_blend_2_CORRECT_CMP.iry";
connectAttr "L_hand_IK_CTRL.matchCorr2Z" "l_arm_blend_2_CORRECT_CMP.irz";
connectAttr "l_arm_blend_2_CORRECT_CMP.omat" "l_arm_blend_2_CORRECT_MMX.i[0]";
connectAttr "L_hand_IK_DRV_JNT.wm" "l_arm_blend_2_CORRECT_MMX.i[1]";
connectAttr "l_arm_blend_2_BLM.omat" "l_arm_blend_2_LOCAL_MMX.i[0]";
connectAttr "L_forearm_RESULT_JNT.wim" "l_arm_blend_2_LOCAL_MMX.i[1]";
connectAttr "L_upperArm_FK_CTRL.wm" "l_arm_drive_0_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "l_arm_drive_0_MMX.i[1]";
connectAttr "L_forearm_FK_CTRL.wm" "l_arm_drive_1_MMX.i[0]";
connectAttr "L_upperArm_FK_DRV_JNT.wim" "l_arm_drive_1_MMX.i[1]";
connectAttr "L_hand_FK_CTRL.wm" "l_arm_drive_2_MMX.i[0]";
connectAttr "L_forearm_FK_DRV_JNT.wim" "l_arm_drive_2_MMX.i[1]";
connectAttr "L_hand_IK_CTRL.twist" "unitConversion1.i";
connectAttr "l_arm_space_SPACE0_MMX.o" "l_arm_space_CHOICE.i[0]";
connectAttr "l_arm_space_SPACE1_MMX.o" "l_arm_space_CHOICE.i[1]";
connectAttr "L_hand_IK_CTRL.space" "l_arm_space_CHOICE.s";
connectAttr "l_arm_space_CHOICE.o" "l_arm_space_LOCAL_MMX.i[0]";
connectAttr "L_arm_MOD.wim" "l_arm_space_LOCAL_MMX.i[1]";
connectAttr "MC_CONTROLS.wm" "l_arm_space_SPACE0_MMX.i[1]";
connectAttr "C_chest_FK_CTRL.wm" "l_arm_space_SPACE1_MMX.i[1]";
connectAttr "L_thigh_FK_DRV_JNT.wm" "l_leg_blend_0_BLM.imat";
connectAttr "l_leg_blend_0_CORRECT_MMX.o" "l_leg_blend_0_BLM.tgt[0].tmat";
connectAttr "L_foot_IK_CTRL.ikFk" "l_leg_blend_0_BLM.tgt[0].wgt";
connectAttr "L_foot_IK_CTRL.matchCorr0X" "l_leg_blend_0_CORRECT_CMP.irx";
connectAttr "L_foot_IK_CTRL.matchCorr0Y" "l_leg_blend_0_CORRECT_CMP.iry";
connectAttr "L_foot_IK_CTRL.matchCorr0Z" "l_leg_blend_0_CORRECT_CMP.irz";
connectAttr "l_leg_blend_0_CORRECT_CMP.omat" "l_leg_blend_0_CORRECT_MMX.i[0]";
connectAttr "L_thigh_IK_DRV_JNT.wm" "l_leg_blend_0_CORRECT_MMX.i[1]";
connectAttr "l_leg_blend_0_BLM.omat" "l_leg_blend_0_LOCAL_MMX.i[0]";
connectAttr "MC_DELIVERY.wim" "l_leg_blend_0_LOCAL_MMX.i[1]";
connectAttr "L_calf_FK_DRV_JNT.wm" "l_leg_blend_1_BLM.imat";
connectAttr "l_leg_blend_1_CORRECT_MMX.o" "l_leg_blend_1_BLM.tgt[0].tmat";
connectAttr "L_foot_IK_CTRL.ikFk" "l_leg_blend_1_BLM.tgt[0].wgt";
connectAttr "L_foot_IK_CTRL.matchCorr1X" "l_leg_blend_1_CORRECT_CMP.irx";
connectAttr "L_foot_IK_CTRL.matchCorr1Y" "l_leg_blend_1_CORRECT_CMP.iry";
connectAttr "L_foot_IK_CTRL.matchCorr1Z" "l_leg_blend_1_CORRECT_CMP.irz";
connectAttr "l_leg_blend_1_CORRECT_CMP.omat" "l_leg_blend_1_CORRECT_MMX.i[0]";
connectAttr "L_calf_IK_DRV_JNT.wm" "l_leg_blend_1_CORRECT_MMX.i[1]";
connectAttr "l_leg_blend_1_BLM.omat" "l_leg_blend_1_LOCAL_MMX.i[0]";
connectAttr "L_thigh_RESULT_JNT.wim" "l_leg_blend_1_LOCAL_MMX.i[1]";
connectAttr "L_foot_FK_DRV_JNT.wm" "l_leg_blend_2_BLM.imat";
connectAttr "l_leg_blend_2_CORRECT_MMX.o" "l_leg_blend_2_BLM.tgt[0].tmat";
connectAttr "L_foot_IK_CTRL.ikFk" "l_leg_blend_2_BLM.tgt[0].wgt";
connectAttr "L_foot_IK_CTRL.matchCorr2X" "l_leg_blend_2_CORRECT_CMP.irx";
connectAttr "L_foot_IK_CTRL.matchCorr2Y" "l_leg_blend_2_CORRECT_CMP.iry";
connectAttr "L_foot_IK_CTRL.matchCorr2Z" "l_leg_blend_2_CORRECT_CMP.irz";
connectAttr "l_leg_blend_2_CORRECT_CMP.omat" "l_leg_blend_2_CORRECT_MMX.i[0]";
connectAttr "L_foot_IK_DRV_JNT.wm" "l_leg_blend_2_CORRECT_MMX.i[1]";
connectAttr "l_leg_blend_2_BLM.omat" "l_leg_blend_2_LOCAL_MMX.i[0]";
connectAttr "L_calf_RESULT_JNT.wim" "l_leg_blend_2_LOCAL_MMX.i[1]";
connectAttr "L_thigh_FK_CTRL.wm" "l_leg_drive_0_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "l_leg_drive_0_MMX.i[1]";
connectAttr "L_calf_FK_CTRL.wm" "l_leg_drive_1_MMX.i[0]";
connectAttr "L_thigh_FK_DRV_JNT.wim" "l_leg_drive_1_MMX.i[1]";
connectAttr "L_foot_FK_CTRL.wm" "l_leg_drive_2_MMX.i[0]";
connectAttr "L_calf_FK_DRV_JNT.wim" "l_leg_drive_2_MMX.i[1]";
connectAttr "L_foot_IK_CTRL.twist" "unitConversion2.i";
connectAttr "l_leg_space_SPACE0_MMX.o" "l_leg_space_CHOICE.i[0]";
connectAttr "l_leg_space_SPACE1_MMX.o" "l_leg_space_CHOICE.i[1]";
connectAttr "L_foot_IK_CTRL.space" "l_leg_space_CHOICE.s";
connectAttr "l_leg_space_CHOICE.o" "l_leg_space_LOCAL_MMX.i[0]";
connectAttr "L_leg_MOD.wim" "l_leg_space_LOCAL_MMX.i[1]";
connectAttr "MC_CONTROLS.wm" "l_leg_space_SPACE0_MMX.i[1]";
connectAttr "C_chest_FK_CTRL.wm" "l_leg_space_SPACE1_MMX.i[1]";
connectAttr "R_upperArm_FK_DRV_JNT.wm" "r_arm_blend_0_BLM.imat";
connectAttr "r_arm_blend_0_CORRECT_MMX.o" "r_arm_blend_0_BLM.tgt[0].tmat";
connectAttr "R_hand_IK_CTRL.ikFk" "r_arm_blend_0_BLM.tgt[0].wgt";
connectAttr "R_hand_IK_CTRL.matchCorr0X" "r_arm_blend_0_CORRECT_CMP.irx";
connectAttr "R_hand_IK_CTRL.matchCorr0Y" "r_arm_blend_0_CORRECT_CMP.iry";
connectAttr "R_hand_IK_CTRL.matchCorr0Z" "r_arm_blend_0_CORRECT_CMP.irz";
connectAttr "r_arm_blend_0_CORRECT_CMP.omat" "r_arm_blend_0_CORRECT_MMX.i[0]";
connectAttr "R_upperArm_IK_DRV_JNT.wm" "r_arm_blend_0_CORRECT_MMX.i[1]";
connectAttr "r_arm_blend_0_BLM.omat" "r_arm_blend_0_LOCAL_MMX.i[0]";
connectAttr "MC_DELIVERY.wim" "r_arm_blend_0_LOCAL_MMX.i[1]";
connectAttr "R_forearm_FK_DRV_JNT.wm" "r_arm_blend_1_BLM.imat";
connectAttr "r_arm_blend_1_CORRECT_MMX.o" "r_arm_blend_1_BLM.tgt[0].tmat";
connectAttr "R_hand_IK_CTRL.ikFk" "r_arm_blend_1_BLM.tgt[0].wgt";
connectAttr "R_hand_IK_CTRL.matchCorr1X" "r_arm_blend_1_CORRECT_CMP.irx";
connectAttr "R_hand_IK_CTRL.matchCorr1Y" "r_arm_blend_1_CORRECT_CMP.iry";
connectAttr "R_hand_IK_CTRL.matchCorr1Z" "r_arm_blend_1_CORRECT_CMP.irz";
connectAttr "r_arm_blend_1_CORRECT_CMP.omat" "r_arm_blend_1_CORRECT_MMX.i[0]";
connectAttr "R_forearm_IK_DRV_JNT.wm" "r_arm_blend_1_CORRECT_MMX.i[1]";
connectAttr "r_arm_blend_1_BLM.omat" "r_arm_blend_1_LOCAL_MMX.i[0]";
connectAttr "R_upperArm_RESULT_JNT.wim" "r_arm_blend_1_LOCAL_MMX.i[1]";
connectAttr "R_hand_FK_DRV_JNT.wm" "r_arm_blend_2_BLM.imat";
connectAttr "r_arm_blend_2_CORRECT_MMX.o" "r_arm_blend_2_BLM.tgt[0].tmat";
connectAttr "R_hand_IK_CTRL.ikFk" "r_arm_blend_2_BLM.tgt[0].wgt";
connectAttr "R_hand_IK_CTRL.matchCorr2X" "r_arm_blend_2_CORRECT_CMP.irx";
connectAttr "R_hand_IK_CTRL.matchCorr2Y" "r_arm_blend_2_CORRECT_CMP.iry";
connectAttr "R_hand_IK_CTRL.matchCorr2Z" "r_arm_blend_2_CORRECT_CMP.irz";
connectAttr "r_arm_blend_2_CORRECT_CMP.omat" "r_arm_blend_2_CORRECT_MMX.i[0]";
connectAttr "R_hand_IK_DRV_JNT.wm" "r_arm_blend_2_CORRECT_MMX.i[1]";
connectAttr "r_arm_blend_2_BLM.omat" "r_arm_blend_2_LOCAL_MMX.i[0]";
connectAttr "R_forearm_RESULT_JNT.wim" "r_arm_blend_2_LOCAL_MMX.i[1]";
connectAttr "R_upperArm_FK_CTRL.wm" "r_arm_drive_0_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "r_arm_drive_0_MMX.i[1]";
connectAttr "R_forearm_FK_CTRL.wm" "r_arm_drive_1_MMX.i[0]";
connectAttr "R_upperArm_FK_DRV_JNT.wim" "r_arm_drive_1_MMX.i[1]";
connectAttr "R_hand_FK_CTRL.wm" "r_arm_drive_2_MMX.i[0]";
connectAttr "R_forearm_FK_DRV_JNT.wim" "r_arm_drive_2_MMX.i[1]";
connectAttr "R_hand_IK_CTRL.twist" "unitConversion3.i";
connectAttr "r_arm_space_SPACE0_MMX.o" "r_arm_space_CHOICE.i[0]";
connectAttr "r_arm_space_SPACE1_MMX.o" "r_arm_space_CHOICE.i[1]";
connectAttr "R_hand_IK_CTRL.space" "r_arm_space_CHOICE.s";
connectAttr "r_arm_space_CHOICE.o" "r_arm_space_LOCAL_MMX.i[0]";
connectAttr "R_arm_MOD.wim" "r_arm_space_LOCAL_MMX.i[1]";
connectAttr "MC_CONTROLS.wm" "r_arm_space_SPACE0_MMX.i[1]";
connectAttr "C_chest_FK_CTRL.wm" "r_arm_space_SPACE1_MMX.i[1]";
connectAttr "R_thigh_FK_DRV_JNT.wm" "r_leg_blend_0_BLM.imat";
connectAttr "r_leg_blend_0_CORRECT_MMX.o" "r_leg_blend_0_BLM.tgt[0].tmat";
connectAttr "R_foot_IK_CTRL.ikFk" "r_leg_blend_0_BLM.tgt[0].wgt";
connectAttr "R_foot_IK_CTRL.matchCorr0X" "r_leg_blend_0_CORRECT_CMP.irx";
connectAttr "R_foot_IK_CTRL.matchCorr0Y" "r_leg_blend_0_CORRECT_CMP.iry";
connectAttr "R_foot_IK_CTRL.matchCorr0Z" "r_leg_blend_0_CORRECT_CMP.irz";
connectAttr "r_leg_blend_0_CORRECT_CMP.omat" "r_leg_blend_0_CORRECT_MMX.i[0]";
connectAttr "R_thigh_IK_DRV_JNT.wm" "r_leg_blend_0_CORRECT_MMX.i[1]";
connectAttr "r_leg_blend_0_BLM.omat" "r_leg_blend_0_LOCAL_MMX.i[0]";
connectAttr "MC_DELIVERY.wim" "r_leg_blend_0_LOCAL_MMX.i[1]";
connectAttr "R_calf_FK_DRV_JNT.wm" "r_leg_blend_1_BLM.imat";
connectAttr "r_leg_blend_1_CORRECT_MMX.o" "r_leg_blend_1_BLM.tgt[0].tmat";
connectAttr "R_foot_IK_CTRL.ikFk" "r_leg_blend_1_BLM.tgt[0].wgt";
connectAttr "R_foot_IK_CTRL.matchCorr1X" "r_leg_blend_1_CORRECT_CMP.irx";
connectAttr "R_foot_IK_CTRL.matchCorr1Y" "r_leg_blend_1_CORRECT_CMP.iry";
connectAttr "R_foot_IK_CTRL.matchCorr1Z" "r_leg_blend_1_CORRECT_CMP.irz";
connectAttr "r_leg_blend_1_CORRECT_CMP.omat" "r_leg_blend_1_CORRECT_MMX.i[0]";
connectAttr "R_calf_IK_DRV_JNT.wm" "r_leg_blend_1_CORRECT_MMX.i[1]";
connectAttr "r_leg_blend_1_BLM.omat" "r_leg_blend_1_LOCAL_MMX.i[0]";
connectAttr "R_thigh_RESULT_JNT.wim" "r_leg_blend_1_LOCAL_MMX.i[1]";
connectAttr "R_foot_FK_DRV_JNT.wm" "r_leg_blend_2_BLM.imat";
connectAttr "r_leg_blend_2_CORRECT_MMX.o" "r_leg_blend_2_BLM.tgt[0].tmat";
connectAttr "R_foot_IK_CTRL.ikFk" "r_leg_blend_2_BLM.tgt[0].wgt";
connectAttr "R_foot_IK_CTRL.matchCorr2X" "r_leg_blend_2_CORRECT_CMP.irx";
connectAttr "R_foot_IK_CTRL.matchCorr2Y" "r_leg_blend_2_CORRECT_CMP.iry";
connectAttr "R_foot_IK_CTRL.matchCorr2Z" "r_leg_blend_2_CORRECT_CMP.irz";
connectAttr "r_leg_blend_2_CORRECT_CMP.omat" "r_leg_blend_2_CORRECT_MMX.i[0]";
connectAttr "R_foot_IK_DRV_JNT.wm" "r_leg_blend_2_CORRECT_MMX.i[1]";
connectAttr "r_leg_blend_2_BLM.omat" "r_leg_blend_2_LOCAL_MMX.i[0]";
connectAttr "R_calf_RESULT_JNT.wim" "r_leg_blend_2_LOCAL_MMX.i[1]";
connectAttr "R_thigh_FK_CTRL.wm" "r_leg_drive_0_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "r_leg_drive_0_MMX.i[1]";
connectAttr "R_calf_FK_CTRL.wm" "r_leg_drive_1_MMX.i[0]";
connectAttr "R_thigh_FK_DRV_JNT.wim" "r_leg_drive_1_MMX.i[1]";
connectAttr "R_foot_FK_CTRL.wm" "r_leg_drive_2_MMX.i[0]";
connectAttr "R_calf_FK_DRV_JNT.wim" "r_leg_drive_2_MMX.i[1]";
connectAttr "R_foot_IK_CTRL.twist" "unitConversion4.i";
connectAttr "r_leg_space_SPACE0_MMX.o" "r_leg_space_CHOICE.i[0]";
connectAttr "r_leg_space_SPACE1_MMX.o" "r_leg_space_CHOICE.i[1]";
connectAttr "R_foot_IK_CTRL.space" "r_leg_space_CHOICE.s";
connectAttr "r_leg_space_CHOICE.o" "r_leg_space_LOCAL_MMX.i[0]";
connectAttr "R_leg_MOD.wim" "r_leg_space_LOCAL_MMX.i[1]";
connectAttr "MC_CONTROLS.wm" "r_leg_space_SPACE0_MMX.i[1]";
connectAttr "C_chest_FK_CTRL.wm" "r_leg_space_SPACE1_MMX.i[1]";
connectAttr "C_chest_FK_CTRL.wm" "spine_drive_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "spine_drive_MMX.i[1]";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "ikRPsolver.msg" ":ikSystem.sol" -na;
// End of mayacraft_match_success.ma
