//Maya ASCII 2025ff03 scene
//Name: mayacraft_space_switch.ma
//Last modified: Thu, Aug 27, 2026 09:17:30 PM
//Codeset: 936
requires maya "2025ff03";
requires -nodeType "quatToEuler" -nodeType "quatNormalize" -nodeType "quatSlerp"
		 "quatNodes" "1.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2025";
fileInfo "version" "2025";
fileInfo "cutIdentifier" "202607282326-cffc1a54f2";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "67412142-4B25-3BD5-00E2-4AA7CF6CB200";
createNode transform -s -n "persp";
	rename -uid "35A87DDB-4C5A-D079-BFDD-BFA6D51F970E";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "D246AB17-4CE9-64B8-09B2-AEB33F2C3A75";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "0AE11BBE-4754-FF42-B066-28A1518BF168";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "6C3ECB30-4DBE-3F60-4BCD-82B5CBB58BB6";
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
	rename -uid "0020A8BB-40DD-13C7-3145-A7A030311F75";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "D477A14F-474E-8285-0AF6-EABA837C5B2F";
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
	rename -uid "AEB3AD91-431D-D9EE-A9BE-A49209C6D01E";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "23AFFE50-462F-89AC-3417-18A06A4D8C24";
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
	rename -uid "80C1FE68-405C-313D-4C6A-F193B7EDE4F5";
	addAttr -ci true -sn "mayacraftDemoScenario" -ln "mayacraftDemoScenario" -dt "string";
	addAttr -ci true -sn "mayacraftExpectedResult" -ln "mayacraftExpectedResult" -dt "string";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".mayacraftDemoScenario" -type "string" "KEYED_SPACE_SWITCH";
	setAttr ".mayacraftExpectedResult" -type "string" "第 12 帧从全局切到胸腔；第 11 帧保护键与第 12 帧补偿键保持手腕世界姿态";
createNode joint -n "pelvis_JNT" -p "root_JNT";
	rename -uid "2646CD65-45D1-C1D5-87C6-2E894FF11747";
	setAttr ".t" -type "double3" 0 10 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "spine_JNT" -p "pelvis_JNT";
	rename -uid "7DEB01CD-425F-4BA1-3B01-98BACE5D70C8";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "chest_JNT" -p "spine_JNT";
	rename -uid "8EE5D0E7-4629-6A14-975D-94AC23602BC3";
	setAttr ".t" -type "double3" 0 4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "neck_JNT" -p "chest_JNT";
	rename -uid "8E0C0B35-4C52-2003-A239-2BA56FC0F6CE";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "head_JNT" -p "neck_JNT";
	rename -uid "8591B9D6-49D4-0611-BA63-F88440007BE1";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_upperArm_JNT" -p "chest_JNT";
	rename -uid "00098738-41A4-88C9-E0DD-A4967491CF28";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_forearm_JNT" -p "L_upperArm_JNT";
	rename -uid "EEB9DCF4-4FB5-1495-3D91-78B7FB22A494";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_hand_JNT" -p "L_forearm_JNT";
	rename -uid "F4C690C3-4656-E88B-8270-C6A793FBECA1";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_upperArm_JNT" -p "chest_JNT";
	rename -uid "4ECECE85-4227-A49F-40BD-76BD55CED28D";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_forearm_JNT" -p "R_upperArm_JNT";
	rename -uid "AF126791-4B32-0074-277F-FEA082E9A6EE";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_hand_JNT" -p "R_forearm_JNT";
	rename -uid "40AADA91-45E1-1F87-5673-C4A07515094D";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_thigh_JNT" -p "pelvis_JNT";
	rename -uid "D8558541-45F4-234B-6645-B7913E202658";
	setAttr ".t" -type "double3" 3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_calf_JNT" -p "L_thigh_JNT";
	rename -uid "33E9C1B4-46B2-7C77-BDB9-18A1C62B2D19";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_foot_JNT" -p "L_calf_JNT";
	rename -uid "4807D809-45D6-12CC-2C03-03957DB7C3FD";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_thigh_JNT" -p "pelvis_JNT";
	rename -uid "47A5F1AC-4C42-5EDB-140C-56A80E314CC3";
	setAttr ".t" -type "double3" -3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_calf_JNT" -p "R_thigh_JNT";
	rename -uid "526A6A3F-4CDA-B3A5-BB82-6F89EC07B202";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_foot_JNT" -p "R_calf_JNT";
	rename -uid "01DD0633-4C67-85A6-185B-F295BC3D096B";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode transform -n "MC_RIG";
	rename -uid "E37F8E24-4AA4-2875-96F1-DBBA95C83DAE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.root";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "MC_CONTROLS" -p "MC_RIG";
	rename -uid "FB71E4BF-4771-2AF2-E441-008B220BFFBE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.controls";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_arm_MOD" -p "MC_CONTROLS";
	rename -uid "D1048899-4012-4FF6-7FFE-63932146B5C3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_upperArm_FK_CTRL" -p "L_arm_MOD";
	rename -uid "505A96E8-432C-D2B3-F365-8DA3EEE7CB8E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_FK_CTRLShape" -p "L_upperArm_FK_CTRL";
	rename -uid "0970A4EF-4797-2FF6-C182-56B33E1D88C7";
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
	rename -uid "30B90529-4BE9-FE4C-8945-57BCF9B95C2D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_FK_CTRLShape" -p "L_forearm_FK_CTRL";
	rename -uid "EF1FD8A3-4024-8E3E-7097-57AF46D73949";
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
	rename -uid "6183D560-4E5A-0350-65CF-72AF51B8B87A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode nurbsCurve -n "L_hand_FK_CTRLShape" -p "L_hand_FK_CTRL";
	rename -uid "757BBF15-4D64-BEE8-785F-C68AF9453521";
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
	rename -uid "A18D01ED-4D43-20CF-DCC9-069BEC8B6E82";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_hand_IK_CTRL" -p "L_arm_IK_SPACE";
	rename -uid "9DDD2B1A-4E56-2F41-3C3A-239F59C97C48";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
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
	rename -uid "D0375B22-4D68-6DFA-330E-46918E0110F8";
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
	rename -uid "E84D155D-4B70-4D23-F6C6-88801555C92A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.ik.ctrl|l_arm.pole.ctrl\"],[\"targets\",\"l_arm.ik_joint.0|l_arm.ik_joint.1|l_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_arm_rp_ik_PVC" -p "l_arm_rp_ik_IKH";
	rename -uid "8B340587-4068-4169-2D5C-F2964554282E";
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
	rename -uid "44691A95-4E5B-15BC-59F3-169773955287";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_arm|left_lower_arm|left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_arm_POLE_CTRLShape" -p "L_arm_POLE_CTRL";
	rename -uid "121152CE-43E1-65C6-637B-A898DFB9A5B4";
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
	rename -uid "F8D890AB-4882-740B-E284-EA8253934134";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_thigh_FK_CTRL" -p "L_leg_MOD";
	rename -uid "C6FB544F-45EA-2776-6957-41B472D13F08";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_FK_CTRLShape" -p "L_thigh_FK_CTRL";
	rename -uid "DFCD49AB-44E6-BF8E-A1ED-F6A22B1ED455";
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
	rename -uid "5C79ACBB-4809-60B7-D589-46B3AE11F67A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_FK_CTRLShape" -p "L_calf_FK_CTRL";
	rename -uid "3D345F28-4B5A-21D8-38F9-BEAFDB3F965A";
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
	rename -uid "A5BF8919-4997-7366-442E-24BA6C84548F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode nurbsCurve -n "L_foot_FK_CTRLShape" -p "L_foot_FK_CTRL";
	rename -uid "D1D65CFE-4B98-54E5-F4F2-C3AF609D8EA4";
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
	rename -uid "AFE5AD77-4332-88C6-2FD7-8889E12C9564";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_foot_IK_CTRL" -p "L_leg_IK_SPACE";
	rename -uid "A27F7F73-4213-D34B-B5BE-6D8BA8D1FCE4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
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
	rename -uid "7A4D7C64-45F5-788E-02CF-5AB9421D8C9A";
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
	rename -uid "97633646-4161-9087-B036-93B664C77683";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.ik.ctrl|l_leg.pole.ctrl\"],[\"targets\",\"l_leg.ik_joint.0|l_leg.ik_joint.1|l_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_leg_rp_ik_PVC" -p "l_leg_rp_ik_IKH";
	rename -uid "592FEDD0-40B1-2D70-C5E1-AEB3A69D8FDB";
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
	rename -uid "ABA0232A-4F5D-77AC-898E-76A678517522";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_leg|left_lower_leg|left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_leg_POLE_CTRLShape" -p "L_leg_POLE_CTRL";
	rename -uid "1CFA9B6D-475A-A411-9953-6A910F1A45FA";
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
	rename -uid "076F7221-44A0-A100-19EE-8CBDCF53113F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_upperArm_FK_CTRL" -p "R_arm_MOD";
	rename -uid "6C05BEF7-4DF6-1191-D978-738E5F258F46";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_FK_CTRLShape" -p "R_upperArm_FK_CTRL";
	rename -uid "1F734702-45BB-9D8D-3D62-56A42399247B";
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
	rename -uid "CE34A04F-40DF-D5E7-09AA-DBBD6C80C65A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_FK_CTRLShape" -p "R_forearm_FK_CTRL";
	rename -uid "DA5FCAAC-4D94-858E-FD60-35A1627D4BA8";
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
	rename -uid "869F2418-43F5-1E9E-8F99-91ABF756A252";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode nurbsCurve -n "R_hand_FK_CTRLShape" -p "R_hand_FK_CTRL";
	rename -uid "DEC75054-4C70-1BF8-BEFA-89914B7169A6";
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
	rename -uid "1B4AA69A-4B09-944C-1117-8A96644C8E16";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_hand_IK_CTRL" -p "R_arm_IK_SPACE";
	rename -uid "5F6CBB13-457F-22B0-BCD2-FC8FC230C353";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
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
	rename -uid "CA19E1E0-42DB-1674-8A94-EBB8E61ADB6E";
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
	rename -uid "0CCA713A-4B98-5435-65A7-53A70BC8D467";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.ik.ctrl|r_arm.pole.ctrl\"],[\"targets\",\"r_arm.ik_joint.0|r_arm.ik_joint.1|r_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_arm_rp_ik_PVC" -p "r_arm_rp_ik_IKH";
	rename -uid "A3E25596-42B8-4B5A-3E0B-13BD32B771C0";
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
	rename -uid "E64202C8-4551-3B30-D6E4-0FA8BC2B1789";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_arm|right_lower_arm|right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,-4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_arm_POLE_CTRLShape" -p "R_arm_POLE_CTRL";
	rename -uid "8C0A45B5-4B3D-B52E-3A99-F88FBE11CDED";
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
	rename -uid "5A05E1DF-457A-4A78-F5D7-51964395FF56";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_thigh_FK_CTRL" -p "R_leg_MOD";
	rename -uid "452ACF6F-41C4-11B4-FF0A-0587093BF6C8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_FK_CTRLShape" -p "R_thigh_FK_CTRL";
	rename -uid "DFB125AF-4220-EF35-6C13-C59BA4B93E96";
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
	rename -uid "9C3713B1-469E-96DC-556A-4BA60EAE01F7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_FK_CTRLShape" -p "R_calf_FK_CTRL";
	rename -uid "F7D95F06-46E4-1B97-1BCD-F09F3C8BE481";
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
	rename -uid "F618D6D4-4625-6B55-CC2B-F1B29941C759";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode nurbsCurve -n "R_foot_FK_CTRLShape" -p "R_foot_FK_CTRL";
	rename -uid "79DD17A5-4892-51CA-4FA0-16B6D5DF814C";
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
	rename -uid "956AAFD5-451D-4821-1E2D-80A0D58B194A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_foot_IK_CTRL" -p "R_leg_IK_SPACE";
	rename -uid "47FC98DC-451D-284C-6E0B-619F215401ED";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
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
	rename -uid "AC5ACCE0-4F5B-AD46-20BE-5CB34B8B2893";
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
	rename -uid "BDEA137F-4740-D091-3836-4BB775F005EC";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.ik.ctrl|r_leg.pole.ctrl\"],[\"targets\",\"r_leg.ik_joint.0|r_leg.ik_joint.1|r_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_leg_rp_ik_PVC" -p "r_leg_rp_ik_IKH";
	rename -uid "FD91EC27-444C-E1A6-07B6-BFAA6B9E323F";
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
	rename -uid "84946ED1-4391-5E9C-36C5-41B87E0BAD1F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_leg|right_lower_leg|right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_leg_POLE_CTRLShape" -p "R_leg_POLE_CTRL";
	rename -uid "75384933-4641-ECC1-E662-748DC1A646BF";
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
	rename -uid "175ED5D2-46F3-D665-30C4-2B933B2FB5FA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "C_chest_FK_CTRL" -p "C_spine_MOD";
	rename -uid "BD76529D-48B0-803C-017E-4FA818CABCA0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.ctrl";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode nurbsCurve -n "C_chest_FK_CTRLShape" -p "C_chest_FK_CTRL";
	rename -uid "49A49930-48A2-C106-B395-ACB6DF1874FF";
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
	rename -uid "C2902A8C-4FD7-1B58-A031-CC956FCCD9BE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode nurbsCurve -n "C_head_FK_CTRLShape" -p "C_head_FK_CTRL";
	rename -uid "B59650A3-49AD-6729-3511-3CA726D1BAA0";
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
	rename -uid "E757750F-4325-CCF8-BE3F-B7A94C00B492";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "547E34C0-4DC3-DDAA-2515-A08967BF170A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_FK_DRV_JNT" -p "L_upperArm_FK_DRV_JNT";
	rename -uid "C1AB3C83-41F8-1D28-23B2-9D8AFA4EBE43";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_FK_DRV_JNT" -p "L_forearm_FK_DRV_JNT";
	rename -uid "74FC0CE4-446F-9B78-7422-FF8E8937F667";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "5EAA8FE9-4756-54E7-75DA-51B086DF49EB";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_IK_DRV_JNT" -p "L_upperArm_IK_DRV_JNT";
	rename -uid "9E6E6377-46A3-50E7-BF80-7A9A6A771614";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_IK_DRV_JNT" -p "L_forearm_IK_DRV_JNT";
	rename -uid "85CEC622-4B5C-68C6-EA2A-8E95E076F5D6";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode ikEffector -n "effector1" -p "L_forearm_IK_DRV_JNT";
	rename -uid "5663C0E2-4824-D4D6-95CB-349C8E1382F5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode joint -n "L_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "61CF991B-4BD8-7DC4-F3DF-CAACF42013DF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_FK_DRV_JNT" -p "L_thigh_FK_DRV_JNT";
	rename -uid "6764E620-4196-9928-8348-C2BB854578FE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_FK_DRV_JNT" -p "L_calf_FK_DRV_JNT";
	rename -uid "A3C5B72A-448D-CEFE-8967-88A87D12634E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "L_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "357F72A0-4EFB-CA3E-13F6-708525A61B2F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_IK_DRV_JNT" -p "L_thigh_IK_DRV_JNT";
	rename -uid "29705AAF-4E28-12C6-61AA-759AD8DC949E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_IK_DRV_JNT" -p "L_calf_IK_DRV_JNT";
	rename -uid "6B35A825-4621-F808-7CB4-28BC848F20A2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode ikEffector -n "effector2" -p "L_calf_IK_DRV_JNT";
	rename -uid "C4266593-470C-2520-08B3-3089E9189506";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode joint -n "R_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "F47F5485-470E-C539-6E25-9D8872ADE63D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_FK_DRV_JNT" -p "R_upperArm_FK_DRV_JNT";
	rename -uid "FF6CC883-4358-6D10-1511-9DB2F0DBF410";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_FK_DRV_JNT" -p "R_forearm_FK_DRV_JNT";
	rename -uid "F0CCA4FF-4B35-35C8-6EA9-C18CC0B8BC0F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "E66B1BB3-4D9E-B14E-404A-6BA8BEAA3A9A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_IK_DRV_JNT" -p "R_upperArm_IK_DRV_JNT";
	rename -uid "82C94563-40F8-E90B-9238-7E8FD6C237E5";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_IK_DRV_JNT" -p "R_forearm_IK_DRV_JNT";
	rename -uid "0BC214C6-48FE-03C1-2CC3-09B4FD4B8E29";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode ikEffector -n "effector3" -p "R_forearm_IK_DRV_JNT";
	rename -uid "DB66E652-451A-4B33-7C1E-C3BBB12E973B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode joint -n "R_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "B086D9DA-4B24-A0E1-4F05-79BDA4E4586A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_FK_DRV_JNT" -p "R_thigh_FK_DRV_JNT";
	rename -uid "7B788961-4D01-9333-19D8-069873A830B5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_FK_DRV_JNT" -p "R_calf_FK_DRV_JNT";
	rename -uid "DC154B90-4EEC-B3B3-CDEC-A6A3C0E971F6";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode joint -n "R_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "FADCE6AC-4999-9ACD-73B0-99AE7F283B3C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_IK_DRV_JNT" -p "R_thigh_IK_DRV_JNT";
	rename -uid "D2622123-471A-15CD-0FAB-ECBEC972D01E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_IK_DRV_JNT" -p "R_calf_IK_DRV_JNT";
	rename -uid "6AD2B5F2-48C5-EE19-9F95-8AB74D258128";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode ikEffector -n "effector4" -p "R_calf_IK_DRV_JNT";
	rename -uid "5871DADA-4581-F2E5-AC88-F4AA6BF4D1AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode joint -n "C_chest_DRV_JNT" -p "MC_DEFORM";
	rename -uid "BD0C6E0D-48F3-7663-30A7-3F834B7A5037";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode joint -n "C_head_DRV_JNT" -p "C_chest_DRV_JNT";
	rename -uid "B438EE7F-4951-5D7E-0E20-8CB6AC3AD955";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "head.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode transform -n "MC_DELIVERY" -p "MC_RIG";
	rename -uid "560698D9-46AD-A670-A64A-2E89B3CE13D5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.delivery";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "528645F1-4877-5BD4-041B-E2BAB2ED4AA7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_RESULT_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "27991CF1-43D8-AD26-E707-E2B3A4D14050";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_RESULT_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "DE111430-47B0-26D3-5441-2AA0815E1B75";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_forearm_TWIST_01_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "1CC65EEE-4832-C709-9486-5996D7FC8726";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0.75 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_02_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "80972BDB-4B75-C0B6-7879-92A8E7C719B7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 1.5 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_03_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "4D28E424-4242-F8E2-E948-DE81804B3794";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 2.25 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_upperArm_TWIST_01_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "22EBBC65-44B2-3CE0-4B1F-A3BB2D5D6EB8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 1 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_02_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "E41EB6F7-4A93-9AD5-3659-73A751B1C186";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 2 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_03_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "347684AB-42EA-3AB2-6D8A-D98BBE2515A3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "222F809C-4909-135E-320C-AD950344F9B4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_RESULT_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "341986FC-4851-93E9-F3C5-2F91C827EB75";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_RESULT_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "27AE7998-41FB-2CE6-B73F-E8913BEF960C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "L_calf_TWIST_01_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "A257009B-4E73-06E1-39FE-D5B4139E4D5D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -1 0.25 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_02_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "74F5B396-4BFC-5216-CB83-9EA9D3D67BCE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -2 0.5 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_03_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "A9CFD460-43E4-8DB6-E894-0EB796F3AA8D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -3 0.75 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_thigh_TWIST_01_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "4A81A0F1-4799-2A5E-F304-A59CC88EDE7C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -1 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_02_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "76EEC721-450F-2836-4AE3-9E9B8F9BADCA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -2 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_03_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "9824DF6B-4951-5BE9-9404-63B3049F1F7A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -3 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "R_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "BB6C3D41-4900-9F44-0CF1-E4A3AD6812E8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_RESULT_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "D3DDD27C-4457-52CF-E73A-FE9A82D0F0B1";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_RESULT_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "D861D64F-4B8F-2D4E-DA26-7188D29799F9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_forearm_TWIST_01_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "B57A500A-479C-4D00-83FF-BD8D4C46E098";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -0.75 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_02_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "D96EEF83-4D8E-9D83-8176-CE985975B8D8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -1.5 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_03_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "33FF901F-417E-70B0-4885-46820519B64B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -2.25 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_upperArm_TWIST_01_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "A96FF815-405D-32A6-6FE8-C299CACB1208";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -1 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_02_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "305C54D4-4FEB-16A4-A152-67A7D71D48CA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -2 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_03_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "F3BD4B95-4D6E-EDFB-8ED5-03B293314C64";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "5A11E7E5-41D1-E724-F7E6-1B9B43A170EE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_RESULT_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "E4AB7631-473D-61F9-0852-809CAD102C5F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_RESULT_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "3545FAF5-4E76-26F5-33FF-D89C656C3E53";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode joint -n "R_calf_TWIST_01_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "B6705C90-4B77-6B2A-65A1-B48AFCC01AFD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -1 0.25 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_02_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "575E5864-4B0C-DE4F-02D8-EAB0E1683282";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -2 0.5 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_03_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "75072A3B-4015-EDF9-BC0B-8C99D577DC11";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -3 0.75 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_thigh_TWIST_01_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "1E1F0D6B-42EC-EAE2-2CB5-60B6F94AB9CE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -1 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_02_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "9DC5C677-4733-82F9-3D66-0CB6F3E3788D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -2 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_03_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "84C9B5B7-4CB3-CFD5-5828-A184CC18A872";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 0 -3 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "6BCFF078-4011-7711-8FC6-2F9751BC9CD6";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "7F0FAEBE-4AFD-56A9-E82D-A1BDCCEADC3C";
createNode displayLayer -n "defaultLayer";
	rename -uid "EE284F2D-4012-5748-2595-2B8538BE6DBC";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "16E876AD-4835-68CB-12B6-C19A52F6527B";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "AD12D811-45B9-4AB4-E490-CFA1354CC7A9";
	setAttr ".g" yes;
createNode multMatrix -n "head_drive_MMX";
	rename -uid "815E8F24-4AAB-572B-0927-F9907D6E8104";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"head.ctrl\"],[\"targets\",\"head.deform\"]]";
createNode blendMatrix -n "l_arm_blend_0_BLM";
	rename -uid "F2984348-460F-365F-4159-CFAACC5B5B8B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.0|l_arm.ik_joint.0|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_0_CORRECT_CMP";
	rename -uid "C2DED06C-46D3-76A0-E14F-A1B8CFA14BA7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_CORRECT_MMX";
	rename -uid "0C1C31EA-4F72-C066-33DA-6AA99E78FF68";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_LOCAL_MMX";
	rename -uid "8DE71E81-4221-AB11-D357-018C27536F6A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode blendMatrix -n "l_arm_blend_1_BLM";
	rename -uid "F3B3D903-4969-CBC1-0705-BC93D1BF285D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.1|l_arm.ik_joint.1|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_1_CORRECT_CMP";
	rename -uid "EEA48620-467B-033C-81A3-6AA56C691FE0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_CORRECT_MMX";
	rename -uid "B30A3DC0-4E64-2D8B-F1D1-F6B7E19176C9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_LOCAL_MMX";
	rename -uid "16FDFA93-4535-CFA3-D544-548A618B130C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode blendMatrix -n "l_arm_blend_2_BLM";
	rename -uid "7F6E3C95-43C9-915E-4A69-AD944DE46DE1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.2|l_arm.ik_joint.2|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_2_CORRECT_CMP";
	rename -uid "AB298B42-4870-E403-2CD3-BD87561BC0B1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_CORRECT_MMX";
	rename -uid "12434BCC-44D3-281B-FDA3-278527978517";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_LOCAL_MMX";
	rename -uid "31519342-423E-4479-9C9D-6A8443C68DF0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_drive_0_MMX";
	rename -uid "2499AEC9-42D8-5D8D-883C-34979AB176C7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.0\"],[\"targets\",\"l_arm.fk_joint.0\"]]";
createNode multMatrix -n "l_arm_drive_1_MMX";
	rename -uid "44D43F23-4B07-D67A-4AA0-8F98A8BB796A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.1\"],[\"targets\",\"l_arm.fk_joint.1\"]]";
createNode multMatrix -n "l_arm_drive_2_MMX";
	rename -uid "F94D565B-41C8-5AAD-B6F7-31922DB46ADC";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.2\"],[\"targets\",\"l_arm.fk_joint.2\"]]";
createNode ikRPsolver -n "ikRPsolver";
	rename -uid "95C0E452-4301-DFD3-B561-72AB42E729A4";
createNode unitConversion -n "unitConversion1";
	rename -uid "D68096DD-46A9-103C-A695-2CB25B614DD4";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_arm_space_CHOICE";
	rename -uid "BFA8C7D8-411D-7D2B-F78A-788D33214371";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_arm_space_LOCAL_MMX";
	rename -uid "89886FAE-42B3-5B6A-0248-45933CD26133";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE0_MMX";
	rename -uid "2E367217-4B9E-68ED-788B-A0BC698070A1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE1_MMX";
	rename -uid "3ACD10EC-4891-2535-A5C9-FB8DA41DFADF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_twist_0_REL_MMX";
	rename -uid "8E8292F0-42DD-F52D-07F3-8DB7AD0BA529";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.deform.1\"],[\"targets\",\"l_arm.twist.0.0|l_arm.twist.0.1|l_arm.twist.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"startRole\",\"left_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_0_REL_DCM";
	rename -uid "492FEF7A-4D9D-4AA3-57A3-B8965C4CAD4D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode vectorProduct -n "l_arm_twist_0_TWIST_DOT";
	rename -uid "6AD11BC0-43C5-85ED-4611-8AB5F31030A5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multiplyDivide -n "l_arm_twist_0_TWIST_PROJECT";
	rename -uid "A20D9AD5-4EBF-D2A7-197E-21B4C5C6FD69";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatNormalize -n "l_arm_twist_0_TWIST_NORM";
	rename -uid "204293FA-4793-EEF7-097E-019FFFEED759";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_01_SLERP";
	rename -uid "77850E08-4297-659F-0A08-66A02DC1578B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.0";
createNode quatToEuler -n "l_arm_twist_0_01_QTE";
	rename -uid "42808D02-4609-4B13-5E55-B88DBA1D0475";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_02_SLERP";
	rename -uid "664DEA6F-4B19-7309-2946-69B1B570A2B1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.1";
createNode quatToEuler -n "l_arm_twist_0_02_QTE";
	rename -uid "5A8BAB51-4B95-FB1E-791C-469FA56366CC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_03_SLERP";
	rename -uid "040CF034-429B-EBDA-18C6-FCA622847B19";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.2";
createNode quatToEuler -n "l_arm_twist_0_03_QTE";
	rename -uid "14EF74BD-4A01-8790-8C9F-DE8586FE0379";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multMatrix -n "l_arm_twist_1_REL_MMX";
	rename -uid "E88C2A52-43A1-C97B-516C-7B945C68FD6D";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.deform.2\"],[\"targets\",\"l_arm.twist.1.0|l_arm.twist.1.1|l_arm.twist.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"startRole\",\"left_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_1_REL_DCM";
	rename -uid "88DF1438-4343-CDDC-8242-9AA0846EB348";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode vectorProduct -n "l_arm_twist_1_TWIST_DOT";
	rename -uid "214581AA-46A4-E000-586C-0D957FEF116D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multiplyDivide -n "l_arm_twist_1_TWIST_PROJECT";
	rename -uid "CC5FCCE2-4C8C-0EA8-A00E-E19223D83CEF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatNormalize -n "l_arm_twist_1_TWIST_NORM";
	rename -uid "AEC9CBD3-4392-B1A1-7E07-38897B6EEA12";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_01_SLERP";
	rename -uid "1705D2AD-422E-C41B-1047-F7A4A3CDF161";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.0";
createNode quatToEuler -n "l_arm_twist_1_01_QTE";
	rename -uid "87AFBF97-437F-BAFC-C5EF-47B9489630DD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_02_SLERP";
	rename -uid "3DB02C76-4B42-3C6D-B2E8-D69312C49A4A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.1";
createNode quatToEuler -n "l_arm_twist_1_02_QTE";
	rename -uid "ABF834D5-4F80-3C74-AF3A-8487562D2B1F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_03_SLERP";
	rename -uid "389356F5-4608-3EED-9691-BEAC16106BC9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.2";
createNode quatToEuler -n "l_arm_twist_1_03_QTE";
	rename -uid "1C8E6856-44C2-6BD2-CDDB-28A07436C34B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode blendMatrix -n "l_leg_blend_0_BLM";
	rename -uid "1EAB6B89-4E7D-C788-756E-948AF7C5FF4F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.0|l_leg.ik_joint.0|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_0_CORRECT_CMP";
	rename -uid "367B0F53-4887-F54C-5878-39A3706815BE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_CORRECT_MMX";
	rename -uid "2BFF5854-43FF-64FB-407D-C392DE0739B2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_LOCAL_MMX";
	rename -uid "CA9ED581-4F3C-AF88-6B4E-7387A0A99926";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode blendMatrix -n "l_leg_blend_1_BLM";
	rename -uid "1568D360-44B8-0FAF-DC4D-F28ACA55B5E2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.1|l_leg.ik_joint.1|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_1_CORRECT_CMP";
	rename -uid "3076F1A2-40B7-968C-94B6-93A6163821AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_CORRECT_MMX";
	rename -uid "ADF57E59-4FBC-751C-7A28-0EA57D164A97";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_LOCAL_MMX";
	rename -uid "CFC71C8C-4DC4-FCE5-D77B-6EA1175C22AC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode blendMatrix -n "l_leg_blend_2_BLM";
	rename -uid "64EE61F3-41BA-0F4C-C9A2-38B5B8A5995C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.2|l_leg.ik_joint.2|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_2_CORRECT_CMP";
	rename -uid "61C55EBD-4687-A1DC-1FEE-BC9CB22B83AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_CORRECT_MMX";
	rename -uid "981CBC78-46B2-D409-5BF5-A0A48B0378DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_LOCAL_MMX";
	rename -uid "63A9A59D-4D1D-50B2-67DC-7CB3F90F02E1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_drive_0_MMX";
	rename -uid "616E3354-4B10-DE70-3130-9584247D80CE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.0\"],[\"targets\",\"l_leg.fk_joint.0\"]]";
createNode multMatrix -n "l_leg_drive_1_MMX";
	rename -uid "A4A5BD8F-49BB-F71A-0ABE-D98D8A1E5090";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.1\"],[\"targets\",\"l_leg.fk_joint.1\"]]";
createNode multMatrix -n "l_leg_drive_2_MMX";
	rename -uid "8CBBD623-4D7F-8C84-33E5-27BF422F5041";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.2\"],[\"targets\",\"l_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion2";
	rename -uid "AA0FCD3B-4511-2225-6FEC-1B867E06D401";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_leg_space_CHOICE";
	rename -uid "C3250ABF-445A-C16A-8FEB-FBBCF886995A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_leg_space_LOCAL_MMX";
	rename -uid "30D862B1-401C-B0BC-3D94-F78B0BAACF3C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE0_MMX";
	rename -uid "84E51203-426E-6EFF-D8E3-709B40F1434E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE1_MMX";
	rename -uid "80F3E4D5-4E75-E1D0-EF13-99A4DD7AFE71";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_twist_0_REL_MMX";
	rename -uid "A3D0D21B-42E5-F39E-1108-2CBC0948C0C4";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.deform.1\"],[\"targets\",\"l_leg.twist.0.0|l_leg.twist.0.1|l_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"startRole\",\"left_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_0_REL_DCM";
	rename -uid "721D81E0-404D-5E9C-D5D6-F48E9EF90D00";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode vectorProduct -n "l_leg_twist_0_TWIST_DOT";
	rename -uid "3E35DF2E-483F-6B55-D676-92988E0A7F5D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multiplyDivide -n "l_leg_twist_0_TWIST_PROJECT";
	rename -uid "A779101C-4B79-8221-B2B4-CC9A0864D969";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatNormalize -n "l_leg_twist_0_TWIST_NORM";
	rename -uid "701ABE82-454B-E05A-8DF8-9A8D41EEBD6A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_01_SLERP";
	rename -uid "86A81784-443C-FE88-C73E-B99F6E002BE6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.0";
createNode quatToEuler -n "l_leg_twist_0_01_QTE";
	rename -uid "BE19227D-478B-005B-286C-979CDB93FC85";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_02_SLERP";
	rename -uid "9DE4233E-490B-731F-3485-9498F397512B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.1";
createNode quatToEuler -n "l_leg_twist_0_02_QTE";
	rename -uid "7ADE2FBD-4474-E4F2-36D7-E49EC7CB9861";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_03_SLERP";
	rename -uid "F6934C10-4462-AED7-8B47-8A8C3D2BCB99";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.2";
createNode quatToEuler -n "l_leg_twist_0_03_QTE";
	rename -uid "D709E1B7-4415-7A89-DE1E-18B080AB5EFD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multMatrix -n "l_leg_twist_1_REL_MMX";
	rename -uid "D356EE87-4F1F-B76A-F005-4D97608A02C5";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.deform.2\"],[\"targets\",\"l_leg.twist.1.0|l_leg.twist.1.1|l_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"startRole\",\"left_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_1_REL_DCM";
	rename -uid "F40C58A3-412D-75C9-77F2-1892813871CD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode vectorProduct -n "l_leg_twist_1_TWIST_DOT";
	rename -uid "2311D813-467E-A465-AC15-9EB268E6E16A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multiplyDivide -n "l_leg_twist_1_TWIST_PROJECT";
	rename -uid "3938DEBE-4FDA-7F3E-8CDC-2CABCA194732";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatNormalize -n "l_leg_twist_1_TWIST_NORM";
	rename -uid "3218ECF5-47AA-C199-A8BE-0999DB1051A3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_01_SLERP";
	rename -uid "F5DCBE35-4213-FC92-37FC-FAA112E7B8B7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.0";
createNode quatToEuler -n "l_leg_twist_1_01_QTE";
	rename -uid "F790C13B-4D7D-DE0F-C8F3-F48BCFCF9150";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_02_SLERP";
	rename -uid "983446E0-49F5-58AF-DF77-7EA58033C3D9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.1";
createNode quatToEuler -n "l_leg_twist_1_02_QTE";
	rename -uid "473AA9FB-4D4B-46E2-58DD-07B55B9F5457";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_03_SLERP";
	rename -uid "B7D5CF19-4E35-CC1C-7ED4-58BF800DC15D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.2";
createNode quatToEuler -n "l_leg_twist_1_03_QTE";
	rename -uid "7C72BD86-44EA-B880-48F8-BE96B88C7814";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode blendMatrix -n "r_arm_blend_0_BLM";
	rename -uid "6AE51A42-42EF-9C86-15D6-08AF11C1D3DC";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.0|r_arm.ik_joint.0|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_0_CORRECT_CMP";
	rename -uid "B4F5B787-4137-7CA4-A25E-9DAFA76EDB49";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_CORRECT_MMX";
	rename -uid "514DF820-439A-5F97-1D0E-9BB0383A3CFD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_LOCAL_MMX";
	rename -uid "2099FFB7-4129-17A9-E44B-AFB1F9B79102";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode blendMatrix -n "r_arm_blend_1_BLM";
	rename -uid "B9E6BEF2-469E-8726-75CC-A5BE3A419DF3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.1|r_arm.ik_joint.1|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_1_CORRECT_CMP";
	rename -uid "63686606-4967-7071-ED10-BB9976BE8F09";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_CORRECT_MMX";
	rename -uid "34EFE41D-48D0-ACAA-F0B9-1B886E0C370E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_LOCAL_MMX";
	rename -uid "F3DE9040-4253-371F-9C27-C38BFA8D4CE2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode blendMatrix -n "r_arm_blend_2_BLM";
	rename -uid "F50D3B4D-4282-BCC3-97FE-2E87BE483CE3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.2|r_arm.ik_joint.2|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_2_CORRECT_CMP";
	rename -uid "12648C45-4B25-BD6A-630F-2B8B15AC4C30";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_CORRECT_MMX";
	rename -uid "71395059-430C-C4B6-9626-0DA4D7835EE6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_LOCAL_MMX";
	rename -uid "6FA786BE-4C01-73E6-49D7-A9AA11F3CA4B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_drive_0_MMX";
	rename -uid "B12CF6DF-4CF5-497E-0903-768D72759F25";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.0\"],[\"targets\",\"r_arm.fk_joint.0\"]]";
createNode multMatrix -n "r_arm_drive_1_MMX";
	rename -uid "7308C278-453B-4C02-EDCE-4F9C926E7376";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.1\"],[\"targets\",\"r_arm.fk_joint.1\"]]";
createNode multMatrix -n "r_arm_drive_2_MMX";
	rename -uid "DC56FC0B-46F7-13E8-EA40-B588C79923C9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.2\"],[\"targets\",\"r_arm.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion3";
	rename -uid "5C75BF23-4056-9B6A-C043-0083BC4C34CF";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_arm_space_CHOICE";
	rename -uid "D05CF3F0-47DA-C365-86E2-CC9335C247C8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_arm_space_LOCAL_MMX";
	rename -uid "05F7F83C-4991-AD97-2558-D881ED80DB36";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE0_MMX";
	rename -uid "C981DCCE-4303-4B42-6AFA-C29EB8F11131";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE1_MMX";
	rename -uid "B9258E7F-490C-BC31-430F-9CA5EF6A0799";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_twist_0_REL_MMX";
	rename -uid "19636DA6-4AD8-E54F-F941-DA845C74A371";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.deform.1\"],[\"targets\",\"r_arm.twist.0.0|r_arm.twist.0.1|r_arm.twist.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"startRole\",\"right_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_0_REL_DCM";
	rename -uid "157880F0-4C74-ABD1-C353-BC838F241166";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode vectorProduct -n "r_arm_twist_0_TWIST_DOT";
	rename -uid "A5329AD4-42A8-CB8A-3C8B-3EBCD8D5A504";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multiplyDivide -n "r_arm_twist_0_TWIST_PROJECT";
	rename -uid "0F8AA317-468B-79D5-5E79-E18AE81042EF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatNormalize -n "r_arm_twist_0_TWIST_NORM";
	rename -uid "2FBCC0A7-49C0-D555-512A-908A6E1B56D5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_01_SLERP";
	rename -uid "8FC9DA03-47B5-44B4-CEC2-C7A1F3B928FA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.0";
createNode quatToEuler -n "r_arm_twist_0_01_QTE";
	rename -uid "38266CAD-4C74-5784-E123-8EA288F323A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_02_SLERP";
	rename -uid "0AC31ECA-4B5A-C854-E30A-83A5822B4B15";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.1";
createNode quatToEuler -n "r_arm_twist_0_02_QTE";
	rename -uid "6922CF31-4FA5-743B-68A6-B9B2B48F26DA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_03_SLERP";
	rename -uid "89BFAB2A-44F7-760A-0D57-F4B1D668E80B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.2";
createNode quatToEuler -n "r_arm_twist_0_03_QTE";
	rename -uid "77F6A241-4A62-A2FB-F6B8-0384401F5910";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multMatrix -n "r_arm_twist_1_REL_MMX";
	rename -uid "2DAC7D59-494F-19B8-36A5-5E9C8E2435BC";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.deform.2\"],[\"targets\",\"r_arm.twist.1.0|r_arm.twist.1.1|r_arm.twist.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"startRole\",\"right_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_1_REL_DCM";
	rename -uid "EDD7F64A-4803-0CC5-7708-45BF9C88775E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode vectorProduct -n "r_arm_twist_1_TWIST_DOT";
	rename -uid "F3BC2842-49C5-5B39-39DB-9EB09AAF61C7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multiplyDivide -n "r_arm_twist_1_TWIST_PROJECT";
	rename -uid "6CD7CF37-4C0F-D73C-99A0-D2BF556543CC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatNormalize -n "r_arm_twist_1_TWIST_NORM";
	rename -uid "51D6D342-494C-1503-7F2F-5FA8E38A037E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_01_SLERP";
	rename -uid "7649E88E-4771-60DC-CDB4-BF83AB8AABA9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.0";
createNode quatToEuler -n "r_arm_twist_1_01_QTE";
	rename -uid "58ACC343-437E-5389-88C6-E0BAFB12C19D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_02_SLERP";
	rename -uid "BC43A472-4797-B649-0D60-A68148A39FB6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.1";
createNode quatToEuler -n "r_arm_twist_1_02_QTE";
	rename -uid "803330C5-4C5F-8198-2506-D68656E26F75";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_03_SLERP";
	rename -uid "E5DDCBB7-401B-E35C-EB8D-5C84C5EBEE49";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.2";
createNode quatToEuler -n "r_arm_twist_1_03_QTE";
	rename -uid "C98CB001-4E31-FF81-61C0-B596DADE042D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode blendMatrix -n "r_leg_blend_0_BLM";
	rename -uid "530986DC-45F4-3144-EF22-7CA85C61D6AE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.0|r_leg.ik_joint.0|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_0_CORRECT_CMP";
	rename -uid "4BE23750-487A-9D79-6608-C6AEF82F2990";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_CORRECT_MMX";
	rename -uid "C851BD7F-4761-6953-5445-D29E7E857587";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_LOCAL_MMX";
	rename -uid "9D14C3D1-4B7F-0E7B-116F-40BFD50D0198";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode blendMatrix -n "r_leg_blend_1_BLM";
	rename -uid "B9FFE2FE-42C9-4E38-AA46-8BB437A35D79";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.1|r_leg.ik_joint.1|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_1_CORRECT_CMP";
	rename -uid "7945C62E-425B-38E8-F81A-1695ABAA115B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_CORRECT_MMX";
	rename -uid "D0F59603-40D4-57D5-F747-0CA5EF29A989";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_LOCAL_MMX";
	rename -uid "99438FA1-4B57-0593-BEAE-209548315B7C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode blendMatrix -n "r_leg_blend_2_BLM";
	rename -uid "A9850627-4573-17F6-7765-AD859F055BD0";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.2|r_leg.ik_joint.2|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_2_CORRECT_CMP";
	rename -uid "B8EA5F36-4AFD-CAD4-6FD2-9EB6B586ED45";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_CORRECT_MMX";
	rename -uid "B37C1CC9-441D-889C-8D32-15B272899E55";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_LOCAL_MMX";
	rename -uid "A78FBB5C-4B37-5649-DC65-D19FBA6D5547";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_drive_0_MMX";
	rename -uid "115C146A-4BC8-8D33-1BC5-2F835C753D58";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.0\"],[\"targets\",\"r_leg.fk_joint.0\"]]";
createNode multMatrix -n "r_leg_drive_1_MMX";
	rename -uid "31892C34-4905-ABAF-B8D0-7099622F85A7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.1\"],[\"targets\",\"r_leg.fk_joint.1\"]]";
createNode multMatrix -n "r_leg_drive_2_MMX";
	rename -uid "C439B582-4BDE-AC73-03AD-FD9AA9A1478F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.2\"],[\"targets\",\"r_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion4";
	rename -uid "5E65570B-4718-06CD-6DDB-74850AEFC795";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_leg_space_CHOICE";
	rename -uid "A2BAE1B9-4451-0278-8E47-76873A07E0BB";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_leg_space_LOCAL_MMX";
	rename -uid "88565EE0-42CE-5FDE-2D9D-818C1F5FF4BF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE0_MMX";
	rename -uid "CEB93D14-4BC6-0528-0D5F-4DB3E342FB1F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE1_MMX";
	rename -uid "066E63A6-41FF-EBCC-1BFE-C9A5728C02DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_twist_0_REL_MMX";
	rename -uid "8EC9422C-4F7F-1B39-8EB9-21AE44F55AC8";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.deform.1\"],[\"targets\",\"r_leg.twist.0.0|r_leg.twist.0.1|r_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"startRole\",\"right_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_0_REL_DCM";
	rename -uid "CC1E5E2E-482B-40ED-5CB4-B988E28BFA1A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode vectorProduct -n "r_leg_twist_0_TWIST_DOT";
	rename -uid "0B4AAC48-4260-D4FB-0CFC-BF9FD24D72D0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multiplyDivide -n "r_leg_twist_0_TWIST_PROJECT";
	rename -uid "515F5E39-44E0-529F-20D6-28968FD7949F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatNormalize -n "r_leg_twist_0_TWIST_NORM";
	rename -uid "6C8F7BCF-4EF0-0005-A07D-D6B8C9FF99A6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_01_SLERP";
	rename -uid "8097712D-4F42-1BF5-884E-31BD85030CF4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.0";
createNode quatToEuler -n "r_leg_twist_0_01_QTE";
	rename -uid "63BBC546-4B24-1664-68DF-9DB4129B4800";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_02_SLERP";
	rename -uid "AD0B2457-4949-8090-D433-C7B5DD9CA5E1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.1";
createNode quatToEuler -n "r_leg_twist_0_02_QTE";
	rename -uid "7D1694A6-4C34-17BE-D30B-D08B9AF8798B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_03_SLERP";
	rename -uid "1D00B441-455A-10F7-D6ED-229C2EB10BD7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.2";
createNode quatToEuler -n "r_leg_twist_0_03_QTE";
	rename -uid "375ED879-445F-CAB7-290A-BDA154D5DAB2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multMatrix -n "r_leg_twist_1_REL_MMX";
	rename -uid "8945768A-4FB8-5275-FCE0-C2A289270FFC";
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
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "twist_distribution";
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.deform.2\"],[\"targets\",\"r_leg.twist.1.0|r_leg.twist.1.1|r_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"startRole\",\"right_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_1_REL_DCM";
	rename -uid "661937D8-4124-9ECB-6021-D8BB8A820D72";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode vectorProduct -n "r_leg_twist_1_TWIST_DOT";
	rename -uid "A6224038-4A20-3131-9919-048CC215EE68";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multiplyDivide -n "r_leg_twist_1_TWIST_PROJECT";
	rename -uid "4AD9E62F-477E-7F93-9955-568F832566B2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatNormalize -n "r_leg_twist_1_TWIST_NORM";
	rename -uid "B4696169-4F61-3E2C-2750-A787D8EDDCC3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_01_SLERP";
	rename -uid "DCCBE84E-454A-D707-1FFA-F8971C482727";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.0";
createNode quatToEuler -n "r_leg_twist_1_01_QTE";
	rename -uid "CDD1C5F3-4DEF-226B-7084-649908472320";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_02_SLERP";
	rename -uid "8517D89E-43A4-E28C-D0DD-2099E6C44342";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.1";
createNode quatToEuler -n "r_leg_twist_1_02_QTE";
	rename -uid "EF403C8E-4389-D1B8-F03E-008E8026BBF1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_03_SLERP";
	rename -uid "18C35128-4096-2FC0-5F01-83B25E7649A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.2";
createNode quatToEuler -n "r_leg_twist_1_03_QTE";
	rename -uid "101A8C99-4D4B-E7CF-8A27-ABB35179E361";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId" 
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multMatrix -n "spine_drive_MMX";
	rename -uid "FC5CD266-4406-E16A-4868-CEB8D3039699";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoSpaceSwitch";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"spine.ctrl\"],[\"targets\",\"spine.deform\"]]";
createNode animCurveTL -n "C_chest_FK_CTRL_translateY";
	rename -uid "9B50F6B5-44D6-A749-7F10-72A413528C04";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 24 4;
createNode animCurveTU -n "L_hand_IK_CTRL_ikFk";
	rename -uid "18D62886-4E41-3CC0-03C7-6EB9AFB853E6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 1 24 1;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "278C7AA9-425A-221A-DE4C-8991372185B2";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "6A88DBE6-4E30-EC57-EAD5-959D1AF11584";
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
connectAttr "l_arm_space_LOCAL_MMX.o" "L_arm_IK_SPACE.opm";
connectAttr "L_hand_IK_CTRL_ikFk.o" "L_hand_IK_CTRL.ikFk";
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
connectAttr "C_chest_FK_CTRL_translateY.o" "C_chest_FK_CTRL.ty";
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
connectAttr "L_forearm_RESULT_JNT.s" "L_forearm_TWIST_01_JNT.is";
connectAttr "l_arm_twist_1_01_QTE.ort" "L_forearm_TWIST_01_JNT.r";
connectAttr "L_forearm_RESULT_JNT.s" "L_forearm_TWIST_02_JNT.is";
connectAttr "l_arm_twist_1_02_QTE.ort" "L_forearm_TWIST_02_JNT.r";
connectAttr "L_forearm_RESULT_JNT.s" "L_forearm_TWIST_03_JNT.is";
connectAttr "l_arm_twist_1_03_QTE.ort" "L_forearm_TWIST_03_JNT.r";
connectAttr "L_upperArm_RESULT_JNT.s" "L_upperArm_TWIST_01_JNT.is";
connectAttr "l_arm_twist_0_01_QTE.ort" "L_upperArm_TWIST_01_JNT.r";
connectAttr "L_upperArm_RESULT_JNT.s" "L_upperArm_TWIST_02_JNT.is";
connectAttr "l_arm_twist_0_02_QTE.ort" "L_upperArm_TWIST_02_JNT.r";
connectAttr "L_upperArm_RESULT_JNT.s" "L_upperArm_TWIST_03_JNT.is";
connectAttr "l_arm_twist_0_03_QTE.ort" "L_upperArm_TWIST_03_JNT.r";
connectAttr "l_leg_blend_0_LOCAL_MMX.o" "L_thigh_RESULT_JNT.opm";
connectAttr "L_thigh_RESULT_JNT.s" "L_calf_RESULT_JNT.is";
connectAttr "l_leg_blend_1_LOCAL_MMX.o" "L_calf_RESULT_JNT.opm";
connectAttr "L_calf_RESULT_JNT.s" "L_foot_RESULT_JNT.is";
connectAttr "l_leg_blend_2_LOCAL_MMX.o" "L_foot_RESULT_JNT.opm";
connectAttr "L_calf_RESULT_JNT.s" "L_calf_TWIST_01_JNT.is";
connectAttr "l_leg_twist_1_01_QTE.ort" "L_calf_TWIST_01_JNT.r";
connectAttr "L_calf_RESULT_JNT.s" "L_calf_TWIST_02_JNT.is";
connectAttr "l_leg_twist_1_02_QTE.ort" "L_calf_TWIST_02_JNT.r";
connectAttr "L_calf_RESULT_JNT.s" "L_calf_TWIST_03_JNT.is";
connectAttr "l_leg_twist_1_03_QTE.ort" "L_calf_TWIST_03_JNT.r";
connectAttr "L_thigh_RESULT_JNT.s" "L_thigh_TWIST_01_JNT.is";
connectAttr "l_leg_twist_0_01_QTE.ort" "L_thigh_TWIST_01_JNT.r";
connectAttr "L_thigh_RESULT_JNT.s" "L_thigh_TWIST_02_JNT.is";
connectAttr "l_leg_twist_0_02_QTE.ort" "L_thigh_TWIST_02_JNT.r";
connectAttr "L_thigh_RESULT_JNT.s" "L_thigh_TWIST_03_JNT.is";
connectAttr "l_leg_twist_0_03_QTE.ort" "L_thigh_TWIST_03_JNT.r";
connectAttr "r_arm_blend_0_LOCAL_MMX.o" "R_upperArm_RESULT_JNT.opm";
connectAttr "R_upperArm_RESULT_JNT.s" "R_forearm_RESULT_JNT.is";
connectAttr "r_arm_blend_1_LOCAL_MMX.o" "R_forearm_RESULT_JNT.opm";
connectAttr "R_forearm_RESULT_JNT.s" "R_hand_RESULT_JNT.is";
connectAttr "r_arm_blend_2_LOCAL_MMX.o" "R_hand_RESULT_JNT.opm";
connectAttr "R_forearm_RESULT_JNT.s" "R_forearm_TWIST_01_JNT.is";
connectAttr "r_arm_twist_1_01_QTE.ort" "R_forearm_TWIST_01_JNT.r";
connectAttr "R_forearm_RESULT_JNT.s" "R_forearm_TWIST_02_JNT.is";
connectAttr "r_arm_twist_1_02_QTE.ort" "R_forearm_TWIST_02_JNT.r";
connectAttr "R_forearm_RESULT_JNT.s" "R_forearm_TWIST_03_JNT.is";
connectAttr "r_arm_twist_1_03_QTE.ort" "R_forearm_TWIST_03_JNT.r";
connectAttr "R_upperArm_RESULT_JNT.s" "R_upperArm_TWIST_01_JNT.is";
connectAttr "r_arm_twist_0_01_QTE.ort" "R_upperArm_TWIST_01_JNT.r";
connectAttr "R_upperArm_RESULT_JNT.s" "R_upperArm_TWIST_02_JNT.is";
connectAttr "r_arm_twist_0_02_QTE.ort" "R_upperArm_TWIST_02_JNT.r";
connectAttr "R_upperArm_RESULT_JNT.s" "R_upperArm_TWIST_03_JNT.is";
connectAttr "r_arm_twist_0_03_QTE.ort" "R_upperArm_TWIST_03_JNT.r";
connectAttr "r_leg_blend_0_LOCAL_MMX.o" "R_thigh_RESULT_JNT.opm";
connectAttr "R_thigh_RESULT_JNT.s" "R_calf_RESULT_JNT.is";
connectAttr "r_leg_blend_1_LOCAL_MMX.o" "R_calf_RESULT_JNT.opm";
connectAttr "R_calf_RESULT_JNT.s" "R_foot_RESULT_JNT.is";
connectAttr "r_leg_blend_2_LOCAL_MMX.o" "R_foot_RESULT_JNT.opm";
connectAttr "R_calf_RESULT_JNT.s" "R_calf_TWIST_01_JNT.is";
connectAttr "r_leg_twist_1_01_QTE.ort" "R_calf_TWIST_01_JNT.r";
connectAttr "R_calf_RESULT_JNT.s" "R_calf_TWIST_02_JNT.is";
connectAttr "r_leg_twist_1_02_QTE.ort" "R_calf_TWIST_02_JNT.r";
connectAttr "R_calf_RESULT_JNT.s" "R_calf_TWIST_03_JNT.is";
connectAttr "r_leg_twist_1_03_QTE.ort" "R_calf_TWIST_03_JNT.r";
connectAttr "R_thigh_RESULT_JNT.s" "R_thigh_TWIST_01_JNT.is";
connectAttr "r_leg_twist_0_01_QTE.ort" "R_thigh_TWIST_01_JNT.r";
connectAttr "R_thigh_RESULT_JNT.s" "R_thigh_TWIST_02_JNT.is";
connectAttr "r_leg_twist_0_02_QTE.ort" "R_thigh_TWIST_02_JNT.r";
connectAttr "R_thigh_RESULT_JNT.s" "R_thigh_TWIST_03_JNT.is";
connectAttr "r_leg_twist_0_03_QTE.ort" "R_thigh_TWIST_03_JNT.r";
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
connectAttr "L_forearm_RESULT_JNT.wm" "l_arm_twist_0_REL_MMX.i[0]";
connectAttr "L_upperArm_RESULT_JNT.wim" "l_arm_twist_0_REL_MMX.i[1]";
connectAttr "l_arm_twist_0_REL_MMX.o" "l_arm_twist_0_REL_DCM.imat";
connectAttr "l_arm_twist_0_REL_DCM.oqx" "l_arm_twist_0_TWIST_DOT.i1x";
connectAttr "l_arm_twist_0_REL_DCM.oqy" "l_arm_twist_0_TWIST_DOT.i1y";
connectAttr "l_arm_twist_0_REL_DCM.oqz" "l_arm_twist_0_TWIST_DOT.i1z";
connectAttr "l_arm_twist_0_TWIST_DOT.ox" "l_arm_twist_0_TWIST_PROJECT.i2x";
connectAttr "l_arm_twist_0_TWIST_DOT.ox" "l_arm_twist_0_TWIST_PROJECT.i2y";
connectAttr "l_arm_twist_0_TWIST_DOT.ox" "l_arm_twist_0_TWIST_PROJECT.i2z";
connectAttr "l_arm_twist_0_TWIST_PROJECT.ox" "l_arm_twist_0_TWIST_NORM.iqx";
connectAttr "l_arm_twist_0_TWIST_PROJECT.oy" "l_arm_twist_0_TWIST_NORM.iqy";
connectAttr "l_arm_twist_0_TWIST_PROJECT.oz" "l_arm_twist_0_TWIST_NORM.iqz";
connectAttr "l_arm_twist_0_REL_DCM.oqw" "l_arm_twist_0_TWIST_NORM.iqw";
connectAttr "l_arm_twist_0_TWIST_NORM.oq" "l_arm_twist_0_01_SLERP.iq2";
connectAttr "l_arm_twist_0_01_SLERP.oq" "l_arm_twist_0_01_QTE.iq";
connectAttr "l_arm_twist_0_TWIST_NORM.oq" "l_arm_twist_0_02_SLERP.iq2";
connectAttr "l_arm_twist_0_02_SLERP.oq" "l_arm_twist_0_02_QTE.iq";
connectAttr "l_arm_twist_0_TWIST_NORM.oq" "l_arm_twist_0_03_SLERP.iq2";
connectAttr "l_arm_twist_0_03_SLERP.oq" "l_arm_twist_0_03_QTE.iq";
connectAttr "L_hand_RESULT_JNT.wm" "l_arm_twist_1_REL_MMX.i[0]";
connectAttr "L_forearm_RESULT_JNT.wim" "l_arm_twist_1_REL_MMX.i[1]";
connectAttr "l_arm_twist_1_REL_MMX.o" "l_arm_twist_1_REL_DCM.imat";
connectAttr "l_arm_twist_1_REL_DCM.oqx" "l_arm_twist_1_TWIST_DOT.i1x";
connectAttr "l_arm_twist_1_REL_DCM.oqy" "l_arm_twist_1_TWIST_DOT.i1y";
connectAttr "l_arm_twist_1_REL_DCM.oqz" "l_arm_twist_1_TWIST_DOT.i1z";
connectAttr "l_arm_twist_1_TWIST_DOT.ox" "l_arm_twist_1_TWIST_PROJECT.i2x";
connectAttr "l_arm_twist_1_TWIST_DOT.ox" "l_arm_twist_1_TWIST_PROJECT.i2y";
connectAttr "l_arm_twist_1_TWIST_DOT.ox" "l_arm_twist_1_TWIST_PROJECT.i2z";
connectAttr "l_arm_twist_1_TWIST_PROJECT.ox" "l_arm_twist_1_TWIST_NORM.iqx";
connectAttr "l_arm_twist_1_TWIST_PROJECT.oy" "l_arm_twist_1_TWIST_NORM.iqy";
connectAttr "l_arm_twist_1_TWIST_PROJECT.oz" "l_arm_twist_1_TWIST_NORM.iqz";
connectAttr "l_arm_twist_1_REL_DCM.oqw" "l_arm_twist_1_TWIST_NORM.iqw";
connectAttr "l_arm_twist_1_TWIST_NORM.oq" "l_arm_twist_1_01_SLERP.iq2";
connectAttr "l_arm_twist_1_01_SLERP.oq" "l_arm_twist_1_01_QTE.iq";
connectAttr "l_arm_twist_1_TWIST_NORM.oq" "l_arm_twist_1_02_SLERP.iq2";
connectAttr "l_arm_twist_1_02_SLERP.oq" "l_arm_twist_1_02_QTE.iq";
connectAttr "l_arm_twist_1_TWIST_NORM.oq" "l_arm_twist_1_03_SLERP.iq2";
connectAttr "l_arm_twist_1_03_SLERP.oq" "l_arm_twist_1_03_QTE.iq";
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
connectAttr "L_calf_RESULT_JNT.wm" "l_leg_twist_0_REL_MMX.i[0]";
connectAttr "L_thigh_RESULT_JNT.wim" "l_leg_twist_0_REL_MMX.i[1]";
connectAttr "l_leg_twist_0_REL_MMX.o" "l_leg_twist_0_REL_DCM.imat";
connectAttr "l_leg_twist_0_REL_DCM.oqx" "l_leg_twist_0_TWIST_DOT.i1x";
connectAttr "l_leg_twist_0_REL_DCM.oqy" "l_leg_twist_0_TWIST_DOT.i1y";
connectAttr "l_leg_twist_0_REL_DCM.oqz" "l_leg_twist_0_TWIST_DOT.i1z";
connectAttr "l_leg_twist_0_TWIST_DOT.ox" "l_leg_twist_0_TWIST_PROJECT.i2x";
connectAttr "l_leg_twist_0_TWIST_DOT.ox" "l_leg_twist_0_TWIST_PROJECT.i2y";
connectAttr "l_leg_twist_0_TWIST_DOT.ox" "l_leg_twist_0_TWIST_PROJECT.i2z";
connectAttr "l_leg_twist_0_TWIST_PROJECT.ox" "l_leg_twist_0_TWIST_NORM.iqx";
connectAttr "l_leg_twist_0_TWIST_PROJECT.oy" "l_leg_twist_0_TWIST_NORM.iqy";
connectAttr "l_leg_twist_0_TWIST_PROJECT.oz" "l_leg_twist_0_TWIST_NORM.iqz";
connectAttr "l_leg_twist_0_REL_DCM.oqw" "l_leg_twist_0_TWIST_NORM.iqw";
connectAttr "l_leg_twist_0_TWIST_NORM.oq" "l_leg_twist_0_01_SLERP.iq2";
connectAttr "l_leg_twist_0_01_SLERP.oq" "l_leg_twist_0_01_QTE.iq";
connectAttr "l_leg_twist_0_TWIST_NORM.oq" "l_leg_twist_0_02_SLERP.iq2";
connectAttr "l_leg_twist_0_02_SLERP.oq" "l_leg_twist_0_02_QTE.iq";
connectAttr "l_leg_twist_0_TWIST_NORM.oq" "l_leg_twist_0_03_SLERP.iq2";
connectAttr "l_leg_twist_0_03_SLERP.oq" "l_leg_twist_0_03_QTE.iq";
connectAttr "L_foot_RESULT_JNT.wm" "l_leg_twist_1_REL_MMX.i[0]";
connectAttr "L_calf_RESULT_JNT.wim" "l_leg_twist_1_REL_MMX.i[1]";
connectAttr "l_leg_twist_1_REL_MMX.o" "l_leg_twist_1_REL_DCM.imat";
connectAttr "l_leg_twist_1_REL_DCM.oqx" "l_leg_twist_1_TWIST_DOT.i1x";
connectAttr "l_leg_twist_1_REL_DCM.oqy" "l_leg_twist_1_TWIST_DOT.i1y";
connectAttr "l_leg_twist_1_REL_DCM.oqz" "l_leg_twist_1_TWIST_DOT.i1z";
connectAttr "l_leg_twist_1_TWIST_DOT.ox" "l_leg_twist_1_TWIST_PROJECT.i2x";
connectAttr "l_leg_twist_1_TWIST_DOT.ox" "l_leg_twist_1_TWIST_PROJECT.i2y";
connectAttr "l_leg_twist_1_TWIST_DOT.ox" "l_leg_twist_1_TWIST_PROJECT.i2z";
connectAttr "l_leg_twist_1_TWIST_PROJECT.ox" "l_leg_twist_1_TWIST_NORM.iqx";
connectAttr "l_leg_twist_1_TWIST_PROJECT.oy" "l_leg_twist_1_TWIST_NORM.iqy";
connectAttr "l_leg_twist_1_TWIST_PROJECT.oz" "l_leg_twist_1_TWIST_NORM.iqz";
connectAttr "l_leg_twist_1_REL_DCM.oqw" "l_leg_twist_1_TWIST_NORM.iqw";
connectAttr "l_leg_twist_1_TWIST_NORM.oq" "l_leg_twist_1_01_SLERP.iq2";
connectAttr "l_leg_twist_1_01_SLERP.oq" "l_leg_twist_1_01_QTE.iq";
connectAttr "l_leg_twist_1_TWIST_NORM.oq" "l_leg_twist_1_02_SLERP.iq2";
connectAttr "l_leg_twist_1_02_SLERP.oq" "l_leg_twist_1_02_QTE.iq";
connectAttr "l_leg_twist_1_TWIST_NORM.oq" "l_leg_twist_1_03_SLERP.iq2";
connectAttr "l_leg_twist_1_03_SLERP.oq" "l_leg_twist_1_03_QTE.iq";
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
connectAttr "R_forearm_RESULT_JNT.wm" "r_arm_twist_0_REL_MMX.i[0]";
connectAttr "R_upperArm_RESULT_JNT.wim" "r_arm_twist_0_REL_MMX.i[1]";
connectAttr "r_arm_twist_0_REL_MMX.o" "r_arm_twist_0_REL_DCM.imat";
connectAttr "r_arm_twist_0_REL_DCM.oqx" "r_arm_twist_0_TWIST_DOT.i1x";
connectAttr "r_arm_twist_0_REL_DCM.oqy" "r_arm_twist_0_TWIST_DOT.i1y";
connectAttr "r_arm_twist_0_REL_DCM.oqz" "r_arm_twist_0_TWIST_DOT.i1z";
connectAttr "r_arm_twist_0_TWIST_DOT.ox" "r_arm_twist_0_TWIST_PROJECT.i2x";
connectAttr "r_arm_twist_0_TWIST_DOT.ox" "r_arm_twist_0_TWIST_PROJECT.i2y";
connectAttr "r_arm_twist_0_TWIST_DOT.ox" "r_arm_twist_0_TWIST_PROJECT.i2z";
connectAttr "r_arm_twist_0_TWIST_PROJECT.ox" "r_arm_twist_0_TWIST_NORM.iqx";
connectAttr "r_arm_twist_0_TWIST_PROJECT.oy" "r_arm_twist_0_TWIST_NORM.iqy";
connectAttr "r_arm_twist_0_TWIST_PROJECT.oz" "r_arm_twist_0_TWIST_NORM.iqz";
connectAttr "r_arm_twist_0_REL_DCM.oqw" "r_arm_twist_0_TWIST_NORM.iqw";
connectAttr "r_arm_twist_0_TWIST_NORM.oq" "r_arm_twist_0_01_SLERP.iq2";
connectAttr "r_arm_twist_0_01_SLERP.oq" "r_arm_twist_0_01_QTE.iq";
connectAttr "r_arm_twist_0_TWIST_NORM.oq" "r_arm_twist_0_02_SLERP.iq2";
connectAttr "r_arm_twist_0_02_SLERP.oq" "r_arm_twist_0_02_QTE.iq";
connectAttr "r_arm_twist_0_TWIST_NORM.oq" "r_arm_twist_0_03_SLERP.iq2";
connectAttr "r_arm_twist_0_03_SLERP.oq" "r_arm_twist_0_03_QTE.iq";
connectAttr "R_hand_RESULT_JNT.wm" "r_arm_twist_1_REL_MMX.i[0]";
connectAttr "R_forearm_RESULT_JNT.wim" "r_arm_twist_1_REL_MMX.i[1]";
connectAttr "r_arm_twist_1_REL_MMX.o" "r_arm_twist_1_REL_DCM.imat";
connectAttr "r_arm_twist_1_REL_DCM.oqx" "r_arm_twist_1_TWIST_DOT.i1x";
connectAttr "r_arm_twist_1_REL_DCM.oqy" "r_arm_twist_1_TWIST_DOT.i1y";
connectAttr "r_arm_twist_1_REL_DCM.oqz" "r_arm_twist_1_TWIST_DOT.i1z";
connectAttr "r_arm_twist_1_TWIST_DOT.ox" "r_arm_twist_1_TWIST_PROJECT.i2x";
connectAttr "r_arm_twist_1_TWIST_DOT.ox" "r_arm_twist_1_TWIST_PROJECT.i2y";
connectAttr "r_arm_twist_1_TWIST_DOT.ox" "r_arm_twist_1_TWIST_PROJECT.i2z";
connectAttr "r_arm_twist_1_TWIST_PROJECT.ox" "r_arm_twist_1_TWIST_NORM.iqx";
connectAttr "r_arm_twist_1_TWIST_PROJECT.oy" "r_arm_twist_1_TWIST_NORM.iqy";
connectAttr "r_arm_twist_1_TWIST_PROJECT.oz" "r_arm_twist_1_TWIST_NORM.iqz";
connectAttr "r_arm_twist_1_REL_DCM.oqw" "r_arm_twist_1_TWIST_NORM.iqw";
connectAttr "r_arm_twist_1_TWIST_NORM.oq" "r_arm_twist_1_01_SLERP.iq2";
connectAttr "r_arm_twist_1_01_SLERP.oq" "r_arm_twist_1_01_QTE.iq";
connectAttr "r_arm_twist_1_TWIST_NORM.oq" "r_arm_twist_1_02_SLERP.iq2";
connectAttr "r_arm_twist_1_02_SLERP.oq" "r_arm_twist_1_02_QTE.iq";
connectAttr "r_arm_twist_1_TWIST_NORM.oq" "r_arm_twist_1_03_SLERP.iq2";
connectAttr "r_arm_twist_1_03_SLERP.oq" "r_arm_twist_1_03_QTE.iq";
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
connectAttr "R_calf_RESULT_JNT.wm" "r_leg_twist_0_REL_MMX.i[0]";
connectAttr "R_thigh_RESULT_JNT.wim" "r_leg_twist_0_REL_MMX.i[1]";
connectAttr "r_leg_twist_0_REL_MMX.o" "r_leg_twist_0_REL_DCM.imat";
connectAttr "r_leg_twist_0_REL_DCM.oqx" "r_leg_twist_0_TWIST_DOT.i1x";
connectAttr "r_leg_twist_0_REL_DCM.oqy" "r_leg_twist_0_TWIST_DOT.i1y";
connectAttr "r_leg_twist_0_REL_DCM.oqz" "r_leg_twist_0_TWIST_DOT.i1z";
connectAttr "r_leg_twist_0_TWIST_DOT.ox" "r_leg_twist_0_TWIST_PROJECT.i2x";
connectAttr "r_leg_twist_0_TWIST_DOT.ox" "r_leg_twist_0_TWIST_PROJECT.i2y";
connectAttr "r_leg_twist_0_TWIST_DOT.ox" "r_leg_twist_0_TWIST_PROJECT.i2z";
connectAttr "r_leg_twist_0_TWIST_PROJECT.ox" "r_leg_twist_0_TWIST_NORM.iqx";
connectAttr "r_leg_twist_0_TWIST_PROJECT.oy" "r_leg_twist_0_TWIST_NORM.iqy";
connectAttr "r_leg_twist_0_TWIST_PROJECT.oz" "r_leg_twist_0_TWIST_NORM.iqz";
connectAttr "r_leg_twist_0_REL_DCM.oqw" "r_leg_twist_0_TWIST_NORM.iqw";
connectAttr "r_leg_twist_0_TWIST_NORM.oq" "r_leg_twist_0_01_SLERP.iq2";
connectAttr "r_leg_twist_0_01_SLERP.oq" "r_leg_twist_0_01_QTE.iq";
connectAttr "r_leg_twist_0_TWIST_NORM.oq" "r_leg_twist_0_02_SLERP.iq2";
connectAttr "r_leg_twist_0_02_SLERP.oq" "r_leg_twist_0_02_QTE.iq";
connectAttr "r_leg_twist_0_TWIST_NORM.oq" "r_leg_twist_0_03_SLERP.iq2";
connectAttr "r_leg_twist_0_03_SLERP.oq" "r_leg_twist_0_03_QTE.iq";
connectAttr "R_foot_RESULT_JNT.wm" "r_leg_twist_1_REL_MMX.i[0]";
connectAttr "R_calf_RESULT_JNT.wim" "r_leg_twist_1_REL_MMX.i[1]";
connectAttr "r_leg_twist_1_REL_MMX.o" "r_leg_twist_1_REL_DCM.imat";
connectAttr "r_leg_twist_1_REL_DCM.oqx" "r_leg_twist_1_TWIST_DOT.i1x";
connectAttr "r_leg_twist_1_REL_DCM.oqy" "r_leg_twist_1_TWIST_DOT.i1y";
connectAttr "r_leg_twist_1_REL_DCM.oqz" "r_leg_twist_1_TWIST_DOT.i1z";
connectAttr "r_leg_twist_1_TWIST_DOT.ox" "r_leg_twist_1_TWIST_PROJECT.i2x";
connectAttr "r_leg_twist_1_TWIST_DOT.ox" "r_leg_twist_1_TWIST_PROJECT.i2y";
connectAttr "r_leg_twist_1_TWIST_DOT.ox" "r_leg_twist_1_TWIST_PROJECT.i2z";
connectAttr "r_leg_twist_1_TWIST_PROJECT.ox" "r_leg_twist_1_TWIST_NORM.iqx";
connectAttr "r_leg_twist_1_TWIST_PROJECT.oy" "r_leg_twist_1_TWIST_NORM.iqy";
connectAttr "r_leg_twist_1_TWIST_PROJECT.oz" "r_leg_twist_1_TWIST_NORM.iqz";
connectAttr "r_leg_twist_1_REL_DCM.oqw" "r_leg_twist_1_TWIST_NORM.iqw";
connectAttr "r_leg_twist_1_TWIST_NORM.oq" "r_leg_twist_1_01_SLERP.iq2";
connectAttr "r_leg_twist_1_01_SLERP.oq" "r_leg_twist_1_01_QTE.iq";
connectAttr "r_leg_twist_1_TWIST_NORM.oq" "r_leg_twist_1_02_SLERP.iq2";
connectAttr "r_leg_twist_1_02_SLERP.oq" "r_leg_twist_1_02_QTE.iq";
connectAttr "r_leg_twist_1_TWIST_NORM.oq" "r_leg_twist_1_03_SLERP.iq2";
connectAttr "r_leg_twist_1_03_SLERP.oq" "r_leg_twist_1_03_QTE.iq";
connectAttr "C_chest_FK_CTRL.wm" "spine_drive_MMX.i[0]";
connectAttr "MC_DEFORM.wim" "spine_drive_MMX.i[1]";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "ikRPsolver.msg" ":ikSystem.sol" -na;
// End of mayacraft_space_switch.ma
