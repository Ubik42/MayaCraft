//Maya ASCII 2025ff03 scene
//Name: mayacraft_match_success.ma
//Last modified: Sun, Aug 30, 2026 07:20:36 PM
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
fileInfo "UUID" "7CC81172-4CCF-138B-3135-3390E01B78EE";
createNode transform -s -n "persp";
	rename -uid "F2F80D80-40AB-61F3-E51A-8086BFC8BD1C";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "D6651405-4B64-1EF8-6A1E-948B46239258";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "A0B34348-4B3B-28B0-6A32-ACA7C3894554";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "C8B562FB-4C64-5B2E-0825-3BB6150C1BFB";
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
	rename -uid "63A32829-48DF-CB26-D3D9-D3B87929A382";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "1C44D576-4669-B5FF-CA89-E38AF0589AFA";
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
	rename -uid "4EEB2BC7-45F0-6584-A6B0-AD8731B01B54";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "BB656B9C-459E-5C38-9AB6-E68B78FA5BCE";
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
	rename -uid "D3A5DD90-48FE-C0FC-8208-FD94FF9906BA";
	addAttr -ci true -sn "mayacraftDemoScenario" -ln "mayacraftDemoScenario" -dt "string";
	addAttr -ci true -sn "mayacraftExpectedResult" -ln "mayacraftExpectedResult" -dt "string";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".mayacraftDemoScenario" -type "string" "FK_TO_IK_SUCCESS";
	setAttr ".mayacraftExpectedResult" -type "string" "�� 12 ֡Ԥ�� FK��IK ��Ӧ�ã�����Ǽ������䲢���ɹؼ�֡";
createNode joint -n "pelvis_JNT" -p "root_JNT";
	rename -uid "30751634-4085-3B84-EFAF-FB86EDC834C7";
	setAttr ".t" -type "double3" 0 10 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "spine_JNT" -p "pelvis_JNT";
	rename -uid "90C1C9FD-44D6-607B-5067-06A4B0689C8B";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "chest_JNT" -p "spine_JNT";
	rename -uid "7A32FE76-4E9A-7D30-9FBB-60BE09E4EDFD";
	setAttr ".t" -type "double3" 0 4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "neck_JNT" -p "chest_JNT";
	rename -uid "58C10E8F-4F06-0754-0341-C7B7A5FF5070";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "head_JNT" -p "neck_JNT";
	rename -uid "B0AFA78A-4311-8472-CEBB-F78EEAF02C5F";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_upperArm_JNT" -p "chest_JNT";
	rename -uid "ED7B4471-4CDB-1076-0771-35843C8BC729";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_forearm_JNT" -p "L_upperArm_JNT";
	rename -uid "D27629F7-4B15-7DF0-1880-6EA54FEA05BF";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_hand_JNT" -p "L_forearm_JNT";
	rename -uid "F7ACB861-4078-EED5-83A5-8FBBFE51531A";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_upperArm_JNT" -p "chest_JNT";
	rename -uid "1EA91A60-4F26-4964-3F43-ABAA087C658D";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_forearm_JNT" -p "R_upperArm_JNT";
	rename -uid "1A954E09-4039-1ABC-B845-94B10A62ADC3";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_hand_JNT" -p "R_forearm_JNT";
	rename -uid "00F83DD9-41F8-436C-5FE9-13AB528FE315";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_thigh_JNT" -p "pelvis_JNT";
	rename -uid "EF3F4C49-4226-1D3F-E1C2-0493BFB7D625";
	setAttr ".t" -type "double3" 3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_calf_JNT" -p "L_thigh_JNT";
	rename -uid "F58D7FBB-4B75-2431-DAD0-378AD32005C1";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_foot_JNT" -p "L_calf_JNT";
	rename -uid "0B3CA673-48BF-DD71-52BA-668C73FDDCAD";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_thigh_JNT" -p "pelvis_JNT";
	rename -uid "B549CA6C-470B-01FF-7C30-399ED8944D2F";
	setAttr ".t" -type "double3" -3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_calf_JNT" -p "R_thigh_JNT";
	rename -uid "0BC0D2E4-4D99-D626-A411-D0AA47B949D1";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_foot_JNT" -p "R_calf_JNT";
	rename -uid "9D1114A2-4064-5529-E4B1-6DB3E713AAB7";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode transform -n "MC_RIG";
	rename -uid "9B4726A1-4339-3528-490B-CCBE0A79AAD8";
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
	rename -uid "AEA1FB6A-439A-D52B-3F94-1CBD96DF6763";
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
	rename -uid "F16AC672-4B29-97BF-754F-08B94F8E2496";
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
createNode transform -n "L_upperArm_BENDY_IN_CTRL" -p "L_arm_MOD";
	rename -uid "826B3D89-4B6C-EBCC-F4E0-96B5B35D351B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 5.32 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_IN_CTRLShape" -p "L_upperArm_BENDY_IN_CTRL";
	rename -uid "C502C36E-442B-055F-9C97-CB955E55CC2C";
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
createNode transform -n "L_upperArm_BENDY_OUT_CTRL" -p "L_arm_MOD";
	rename -uid "E4365098-44FC-590A-A0DC-AA8ECA373878";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 6.68 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_OUT_CTRLShape" -p "L_upperArm_BENDY_OUT_CTRL";
	rename -uid "0D7F14EF-41DC-9A76-9C92-18909F41DD0A";
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
createNode transform -n "L_forearm_BENDY_IN_CTRL" -p "L_arm_MOD";
	rename -uid "AFE0B1EB-46A0-E2BE-565A-AB8C72B14531";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 8.99 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_IN_CTRLShape" -p "L_forearm_BENDY_IN_CTRL";
	rename -uid "4FB4A8A8-4135-C27F-CA5A-DEA7E3C37287";
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
createNode transform -n "L_forearm_BENDY_OUT_CTRL" -p "L_arm_MOD";
	rename -uid "FB8618B7-4CE9-C33D-8553-1694C3818E39";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 10.01 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_OUT_CTRLShape" -p "L_forearm_BENDY_OUT_CTRL";
	rename -uid "209E4FB1-4FEC-DBEE-2868-ACACD83C6219";
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
createNode transform -n "L_upperArm_FK_CTRL" -p "L_arm_MOD";
	rename -uid "29330C07-4271-AC38-0F71-6CB2B503527F";
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
	rename -uid "8A6B46C0-4910-4EA1-E3EB-0C9393340F5B";
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
	rename -uid "E3CE7F9D-4C0C-4461-7CA9-2F9E4B4E2613";
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
	rename -uid "A8F4C4B4-48C2-F502-77C5-15A0E3463D60";
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
	rename -uid "7767C896-4D35-24DA-85D7-96AB82067C9C";
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
	rename -uid "5827F7BD-4A21-B31E-94A4-7D8148F290E6";
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
	rename -uid "ADB923BA-4468-512F-3FFE-2D8B193A830E";
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
	rename -uid "07FCF2B6-4746-DE1D-7BB6-8AB5D1276D4E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "ȫ��:�ؿ�" -at "enum";
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
	rename -uid "C44CA8A2-4236-85D7-BE8F-518747EF55A6";
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
	rename -uid "009C22E9-4FA2-A09C-D5B2-BEAF60202A82";
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
	rename -uid "72EE1C4D-484D-B0BB-5EC0-28B37BC48855";
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
	rename -uid "B8EC2D58-4C47-07DF-EB3B-8FA197EE98AE";
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
	rename -uid "D84F6BB7-49A1-C5BF-64B0-7F8D33D52725";
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
	rename -uid "B4AF6BBD-42F8-F329-B8A1-53AFB222B2E3";
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
createNode transform -n "L_thigh_BENDY_IN_CTRL" -p "L_leg_MOD";
	rename -uid "B59A8007-44C0-487C-1FFB-21A1E28251E6";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 7.68 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_IN_CTRLShape" -p "L_thigh_BENDY_IN_CTRL";
	rename -uid "FDBA5F9E-49D5-09EE-3849-C1B877402EC7";
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
createNode transform -n "L_thigh_BENDY_OUT_CTRL" -p "L_leg_MOD";
	rename -uid "D6900DAB-4BF0-9C1C-BA28-E4ADDC3C1366";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 6.32 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_OUT_CTRLShape" -p "L_thigh_BENDY_OUT_CTRL";
	rename -uid "7BFAA927-4525-0504-0C55-0FA1DED8CC15";
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
createNode transform -n "L_calf_BENDY_IN_CTRL" -p "L_leg_MOD";
	rename -uid "B51313AA-4FAA-CBF3-8EC7-72B17A89AFFF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 3.68 0.33 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_IN_CTRLShape" -p "L_calf_BENDY_IN_CTRL";
	rename -uid "28325A78-4C9B-6DF4-1ABE-31844CFBBFD2";
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
createNode transform -n "L_calf_BENDY_OUT_CTRL" -p "L_leg_MOD";
	rename -uid "C5AF62FC-4A21-0090-DE90-02AECC501121";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" 3 2.32 0.67 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_OUT_CTRLShape" -p "L_calf_BENDY_OUT_CTRL";
	rename -uid "CE2A3D29-4291-A39F-07C2-1393277A557C";
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
createNode transform -n "L_thigh_FK_CTRL" -p "L_leg_MOD";
	rename -uid "972680BF-4C9B-82FB-6E70-4C8A2B78A2A9";
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
	rename -uid "D9570E78-4BAD-5DC2-BCF8-41963F315ED5";
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
	rename -uid "4F228C7E-4814-AFCF-51AC-A09319F805A5";
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
	rename -uid "8A2B5967-4BCB-CD40-B921-E5AD77AB7403";
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
	rename -uid "3B5F61A3-429B-EE17-3AC3-DCA159AEAE66";
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
	rename -uid "EFBB1C3A-4B6C-0F06-9247-32BC6C7A0CFB";
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
	rename -uid "80B267B6-4BEC-5320-A6A7-ACA892FFE144";
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
	rename -uid "592A564F-4B7B-9BF0-BF61-5EA21B266B3D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "ȫ��:�ؿ�" -at "enum";
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
	rename -uid "09CA2306-41A6-677A-47D8-928533801949";
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
	rename -uid "3144EE1C-4F9C-1381-BD31-42B8FFAA9ED5";
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
	rename -uid "D67EFC30-481A-925F-EE11-85A4B02B4CD5";
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
	rename -uid "35BC1F18-4272-0488-14A5-709877873103";
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
	rename -uid "58D84901-49F3-AE9F-946C-299EF6FC0A35";
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
	rename -uid "61BC5800-42F8-6907-7DC6-51ADA2A01253";
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
createNode transform -n "R_upperArm_BENDY_IN_CTRL" -p "R_arm_MOD";
	rename -uid "1D5CBBEB-4565-1721-D321-15A200A205CB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -5.32 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_IN_CTRLShape" -p "R_upperArm_BENDY_IN_CTRL";
	rename -uid "4406B6CB-4E25-D4CC-DCD7-B69934CF1C21";
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
createNode transform -n "R_upperArm_BENDY_OUT_CTRL" -p "R_arm_MOD";
	rename -uid "02F0E69A-40C5-1BFC-2437-95BDD4A82BC0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -6.68 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_OUT_CTRLShape" -p "R_upperArm_BENDY_OUT_CTRL";
	rename -uid "03C12774-4EFE-AC07-7856-599620DFA992";
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
createNode transform -n "R_forearm_BENDY_IN_CTRL" -p "R_arm_MOD";
	rename -uid "9CE419E2-4E5B-923C-FF09-E09AA2FC96C2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -8.99 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_IN_CTRLShape" -p "R_forearm_BENDY_IN_CTRL";
	rename -uid "82915FD2-461D-C7AB-465F-CD9691FF0FF8";
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
createNode transform -n "R_forearm_BENDY_OUT_CTRL" -p "R_arm_MOD";
	rename -uid "A7E173CB-4855-0CC1-7FA9-5DB3CC024D7C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -10.01 17 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_OUT_CTRLShape" -p "R_forearm_BENDY_OUT_CTRL";
	rename -uid "66ACAEEE-47F4-C378-B35F-E4AEB22402EB";
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
createNode transform -n "R_upperArm_FK_CTRL" -p "R_arm_MOD";
	rename -uid "7374E070-4E12-BB63-099C-B2996582EEA7";
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
	rename -uid "63C4219A-4E70-69DD-A293-E7932279741C";
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
	rename -uid "E7EEF15A-4DE9-3CCB-2722-EDA56EACB66F";
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
	rename -uid "1528204B-456C-8BAD-27D9-339D1F94B6E6";
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
	rename -uid "3E7D042E-45DF-1B92-EC5F-EB9EAFF9C288";
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
	rename -uid "62D7749B-4D37-69E4-5E1E-F18C4B040277";
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
	rename -uid "F6736301-4A6E-6D3C-44AE-1DAC29FDC665";
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
	rename -uid "ABB2E0EB-4227-47B1-0ABD-629A5657C1A2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "ȫ��:�ؿ�" -at "enum";
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
	rename -uid "24C8BF5C-4568-8BE6-3889-CA889E2CFFF0";
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
	rename -uid "F8638D48-4923-197E-FF6C-9883B80353C7";
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
	rename -uid "B214497D-44F2-0B14-B3F7-8A9AA0505028";
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
	rename -uid "DE8429CF-402B-00FC-CF3F-879DF5BAAAF4";
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
	rename -uid "41E70AB4-4497-8A57-177B-D4A181A545B7";
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
	rename -uid "C1511B6A-4308-361D-77AD-EEB2B072971B";
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
createNode transform -n "R_thigh_BENDY_IN_CTRL" -p "R_leg_MOD";
	rename -uid "459D2E2E-4224-F600-7BEA-FF8FA681DB48";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 7.68 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_IN_CTRLShape" -p "R_thigh_BENDY_IN_CTRL";
	rename -uid "6DBA4D1F-4DD8-7D05-579A-4C996028C15B";
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
createNode transform -n "R_thigh_BENDY_OUT_CTRL" -p "R_leg_MOD";
	rename -uid "DEFCEC42-4202-A9F0-4E94-39BC4C26358C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 6.32 0 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_OUT_CTRLShape" -p "R_thigh_BENDY_OUT_CTRL";
	rename -uid "A4789CCC-4D84-D620-E63C-FCAAB1D50C28";
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
createNode transform -n "R_calf_BENDY_IN_CTRL" -p "R_leg_MOD";
	rename -uid "CE42C2BC-43D7-A502-A28E-4385788F06D0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "volume" -ln "volume" -dv 0.65 -min 0 -max 1 -at "double";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 3.68 0.33 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.in";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_IN_CTRLShape" -p "R_calf_BENDY_IN_CTRL";
	rename -uid "6C366238-42FF-66E5-C216-6680F928CEEC";
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
createNode transform -n "R_calf_BENDY_OUT_CTRL" -p "R_leg_MOD";
	rename -uid "9F96AA18-47E9-B55C-6B93-7EB2C123A7CC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".t" -type "double3" -3 2.32 0.67 ;
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.out";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_OUT_CTRLShape" -p "R_calf_BENDY_OUT_CTRL";
	rename -uid "45AABA5C-4644-32B2-C4B8-04BBD9FB3475";
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
createNode transform -n "R_thigh_FK_CTRL" -p "R_leg_MOD";
	rename -uid "87E93B54-48E6-9974-5E76-AAA2ADDB8D44";
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
	rename -uid "05B11EEA-4FB2-0692-4D6C-FAA213BEBED5";
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
	rename -uid "936B390D-407C-7906-85A2-00A5D64ED13C";
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
	rename -uid "14CAB8B9-4E4C-A14D-74B2-6286F8FF080C";
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
	rename -uid "9E64D551-4E47-4CA7-BA74-779A6AEBB79E";
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
	rename -uid "4BED2B76-498E-15DF-A1F3-7D817CDF7857";
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
	rename -uid "C5295251-4331-F304-D98A-98BD87CFE5A0";
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
	rename -uid "662222D3-43E5-77E3-0837-E2BF2983AA34";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -k true -sn "ikFk" -ln "ikFk" -min 0 -max 1 -at "double";
	addAttr -ci true -k true -sn "twist" -ln "twist" -min -180 -max 180 -at "double";
	addAttr -ci true -k true -sn "space" -ln "space" -min 0 -max 1 -en "ȫ��:�ؿ�" -at "enum";
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
	rename -uid "CC0F4C0B-4FEA-5E7D-0F3D-518D6F693585";
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
	rename -uid "2BBD814B-4B40-1B1D-733C-549F6B48051B";
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
	rename -uid "07F84623-438A-609E-2EAB-C7863DE10B43";
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
	rename -uid "E5EE7BAE-48D3-54C3-8089-0EBD85617CF6";
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
	rename -uid "0044580A-41E1-7526-9338-6E84F493BAE2";
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
	rename -uid "6D4A998D-412F-A4DC-9249-3F95834A9E54";
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
	rename -uid "38F21CA4-4BF1-1BAD-449A-BCB7848E5B0A";
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
	rename -uid "4B03D477-4189-E8B9-F972-C4B1FA36FE3B";
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
	rename -uid "15C61009-4C74-0FD8-DD5A-848BBFCBB5EE";
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
	rename -uid "E3DE2138-437B-0A5F-DDB5-23B15D9B6C52";
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
	rename -uid "B3818BAC-43ED-90A9-7A9C-CAAAEB194EC5";
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
	rename -uid "AB89A31A-43DA-EEA9-979E-E89DA6B8972A";
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
	rename -uid "5D1263B1-460B-1205-AD09-2683A28564E3";
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
	rename -uid "2B40DD7D-4A03-2858-E229-E686AB6C0F2E";
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
	rename -uid "6DCE42CA-4C3D-11CE-9408-529BFD2AF92B";
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
	rename -uid "C8DF78B2-42F8-5F32-39F0-2DB67903E222";
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
	rename -uid "0AF55BD9-442F-5EA5-0164-23A1EC32960E";
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
	rename -uid "F12AEC50-4D0C-7CB4-560C-C1BB2F9DAE7B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode joint -n "L_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "3B7CF2C9-40F0-8D9F-B7DF-0280B3941801";
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
	rename -uid "79CDDC2F-4884-19C3-99F3-F89C5BAFF478";
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
	rename -uid "48AEB130-4DDE-562E-5D2F-6A94037396D0";
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
	rename -uid "FF4779DB-4898-D600-863F-8AA7B81DD705";
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
	rename -uid "D8A7CA74-4E76-811D-6885-AB83AEDF7E20";
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
	rename -uid "E8639185-4E01-A034-BB7B-7B9AD917E59A";
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
	rename -uid "AB1EBBED-426C-F67F-36CF-7FBFB131CBEF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode joint -n "R_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "8839F5E7-4405-C669-4EE8-369FB7E8C283";
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
	rename -uid "36E347BD-4C9C-5F66-EF76-25B18AA59099";
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
	rename -uid "28604569-43FE-C037-FCE3-F3973B85EAB8";
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
	rename -uid "12D2801A-4FF6-2E23-7B93-E0B2F2C760C1";
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
	rename -uid "3D7D167C-4FFE-3BBA-69B0-5BB73F533682";
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
	rename -uid "9F59D5DC-4761-9AD3-C0AE-97961B9A80D3";
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
	rename -uid "BC34AFD7-49EB-40A7-C193-00A8BD7914A6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode joint -n "R_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "F7B9026A-4D87-6715-31D4-B7AD2DB3475D";
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
	rename -uid "D2B24DB7-4BD9-C2F9-4516-24AEE7AD318B";
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
	rename -uid "C9A2FBF7-4BEF-4990-2DAB-CDACC14ADCD0";
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
	rename -uid "E44107BE-4F5B-2244-17C7-1EA86046C74D";
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
	rename -uid "45ED7D5D-408B-9B5E-3285-1A81F334F500";
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
	rename -uid "A520EA94-4D2D-F847-C4EB-91A39D2C245F";
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
	rename -uid "DEBCFD9C-4A86-1D28-6AFB-808B0F96FB57";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode joint -n "C_chest_DRV_JNT" -p "MC_DEFORM";
	rename -uid "9203B8C0-4A40-873B-C82A-83A601C7F0DF";
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
	rename -uid "AD7C6795-441F-B170-9C9A-088DEEA1E790";
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
createNode transform -n "l_arm_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "BD332568-4AEE-61AA-EC9F-02A4370E4225";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.bendy.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.bendy.0.in|l_arm.bendy.0.out|l_arm.deform.1\"],[\"targets\",\"l_arm.bendy.0.0|l_arm.bendy.0.1|l_arm.bendy.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape1" -p "l_arm_bendy_0_CRV";
	rename -uid "4024F1A2-4E37-0667-264C-A99161160074";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		4 17 0
		5.3200000000000003 17 0
		6.6799999999999997 17 0
		8 17 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode transform -n "l_arm_bendy_1_CRV" -p "MC_DEFORM";
	rename -uid "3E6EBC8B-4E16-6462-F8BE-74B5470D5C8B";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_arm.bendy.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.bendy.1.in|l_arm.bendy.1.out|l_arm.deform.2\"],[\"targets\",\"l_arm.bendy.1.0|l_arm.bendy.1.1|l_arm.bendy.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape2" -p "l_arm_bendy_1_CRV";
	rename -uid "D020DEAD-49A5-58AB-1782-189AE410B389";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		8 17 0
		8.9900000000000002 17 0
		10.01 17 0
		11 17 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode transform -n "l_leg_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "DA0A2142-4FCA-E21D-B3E9-418F3F58E8DD";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.bendy.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.bendy.0.in|l_leg.bendy.0.out|l_leg.deform.1\"],[\"targets\",\"l_leg.bendy.0.0|l_leg.bendy.0.1|l_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape3" -p "l_leg_bendy_0_CRV";
	rename -uid "9BE0F28E-4DB4-85D2-D1E8-1A860E2E0038";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		3 9 0
		3 7.6799999999999997 0
		3 6.3200000000000003 0
		3 5 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode transform -n "l_leg_bendy_1_CRV" -p "MC_DEFORM";
	rename -uid "62A0D46C-4373-181B-46D7-6088BF30C668";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "l_leg.bendy.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.bendy.1.in|l_leg.bendy.1.out|l_leg.deform.2\"],[\"targets\",\"l_leg.bendy.1.0|l_leg.bendy.1.1|l_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape4" -p "l_leg_bendy_1_CRV";
	rename -uid "2578BCFE-4F8E-77F4-6FA8-89BAC49C7845";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		3 5 0
		3 3.6800000000000002 0.33000000000000002
		3 2.3199999999999998 0.67000000000000004
		3 1 1
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode transform -n "r_arm_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "D7B71246-431D-DEDE-F724-C8808C957182";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.bendy.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.bendy.0.in|r_arm.bendy.0.out|r_arm.deform.1\"],[\"targets\",\"r_arm.bendy.0.0|r_arm.bendy.0.1|r_arm.bendy.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape5" -p "r_arm_bendy_0_CRV";
	rename -uid "1ACB447B-4FF5-6FE5-F134-F0B476CB813E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		-4 17 0
		-5.3200000000000003 17 0
		-6.6799999999999997 17 0
		-8 17 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode transform -n "r_arm_bendy_1_CRV" -p "MC_DEFORM";
	rename -uid "F04B68BE-43E1-616C-0126-F286ED282010";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_arm.bendy.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.bendy.1.in|r_arm.bendy.1.out|r_arm.deform.2\"],[\"targets\",\"r_arm.bendy.1.0|r_arm.bendy.1.1|r_arm.bendy.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape6" -p "r_arm_bendy_1_CRV";
	rename -uid "0092D072-4A43-492F-8D5D-FD878E83F107";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		-8 17 0
		-8.9900000000000002 17 0
		-10.01 17 0
		-11 17 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode transform -n "r_leg_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "D9612260-49D9-C657-15CC-65816FD6566C";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.bendy.0";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.bendy.0.in|r_leg.bendy.0.out|r_leg.deform.1\"],[\"targets\",\"r_leg.bendy.0.0|r_leg.bendy.0.1|r_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape7" -p "r_leg_bendy_0_CRV";
	rename -uid "72E2AB9F-4091-E109-71C9-0BA22082722D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		-3 9 0
		-3 7.6799999999999997 0
		-3 6.3200000000000003 0
		-3 5 0
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode transform -n "r_leg_bendy_1_CRV" -p "MC_DEFORM";
	rename -uid "7AFFF358-4141-3955-AA77-FA8090991F4E";
	addAttr -ci true -sn "mayacraftRigBehavior" -ln "mayacraftRigBehavior" -min 0 -max
		1 -at "bool";
	addAttr -ci true -sn "mayacraftRigBehaviorId" -ln "mayacraftRigBehaviorId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorType" -ln "mayacraftRigBehaviorType" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigBehaviorSignature" -ln "mayacraftRigBehaviorSignature"
		-dt "string";
	setAttr ".mayacraftRigBehavior" yes;
	setAttr ".mayacraftRigBehaviorId" -type "string" "r_leg.bendy.1";
	setAttr ".mayacraftRigBehaviorType" -type "string" "bendy_curve";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.bendy.1.in|r_leg.bendy.1.out|r_leg.deform.2\"],[\"targets\",\"r_leg.bendy.1.0|r_leg.bendy.1.1|r_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape8" -p "r_leg_bendy_1_CRV";
	rename -uid "F9844CCB-4AA3-3D28-6C0F-259F5D515628";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 21;
	setAttr -s 4 ".cp";
	setAttr ".cc" -type "nurbsCurve"
		3 1 0 no 3
		6 0 0 0 1 1 1
		4
		-3 5 0
		-3 3.6800000000000002 0.33000000000000002
		-3 2.3199999999999998 0.67000000000000004
		-3 1 1
		;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode transform -n "MC_DELIVERY" -p "MC_RIG";
	rename -uid "0A1B2488-43F1-837F-6D61-B79AAB73A1D0";
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
createNode joint -n "L_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "13B77590-46DC-9D15-3143-5E9A139839FB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_01_JNT" -p "L_upperArm_BENDY_01_JNT";
	rename -uid "63B10556-4300-7C87-E14B-438C42C00FAD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "6394919B-4BA1-6E68-1413-ECBAE87E7F6D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_02_JNT" -p "L_upperArm_BENDY_02_JNT";
	rename -uid "367A36F7-4F3D-7BAB-E005-F3BDDFEBECBD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "4DACA61E-426B-621E-062D-5AAA701C1EAA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_03_JNT" -p "L_upperArm_BENDY_03_JNT";
	rename -uid "D33A9D97-485C-CC98-2A5A-04ADC4489D5D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "F89EB3AF-4032-3B14-BEA6-08ABA3811437";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_01_JNT" -p "L_forearm_BENDY_01_JNT";
	rename -uid "FE0BC60A-4655-614A-B030-2C9F9FD8797A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "A08176C4-4100-F3EC-2460-4B9DCBB6C9D1";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_02_JNT" -p "L_forearm_BENDY_02_JNT";
	rename -uid "616BDAAA-44B0-7611-97F0-E6AE1B604A4B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "20B037FA-4719-A791-9C10-678F8A0B3AFC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_03_JNT" -p "L_forearm_BENDY_03_JNT";
	rename -uid "EC6C8212-4265-A552-C077-8990216677A3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "D3283348-4FB8-8725-42DA-FFA925065D8A";
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
	rename -uid "E1D385E9-4C48-1B74-0184-EAB0B45783A2";
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
	rename -uid "83E53924-4387-8045-8AED-3BB7109DBFF1";
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
createNode joint -n "L_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "2BC5AEB5-4371-486C-24D4-E990025F387B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_01_JNT" -p "L_thigh_BENDY_01_JNT";
	rename -uid "24B66085-4DC3-42BA-2EC9-95850341CA90";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "1F463CE9-4BF5-A3EF-36E4-4CBCEBEFADE2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_02_JNT" -p "L_thigh_BENDY_02_JNT";
	rename -uid "EA7D97F5-4AB5-032E-83EE-9AA19791A063";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "EBDFF680-4EFA-93D4-668B-3AA50F264E26";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_03_JNT" -p "L_thigh_BENDY_03_JNT";
	rename -uid "6C71A7D8-49A5-49F9-6B47-C5A8FA01A367";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "06217E83-4866-1735-B1B0-91B297BB3B0C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_01_JNT" -p "L_calf_BENDY_01_JNT";
	rename -uid "37FB25CB-4FF7-D0EB-F158-4F8AB057899D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "A396E7D2-455A-242A-9F90-D08464B2E075";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_02_JNT" -p "L_calf_BENDY_02_JNT";
	rename -uid "93EF7AD0-494B-C8CC-FF93-9B8261AF1340";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "E8FCCCC9-4784-2CB3-3817-73AB11634050";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_03_JNT" -p "L_calf_BENDY_03_JNT";
	rename -uid "8CB119FB-4EA0-5B3A-3049-2292D083948E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "945A4778-4F67-F26B-D4C2-05A012545061";
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
	rename -uid "32693CAF-4623-EAF4-D0D4-9A9764A1C0AA";
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
	rename -uid "61A18807-48BE-D754-C7EC-FA958E315824";
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
createNode joint -n "R_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "13EAD67F-4C9F-97B9-69B7-E9804EA66FC8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_01_JNT" -p "R_upperArm_BENDY_01_JNT";
	rename -uid "76D41248-4970-DB03-91CD-5FB52B590D6B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "760E6A41-499C-E4FC-75D4-29BE1BD33DED";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_02_JNT" -p "R_upperArm_BENDY_02_JNT";
	rename -uid "568D6586-493B-B592-4430-34A2E67447C6";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "C7381E3B-45F4-376A-DF0E-8783D1708501";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_03_JNT" -p "R_upperArm_BENDY_03_JNT";
	rename -uid "278B9857-4576-E78E-C504-F98E657CF8F6";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "10786005-40C6-28F5-2487-83813079D9C2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_01_JNT" -p "R_forearm_BENDY_01_JNT";
	rename -uid "CBF58DE6-4CED-EFEB-56A0-EA87ABB76C6C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "4E828C5D-415D-6AF5-8A16-5F88A0DB4866";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_02_JNT" -p "R_forearm_BENDY_02_JNT";
	rename -uid "765ECD8C-41D1-1A0F-82FB-4F806E781DEE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "529CB623-431C-11FC-2725-79A77F3E29A0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_03_JNT" -p "R_forearm_BENDY_03_JNT";
	rename -uid "DAD34FF4-4EB8-4041-442B-CD9DE4114AAC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "FE698AFB-48AF-51AF-2CA9-7EB3095418F3";
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
	rename -uid "22A086F1-41B2-7F4E-E109-F49C091B39CE";
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
	rename -uid "8CD12873-485E-DA3A-AFBB-F18DC15645CC";
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
createNode joint -n "R_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "CF274BD9-4B4D-122C-5678-A39649539E9E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_01_JNT" -p "R_thigh_BENDY_01_JNT";
	rename -uid "9B785163-47C4-75F4-4187-09BF79096D86";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "1854AFC4-4A88-622F-A2C6-7F82D4FB190D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_02_JNT" -p "R_thigh_BENDY_02_JNT";
	rename -uid "11D3C46E-4298-507E-1515-4D9F9B5D15EF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "60A48204-44FB-F365-2700-D89370886F1D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_03_JNT" -p "R_thigh_BENDY_03_JNT";
	rename -uid "E97BE8FA-44EF-5E65-E6E2-41B1A6A76A81";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "8FAA5159-427C-C243-CE78-76BECCA11D79";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_01_JNT" -p "R_calf_BENDY_01_JNT";
	rename -uid "2C6D7D3E-4C60-952B-154D-23A83E5B2677";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "F4E0737A-40D8-3238-7E26-5390142187FE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_02_JNT" -p "R_calf_BENDY_02_JNT";
	rename -uid "008E806E-4844-B66F-08BA-E5BCECED2442";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "03C0B286-48A3-C3E0-B134-CE89C51893DA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_03_JNT" -p "R_calf_BENDY_03_JNT";
	rename -uid "D03C58DB-48C1-EBA4-E0B9-8F9D772E34A0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "A01219C0-48F7-60FD-6438-41AAB2FAD09F";
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
	rename -uid "FBC0D510-4666-0EC6-7F9B-909AC6205FED";
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
	rename -uid "D438E078-4922-0673-4D9D-76B579DFBC7C";
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
	rename -uid "9DEBF369-4449-DF27-2C31-40BA4A17B28A";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "03E8C4AD-4922-8095-95EC-EE95B4957FBE";
createNode displayLayer -n "defaultLayer";
	rename -uid "A51B287E-4631-D81A-7A69-86AD1C518826";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "A9C25BBD-475F-704B-8BE5-CC9D0125244A";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "2FA4ECBD-41CA-FEBA-AD47-C39AFABE7869";
	setAttr ".g" yes;
createNode multMatrix -n "head_drive_MMX";
	rename -uid "D736BC6E-44CE-6A10-D34F-A5BB928DDC92";
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
createNode multMatrix -n "l_arm_bendy_0_CV0_MMX";
	rename -uid "73A28CD7-42B4-9A69-B476-67A79E33ED59";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV0_DCM";
	rename -uid "BEDBEEA5-49EE-6673-AC9A-A9BC4C7DD754";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV1_MMX";
	rename -uid "3386883B-4322-5E6B-76CD-569B4E6630BF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV1_DCM";
	rename -uid "03ABDEEA-4879-0F50-40CF-62AC49D65211";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV2_MMX";
	rename -uid "A84CCE30-43DF-2784-F8B1-E9BA7D987992";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV2_DCM";
	rename -uid "66B35104-4901-0BA8-9269-CDB783E2BD99";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV3_MMX";
	rename -uid "FD07AB05-4642-B454-70E0-569F0E53E990";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV3_DCM";
	rename -uid "58D67FC5-4975-6A3E-9687-79B321BE205D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode curveInfo -n "l_arm_bendy_0_ARC_CIF";
	rename -uid "22BEA79B-4E5C-0484-FDB3-4989D250B0B4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode distanceBetween -n "l_arm_bendy_0_CHORD_DST";
	rename -uid "CDB4AB32-4CFD-3021-10C9-2F9416F3EB76";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_STRETCH_DIV";
	rename -uid "29BF9183-497F-F6A5-7E42-5E8F5EBE16DB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_EXP";
	rename -uid "595CCC6B-4092-6BF2-76C6-FFB13AF6830E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_POW";
	rename -uid "A9D28347-4796-7604-617E-1BB6028D6F24";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode motionPath -n "l_arm_bendy_0_01_MOP";
	rename -uid "A7883C05-4357-3CFF-1C49-11866A6209A3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.0.0";
createNode motionPath -n "l_arm_bendy_0_02_MOP";
	rename -uid "863A7EF3-492D-E831-2DF9-76AACD37FCBA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.0.1";
createNode motionPath -n "l_arm_bendy_0_03_MOP";
	rename -uid "E75917ED-48B0-F964-A7EE-1CB4A8B252EA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.0.2";
createNode multMatrix -n "l_arm_bendy_1_CV0_MMX";
	rename -uid "E1251029-43E7-69D0-E10B-AEB408076B9B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV0_DCM";
	rename -uid "F84B6A94-4659-B2D5-FD71-B0802570B64B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV1_MMX";
	rename -uid "D8A1ECF7-412A-E82C-DEC2-C59B6B5C1756";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV1_DCM";
	rename -uid "AD4E8648-4417-89CD-1EC0-0D9C5EB7CE78";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV2_MMX";
	rename -uid "7B840715-439D-DAA9-2463-08AEF0A2EBCB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV2_DCM";
	rename -uid "16202D44-454F-FCE4-1E8F-2099AB58DC50";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV3_MMX";
	rename -uid "0BD05864-497E-21D8-B341-F99C839680F7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV3_DCM";
	rename -uid "913CB8CB-48D8-BB52-2AC3-B789EB151A54";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode curveInfo -n "l_arm_bendy_1_ARC_CIF";
	rename -uid "C6C66DD9-4950-10D5-5A31-BEB81216E355";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode distanceBetween -n "l_arm_bendy_1_CHORD_DST";
	rename -uid "3848C571-453D-C885-ED00-6FBDCF2A426B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_STRETCH_DIV";
	rename -uid "D0B96ACA-43F6-E51E-D248-F4A1E184A637";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_EXP";
	rename -uid "10E7A256-484B-8CDA-0211-72A728295556";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_POW";
	rename -uid "BF6D7A8F-4792-D319-1806-48A055D43687";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode motionPath -n "l_arm_bendy_1_01_MOP";
	rename -uid "2EEF4083-46F2-5CC2-E8CB-528AD8941AC6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.1.0";
createNode motionPath -n "l_arm_bendy_1_02_MOP";
	rename -uid "09022F74-44A2-0952-B54F-EEB8AD937C4F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.1.1";
createNode motionPath -n "l_arm_bendy_1_03_MOP";
	rename -uid "D297E441-4FFF-B9FF-9457-7591963964F9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_arm.bendy.1.2";
createNode blendMatrix -n "l_arm_blend_0_BLM";
	rename -uid "EECAF4FA-4232-F15E-BC4B-D8A305209114";
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
	rename -uid "76D3D956-4233-E3F2-2127-7B8E32F36085";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_CORRECT_MMX";
	rename -uid "2EA16B30-4BF4-5C72-BFAF-4290E6F9B772";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_LOCAL_MMX";
	rename -uid "24BD591F-451B-4ADD-400E-D8BA806994D8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode blendMatrix -n "l_arm_blend_1_BLM";
	rename -uid "60A27A24-4454-382F-06B5-D0B24BAC0384";
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
	rename -uid "91AAEFA2-44E6-7CEB-0DFD-3C9807C2E056";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_CORRECT_MMX";
	rename -uid "7759F6ED-4348-87C9-EDC3-709013352E08";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_LOCAL_MMX";
	rename -uid "CA6C9C38-47AA-F8BD-4142-A39F5E350C87";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode blendMatrix -n "l_arm_blend_2_BLM";
	rename -uid "4FE7BD39-4146-90AA-E16E-3FBA93E7B21E";
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
	rename -uid "B2DF2631-4B64-AEA9-692A-F6ABBCCE8470";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_CORRECT_MMX";
	rename -uid "584E06C3-4DC1-F599-5B78-1A89E07BB5A7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_LOCAL_MMX";
	rename -uid "09F67EB3-4F9A-B5A6-225F-14B85211B647";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_drive_0_MMX";
	rename -uid "44840033-4F0B-DADA-129F-E0A1CBB17453";
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
	rename -uid "5A1DEE68-454E-B04F-F3BF-8D885F9E4278";
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
	rename -uid "F2D1708C-4619-FBDC-7341-D7839DE1DC5B";
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
	rename -uid "13E9CBCB-422C-19E1-15F7-9DAC96488C83";
createNode unitConversion -n "unitConversion1";
	rename -uid "E61C8150-4FDE-CC11-FD58-048FA65C4E2D";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_arm_space_CHOICE";
	rename -uid "EDA04639-448A-5235-8A8B-179E565056C6";
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
	rename -uid "6504BCB5-4EC8-349A-986F-BAA9A13DFA39";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE0_MMX";
	rename -uid "8170AB86-4D82-1221-4883-8EB8570494CA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE1_MMX";
	rename -uid "56A85FB9-4531-C971-02E1-AFA4579E89B2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_twist_0_REL_MMX";
	rename -uid "0F4FFCAC-4EBD-7D28-F405-B98573DBB68A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.deform.1\"],[\"targets\",\"l_arm.twist.0.0|l_arm.twist.0.1|l_arm.twist.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"startRole\",\"left_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_0_REL_DCM";
	rename -uid "64B022A5-41D5-AA4E-92CC-928B3E46D6E2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode vectorProduct -n "l_arm_twist_0_TWIST_DOT";
	rename -uid "A5CB8D86-494F-BF03-B86D-D6A1CC37040C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multiplyDivide -n "l_arm_twist_0_TWIST_PROJECT";
	rename -uid "F1528C81-4970-38DE-A98A-44881CB8B3AF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatNormalize -n "l_arm_twist_0_TWIST_NORM";
	rename -uid "9C4C006A-4C2A-EA57-5993-E2848B51200A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_01_SLERP";
	rename -uid "5F298118-46B8-EAF4-90F7-36B12C95C1E0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.0";
createNode quatToEuler -n "l_arm_twist_0_01_QTE";
	rename -uid "2660EC16-4E77-1749-BC8F-1085F84A614E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_02_SLERP";
	rename -uid "89CD18FB-4E12-C315-0044-2D9227B03686";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.1";
createNode quatToEuler -n "l_arm_twist_0_02_QTE";
	rename -uid "982A8F44-429F-D41B-7E99-7789A454DFFD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_03_SLERP";
	rename -uid "89470503-4A79-F85D-1411-83A38B18B84D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.2";
createNode quatToEuler -n "l_arm_twist_0_03_QTE";
	rename -uid "799D90C8-4E44-7C6E-ACC5-6BAA36387CD4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multMatrix -n "l_arm_twist_1_REL_MMX";
	rename -uid "8650C65A-4471-FDE6-EE3D-37875DC1EE59";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.deform.2\"],[\"targets\",\"l_arm.twist.1.0|l_arm.twist.1.1|l_arm.twist.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"startRole\",\"left_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_1_REL_DCM";
	rename -uid "DCC8CF63-4C4C-EEF1-1675-81BDABAB3B2C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode vectorProduct -n "l_arm_twist_1_TWIST_DOT";
	rename -uid "9AC06BE1-40E5-FAFB-2786-BFBFFF26B6FD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multiplyDivide -n "l_arm_twist_1_TWIST_PROJECT";
	rename -uid "EA17A996-4F00-DE32-8F08-3DB3D0533A6F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatNormalize -n "l_arm_twist_1_TWIST_NORM";
	rename -uid "971E8B56-497D-B95B-EC0A-CBBA547CF75C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_01_SLERP";
	rename -uid "D5B7FE03-4875-4B4C-827C-DA84C27D4A58";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.0";
createNode quatToEuler -n "l_arm_twist_1_01_QTE";
	rename -uid "7AC4691A-4D0F-4B3B-AF2C-43AFDF40442E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_02_SLERP";
	rename -uid "D0C10760-4DA5-9C96-95D0-A782425526DA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.1";
createNode quatToEuler -n "l_arm_twist_1_02_QTE";
	rename -uid "71FA8C4C-41F8-3BA9-01B5-60921DD07F84";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_03_SLERP";
	rename -uid "F9ADB09F-456B-DE77-4F4E-E0B839CCE20C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.2";
createNode quatToEuler -n "l_arm_twist_1_03_QTE";
	rename -uid "6842E3B1-4743-A046-6EEF-DBBFD048AECC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multMatrix -n "l_leg_bendy_0_CV0_MMX";
	rename -uid "6FD27389-4E08-8F32-E513-5C8F75F58786";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV0_DCM";
	rename -uid "2F8035F7-490F-BE10-0A1C-D59BE59704CE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV1_MMX";
	rename -uid "C51825EF-4165-1DAC-F82C-CFBC28662D5C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV1_DCM";
	rename -uid "06D245AE-4042-7C0B-C7F6-1F991816F482";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV2_MMX";
	rename -uid "C76E9A80-4378-4A01-1A01-F68FE5057192";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV2_DCM";
	rename -uid "082FA224-4C59-CE39-A37F-BDBD397C133C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV3_MMX";
	rename -uid "F91BE0CE-4D91-FA3B-A559-B39E82287313";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV3_DCM";
	rename -uid "6483F8A8-4D89-70FB-B31B-9CB55A8543B2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode curveInfo -n "l_leg_bendy_0_ARC_CIF";
	rename -uid "5A70139F-410F-9457-605F-A68AD2BA5736";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode distanceBetween -n "l_leg_bendy_0_CHORD_DST";
	rename -uid "F203D806-462B-0F69-B365-03B3148FE115";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_STRETCH_DIV";
	rename -uid "5E7F3E62-41C1-2F08-F63B-CAB9746CFC22";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_EXP";
	rename -uid "906F7D36-4733-3CD2-897D-9D89D98A86AB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_POW";
	rename -uid "2AE00161-4630-FC56-263D-3A82B3C00175";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode motionPath -n "l_leg_bendy_0_01_MOP";
	rename -uid "B072F903-4F3E-D00B-2965-488C6AA1783E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.0.0";
createNode motionPath -n "l_leg_bendy_0_02_MOP";
	rename -uid "17B73D63-4BED-C677-0BD9-BF957BD1BC94";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.0.1";
createNode motionPath -n "l_leg_bendy_0_03_MOP";
	rename -uid "FDB495A5-48C6-EC49-C86C-42912532E025";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.0.2";
createNode multMatrix -n "l_leg_bendy_1_CV0_MMX";
	rename -uid "4E23D31F-46D3-6F1A-CD55-33B024AD4DB3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV0_DCM";
	rename -uid "A8EA8DED-4DF0-E089-7C0F-CCAF59607C05";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV1_MMX";
	rename -uid "6D8F2324-4456-37EC-CD4F-CBB49BA2550A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV1_DCM";
	rename -uid "08AED469-4FD8-AF4A-78E0-9FA92624D6F7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV2_MMX";
	rename -uid "886C0D5A-4AD9-84E3-36C1-8793A39DD886";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV2_DCM";
	rename -uid "09990481-4B32-5575-5440-2995C588553E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV3_MMX";
	rename -uid "89F9F9FA-42FE-A873-08D0-EF92ACD96077";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV3_DCM";
	rename -uid "FB7EC15F-47B0-D9E1-5961-28915F2D5EC5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode curveInfo -n "l_leg_bendy_1_ARC_CIF";
	rename -uid "723C6EAD-45F4-4472-B739-5AA43919A5DA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode distanceBetween -n "l_leg_bendy_1_CHORD_DST";
	rename -uid "CD4E1834-42E5-0BBB-31B2-7E97F11D7794";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_STRETCH_DIV";
	rename -uid "57395E55-43B8-5C70-B184-05840C483B45";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_EXP";
	rename -uid "B3144AE4-4FAD-D608-EC2B-FB91026C5C47";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_POW";
	rename -uid "87369EEC-4E11-7435-AC02-738407697402";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode motionPath -n "l_leg_bendy_1_01_MOP";
	rename -uid "114059A6-471A-AF87-C15E-FC8C1C75466B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.1.0";
createNode motionPath -n "l_leg_bendy_1_02_MOP";
	rename -uid "EAED6649-4010-41FF-75BC-869CEBA891DE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.1.1";
createNode motionPath -n "l_leg_bendy_1_03_MOP";
	rename -uid "78A3E0B2-4753-394F-F143-ECA05B069FED";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "l_leg.bendy.1.2";
createNode blendMatrix -n "l_leg_blend_0_BLM";
	rename -uid "6F657EEE-4F2B-56D3-F4BB-97A39F19888D";
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
	rename -uid "F30D3DAA-4925-237D-C756-DC8B7BAE57CF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_CORRECT_MMX";
	rename -uid "5DAC10E6-4119-C341-BB4A-AEBFC69334D3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_LOCAL_MMX";
	rename -uid "9A48DD47-4392-19A5-691B-4BADA0F84FE8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode blendMatrix -n "l_leg_blend_1_BLM";
	rename -uid "79E2A80D-40DB-838C-7E28-95AFB3AE6002";
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
	rename -uid "174CEF6E-4DD8-6EBE-FABC-DA87D4A8E902";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_CORRECT_MMX";
	rename -uid "7F48C4A1-46D0-FFEE-E52C-10A4A4C3F7EA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_LOCAL_MMX";
	rename -uid "6D6F54E9-40A6-B3C4-8CBE-9D925F5C567E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode blendMatrix -n "l_leg_blend_2_BLM";
	rename -uid "ED598C52-41F3-89C4-9C4A-E4A5421ADFF0";
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
	rename -uid "DCB3D184-4594-6CA7-3BD9-4A9ACE64AF54";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_CORRECT_MMX";
	rename -uid "DA103360-4EDC-AC50-E355-88AF622C5A51";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_LOCAL_MMX";
	rename -uid "188A461F-41D1-7435-D363-9EBC0314480E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_drive_0_MMX";
	rename -uid "4310A3C5-476D-65DB-4121-C996C7C30150";
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
	rename -uid "81AA1BCE-4200-9234-0325-B897FBD03944";
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
	rename -uid "F629AD11-4001-0731-1271-0F8B6511739C";
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
	rename -uid "B3754DFA-4596-5534-FD23-CCBBB945129E";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_leg_space_CHOICE";
	rename -uid "8202CB3B-4BD8-7F09-1137-D98EF529A5EE";
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
	rename -uid "B3D29FE7-4D81-05B3-77A5-ACB25F373920";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE0_MMX";
	rename -uid "06738094-4E20-2A5D-8154-CB9985670D7C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE1_MMX";
	rename -uid "FEF25145-4C3E-FD07-C5D7-81B00DCCC7C4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_twist_0_REL_MMX";
	rename -uid "2ED7D5FC-46E6-1226-1969-F399EEE778A2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.deform.1\"],[\"targets\",\"l_leg.twist.0.0|l_leg.twist.0.1|l_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"startRole\",\"left_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_0_REL_DCM";
	rename -uid "28356457-45A0-96C3-F381-E7ABD6DD7D89";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode vectorProduct -n "l_leg_twist_0_TWIST_DOT";
	rename -uid "182FEC4B-4A12-0AB1-1E6A-9593AF89E81D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multiplyDivide -n "l_leg_twist_0_TWIST_PROJECT";
	rename -uid "9A31A81B-49BD-3DA3-5556-DD9F0B07294D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatNormalize -n "l_leg_twist_0_TWIST_NORM";
	rename -uid "8D51E5F7-4F23-36F9-A6D2-3C866F5D6276";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_01_SLERP";
	rename -uid "47214D48-43F2-3814-E6C2-AD8148CF87A9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.0";
createNode quatToEuler -n "l_leg_twist_0_01_QTE";
	rename -uid "4A2F697C-4926-02B3-46BC-7EA2E2B79A2C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_02_SLERP";
	rename -uid "C70192A5-4445-C649-FE80-00B96D08CE23";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.1";
createNode quatToEuler -n "l_leg_twist_0_02_QTE";
	rename -uid "77970F1F-4963-CE96-9B64-839A784A6E08";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_03_SLERP";
	rename -uid "1B1C5C3C-403A-43CE-EB92-7E834DD98694";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.2";
createNode quatToEuler -n "l_leg_twist_0_03_QTE";
	rename -uid "896FCBD2-4B13-E843-C81C-41830F0264F5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multMatrix -n "l_leg_twist_1_REL_MMX";
	rename -uid "57DE8F29-4E8C-7A29-9A64-A191585CF836";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.deform.2\"],[\"targets\",\"l_leg.twist.1.0|l_leg.twist.1.1|l_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"startRole\",\"left_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_1_REL_DCM";
	rename -uid "B42C5696-42DA-1BB7-3331-A9A99CB6368C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode vectorProduct -n "l_leg_twist_1_TWIST_DOT";
	rename -uid "C9C71BE4-4297-010E-E5C4-EB92FE713E15";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multiplyDivide -n "l_leg_twist_1_TWIST_PROJECT";
	rename -uid "283D686F-44D5-8932-E00B-CFA882B0570A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatNormalize -n "l_leg_twist_1_TWIST_NORM";
	rename -uid "ACCE1980-4644-7DCA-C9C7-5D931190010B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_01_SLERP";
	rename -uid "55584353-4791-4987-339E-DD817793F52D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.0";
createNode quatToEuler -n "l_leg_twist_1_01_QTE";
	rename -uid "CF0C60EE-4779-90C0-18DB-9F804519A016";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_02_SLERP";
	rename -uid "6B54332B-4822-E6BC-1CB4-83950B5A9FAE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.1";
createNode quatToEuler -n "l_leg_twist_1_02_QTE";
	rename -uid "AFD3D48B-476A-06BA-CB0D-DABDD59E38F1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_03_SLERP";
	rename -uid "BFECE30F-4678-6F68-0996-F2B74D4F2EC3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.2";
createNode quatToEuler -n "l_leg_twist_1_03_QTE";
	rename -uid "FED0D612-415F-9C8A-54B6-188307962DC6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multMatrix -n "r_arm_bendy_0_CV0_MMX";
	rename -uid "29A205E3-428E-4890-B185-928106D93114";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV0_DCM";
	rename -uid "A3B93801-4DBE-CA5E-3339-119093D51C1E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV1_MMX";
	rename -uid "F4028DE5-4837-2D4D-15ED-A7946014AEF5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV1_DCM";
	rename -uid "E83EB4B0-47F2-6EBE-523A-DB81A038E902";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV2_MMX";
	rename -uid "34939AE7-4311-94C7-FCC4-A68E9DF74B09";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV2_DCM";
	rename -uid "68851AB7-48A9-1D3B-5816-88801C3317C2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV3_MMX";
	rename -uid "0FB4F18D-48B4-2EFE-AAEA-B7863E66FAB3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV3_DCM";
	rename -uid "D09E74AF-455E-C707-C241-7C97F83105B7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode curveInfo -n "r_arm_bendy_0_ARC_CIF";
	rename -uid "13C1FE9D-4CAF-D310-6D0E-00BF4B1EB216";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode distanceBetween -n "r_arm_bendy_0_CHORD_DST";
	rename -uid "E4A3025F-459A-2C13-C683-5287890A86D3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_STRETCH_DIV";
	rename -uid "B2312F23-4DAA-29B7-6AC3-37A2ABEB38CD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_EXP";
	rename -uid "B31FA790-4DDA-383A-B2B3-139998D338C4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_POW";
	rename -uid "9A3296E5-4993-83B2-7539-AFAFBF9A9045";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode motionPath -n "r_arm_bendy_0_01_MOP";
	rename -uid "71B4EF08-4A02-1308-0B9F-CF990CF9D682";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.0.0";
createNode motionPath -n "r_arm_bendy_0_02_MOP";
	rename -uid "62346A68-4935-E1A0-2A22-9EB52102C92C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.0.1";
createNode motionPath -n "r_arm_bendy_0_03_MOP";
	rename -uid "C5D2FB53-4E4F-40C2-2019-E29882BF4580";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.0.2";
createNode multMatrix -n "r_arm_bendy_1_CV0_MMX";
	rename -uid "D65C1FF9-4A8C-397F-1BB7-E9BD4EA8A562";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV0_DCM";
	rename -uid "F0ACC894-46B5-7364-3BF2-6C91D3455842";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV1_MMX";
	rename -uid "AE6AA4AD-409B-CE1E-6097-B692FDB2AD81";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV1_DCM";
	rename -uid "10CD6181-4F87-35C3-65FB-FF8E766BF3B8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV2_MMX";
	rename -uid "36DE6C3B-4BB5-CD43-DEA0-AC8BC16A9D27";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV2_DCM";
	rename -uid "A14FE575-4A10-1478-9497-B88B3A53FEB6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV3_MMX";
	rename -uid "4EB95363-4DEF-A056-7F80-8188BC9DA5DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV3_DCM";
	rename -uid "79F60D28-44F7-0829-81F8-389F1F577CBF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode curveInfo -n "r_arm_bendy_1_ARC_CIF";
	rename -uid "2570BB7D-4433-E87C-6997-A5B302BC017F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode distanceBetween -n "r_arm_bendy_1_CHORD_DST";
	rename -uid "E713478A-4B8C-21AA-457B-04BCBDE6CE9D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_STRETCH_DIV";
	rename -uid "17586882-43C3-621D-1434-978E24B2D27B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_EXP";
	rename -uid "81137D63-43C1-C29E-25A2-EBB3C59DB1FA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_POW";
	rename -uid "BB5B9B5D-4B69-4526-32A6-649AF8EFB7C3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode motionPath -n "r_arm_bendy_1_01_MOP";
	rename -uid "1C6763CB-4FCC-E52F-5F62-3E939A3656F6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.1.0";
createNode motionPath -n "r_arm_bendy_1_02_MOP";
	rename -uid "48D73627-44A0-CEF3-5C7A-96A65D98579A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.1.1";
createNode motionPath -n "r_arm_bendy_1_03_MOP";
	rename -uid "14632D01-4393-9957-6AB4-F68F8716C2FC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fa" 0;
	setAttr ".ua" 1;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_arm.bendy.1.2";
createNode blendMatrix -n "r_arm_blend_0_BLM";
	rename -uid "F91E78DD-4CE1-F164-6414-0DAA840CFA03";
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
	rename -uid "03B889FE-4B02-2471-C767-029357E870F2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_CORRECT_MMX";
	rename -uid "77A0E569-4C2A-6BDB-D002-20B806500A9F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_LOCAL_MMX";
	rename -uid "A3C176B4-4DBA-5C76-AB5C-369C949601CF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode blendMatrix -n "r_arm_blend_1_BLM";
	rename -uid "0629290F-4541-64AB-0E09-FE85EFF3C6F9";
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
	rename -uid "9301E60B-49B8-58FB-8A71-7D9C01BF45DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_CORRECT_MMX";
	rename -uid "EB5E0D9B-46FB-9B38-70D0-A08343022454";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_LOCAL_MMX";
	rename -uid "67E9137A-4ECE-FE30-7A97-8A89D4B66EEC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode blendMatrix -n "r_arm_blend_2_BLM";
	rename -uid "A7CEC484-4056-E937-044B-A9A698456017";
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
	rename -uid "75ADB6FF-4486-EEB0-E658-2E89F5A3147C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_CORRECT_MMX";
	rename -uid "1A3A0270-4E72-DDA8-A454-7A90C1495962";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_LOCAL_MMX";
	rename -uid "A6278B98-4C16-5EEA-C542-A49C8B5A7F91";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_drive_0_MMX";
	rename -uid "A1221F81-41A8-A627-7E91-769BA04448FE";
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
	rename -uid "C968C320-491F-70E8-712D-E0AD44C51F69";
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
	rename -uid "46578962-4D9B-1C0A-61AF-6587A5A134A2";
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
	rename -uid "66633CA1-48B3-BD17-6913-0FB17ADC1983";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_arm_space_CHOICE";
	rename -uid "7897CE89-494B-E017-2046-CD95FC74D31A";
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
	rename -uid "F920ED66-4719-C7E7-907E-BE8F9B61A042";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE0_MMX";
	rename -uid "06593346-4EEF-95C1-9EB9-8AAD8CEFFFCD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE1_MMX";
	rename -uid "F3679522-445A-9900-98C2-79A381D9E55B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_twist_0_REL_MMX";
	rename -uid "2426FA19-4B9F-A640-F167-58B2D629754E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.deform.1\"],[\"targets\",\"r_arm.twist.0.0|r_arm.twist.0.1|r_arm.twist.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"startRole\",\"right_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_0_REL_DCM";
	rename -uid "93559FED-404D-7852-E806-18896A5EE828";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode vectorProduct -n "r_arm_twist_0_TWIST_DOT";
	rename -uid "028374E7-44B8-F23B-A541-DEBB0557EA40";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multiplyDivide -n "r_arm_twist_0_TWIST_PROJECT";
	rename -uid "CA733FEA-4B34-3AF8-97DB-D899985915A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatNormalize -n "r_arm_twist_0_TWIST_NORM";
	rename -uid "09C9C25A-4F6E-870A-62A2-098C367D381F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_01_SLERP";
	rename -uid "98710780-43CE-51E2-47BB-CBB8F0465A9E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.0";
createNode quatToEuler -n "r_arm_twist_0_01_QTE";
	rename -uid "9CE5DC2D-4709-9C6D-890D-DBA00A7F04CF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_02_SLERP";
	rename -uid "B543BBBE-4941-65AD-BC40-36BE5B8B8977";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.1";
createNode quatToEuler -n "r_arm_twist_0_02_QTE";
	rename -uid "F6C541AC-4CFE-02D4-C87D-E5ABFBC89BAA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_03_SLERP";
	rename -uid "F5D504BB-4F8E-2AD7-EF38-3190478B1A09";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.2";
createNode quatToEuler -n "r_arm_twist_0_03_QTE";
	rename -uid "F0B21766-46C7-BB4D-B64A-E88C35E2F3C7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multMatrix -n "r_arm_twist_1_REL_MMX";
	rename -uid "44E64415-4A7E-5CC8-9C93-DCA1A78316D6";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.deform.2\"],[\"targets\",\"r_arm.twist.1.0|r_arm.twist.1.1|r_arm.twist.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"startRole\",\"right_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_1_REL_DCM";
	rename -uid "3E415E8C-4A30-6E51-761C-07A82B4EA234";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode vectorProduct -n "r_arm_twist_1_TWIST_DOT";
	rename -uid "A4A48673-4FBC-320F-090D-5686EA8A7391";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multiplyDivide -n "r_arm_twist_1_TWIST_PROJECT";
	rename -uid "D361055B-4E68-A78D-BD87-B78E47AE532D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatNormalize -n "r_arm_twist_1_TWIST_NORM";
	rename -uid "4EFAA7CA-4045-1DB4-D844-1A900CC66BCA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_01_SLERP";
	rename -uid "97585917-44C9-CFDE-66A1-248B78A4E8A4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.0";
createNode quatToEuler -n "r_arm_twist_1_01_QTE";
	rename -uid "33E7D0B9-4DD3-5E55-3C89-CFA70DD27F21";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_02_SLERP";
	rename -uid "F1ED0AA9-4DA7-714B-FE78-71B1E48A70DF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.1";
createNode quatToEuler -n "r_arm_twist_1_02_QTE";
	rename -uid "09072791-4C2D-EBB3-4CDF-7DB4579E5618";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_03_SLERP";
	rename -uid "BC998846-4BC2-67A1-D91B-C7A9696259DA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.2";
createNode quatToEuler -n "r_arm_twist_1_03_QTE";
	rename -uid "06D80E41-4FEE-306F-8B8D-8698AF1A9D75";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multMatrix -n "r_leg_bendy_0_CV0_MMX";
	rename -uid "9A1FF33D-43AD-D355-3469-E7B780A68E36";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV0_DCM";
	rename -uid "7022F441-44FE-2801-BF74-17A5E771E736";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV1_MMX";
	rename -uid "171BA45F-429C-ECA6-BDC3-73A1AF42185F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV1_DCM";
	rename -uid "B3146077-4634-6563-4FBA-FEA0E3AF2AE2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV2_MMX";
	rename -uid "923017DE-4FD9-ED03-4A84-188D4BE9B0D0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV2_DCM";
	rename -uid "DF641AAE-495F-3BDA-B456-5DBFCB04DC9C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV3_MMX";
	rename -uid "AFB1A703-4100-5A98-ED0B-DF9EDFA59E29";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV3_DCM";
	rename -uid "BC430041-4DD8-51C4-943C-D096F0518040";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode curveInfo -n "r_leg_bendy_0_ARC_CIF";
	rename -uid "7AC19288-4EF2-ED04-86A5-8DA7327A9EFC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode distanceBetween -n "r_leg_bendy_0_CHORD_DST";
	rename -uid "745D5F51-4DB7-2892-98B9-0899118D88C1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_STRETCH_DIV";
	rename -uid "40617806-43C1-1786-19B6-CE9E7B615206";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_EXP";
	rename -uid "0EFC4E66-4739-C6D7-8544-3D9C2670005F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_POW";
	rename -uid "C5F414D0-4041-55AA-A6F6-2AA858D9FA86";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode motionPath -n "r_leg_bendy_0_01_MOP";
	rename -uid "D2B65FA0-4C5F-C1E0-3706-B3B733F18EDD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.0.0";
createNode motionPath -n "r_leg_bendy_0_02_MOP";
	rename -uid "7D852D11-4318-7D24-B266-66A4271DCCDA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.0.1";
createNode motionPath -n "r_leg_bendy_0_03_MOP";
	rename -uid "A4FC02BF-48F8-9BB9-DE43-5E91211EAC99";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.0.2";
createNode multMatrix -n "r_leg_bendy_1_CV0_MMX";
	rename -uid "784A9EF0-4002-F805-8CB0-4DA19F89E6BA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV0_DCM";
	rename -uid "39DBBF4A-44FA-721E-1562-798FC43FBC14";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV1_MMX";
	rename -uid "BAE11C72-45B5-2E11-E723-7483C8E3C44D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV1_DCM";
	rename -uid "62E72E27-4834-C0E3-8C12-789B9598DE84";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV2_MMX";
	rename -uid "721C76BC-4F49-357D-9291-CC8E6959C261";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV2_DCM";
	rename -uid "B3742D70-42E5-868F-D409-EB852AC46C00";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV3_MMX";
	rename -uid "7199972D-4F93-925A-0A02-D78097123E06";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV3_DCM";
	rename -uid "DD02FF89-48EF-680C-42A4-C5951A77EEF9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode curveInfo -n "r_leg_bendy_1_ARC_CIF";
	rename -uid "338D7C4D-4C21-1BCF-745B-06BA93081C24";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode distanceBetween -n "r_leg_bendy_1_CHORD_DST";
	rename -uid "4C6308C9-460D-7460-9872-F9BA9EC81F22";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_STRETCH_DIV";
	rename -uid "F262EB21-4BB2-988B-2EE7-AB87E6C5039E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_EXP";
	rename -uid "15960DD7-4874-932B-1BF8-3C81864F866A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_POW";
	rename -uid "1407DA83-4A71-9DFC-F62B-D7B1E7C7D943";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode motionPath -n "r_leg_bendy_1_01_MOP";
	rename -uid "CD82230A-4B71-40FD-ED3A-BF9D022D788F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.25;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.1.0";
createNode motionPath -n "r_leg_bendy_1_02_MOP";
	rename -uid "561F90C4-4D16-7074-E6E2-7085D6A9BFC0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 1 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.5;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.1.1";
createNode motionPath -n "r_leg_bendy_1_03_MOP";
	rename -uid "83B2CB20-4A59-23F0-44DD-BC82E2412716";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendyTargetIndex" -ln "mayacraftBendyTargetIndex"
		-dv 2 -at "long";
	addAttr -ci true -sn "mayacraftBendyTarget" -ln "mayacraftBendyTarget" -dt "string";
	setAttr ".u" 0.75;
	setAttr ".f" yes;
	setAttr ".if" yes;
	setAttr ".fm" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
	setAttr ".mayacraftBendyTarget" -type "string" "r_leg.bendy.1.2";
createNode blendMatrix -n "r_leg_blend_0_BLM";
	rename -uid "281B5B90-48B5-F26A-805D-C087A0A512AE";
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
	rename -uid "84E65B75-463B-6851-5DC5-21AB6597F3AB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_CORRECT_MMX";
	rename -uid "8299F5D1-4830-44E4-3475-D1846B52A972";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_LOCAL_MMX";
	rename -uid "4228023B-4450-5F29-5FB4-B7BC7E37599C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode blendMatrix -n "r_leg_blend_1_BLM";
	rename -uid "173B23A8-4352-00E6-C37D-FCAD32B04F46";
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
	rename -uid "B1F9A1BE-48AF-419B-A7D1-74A565305298";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_CORRECT_MMX";
	rename -uid "99CC97C9-4065-D64A-DFCC-1986947D567E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_LOCAL_MMX";
	rename -uid "86986C15-40B5-9B44-83A5-D880F2C566B7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode blendMatrix -n "r_leg_blend_2_BLM";
	rename -uid "BBFB1DE6-48F8-964F-8768-71A4E2634E36";
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
	rename -uid "B8A698EF-4706-1F5F-02BA-9FA7C1A18167";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_CORRECT_MMX";
	rename -uid "F4CCD0F7-4B4E-495E-1855-65BCAAE1A0EA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_LOCAL_MMX";
	rename -uid "1D613B8B-4B72-3BB9-8C46-2B8DD86B246F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_drive_0_MMX";
	rename -uid "C8AE8BB3-4327-52B4-463D-43BBE54B9BD9";
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
	rename -uid "744229B6-4763-A3F9-7C21-DFA6AD5CB94B";
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
	rename -uid "9A92717E-4BCA-9A2D-B7E2-19A815C62B63";
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
	rename -uid "F4EBE0AB-4A19-D82E-3B20-0A945D2A4E95";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_leg_space_CHOICE";
	rename -uid "FFE834EA-4A58-D567-2A96-9A88BC28707F";
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
	rename -uid "2F0075DF-461F-2FDE-50F8-FD840F7E85EC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE0_MMX";
	rename -uid "5BD2DB87-4695-DA18-D76B-B4A516E275EC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE1_MMX";
	rename -uid "8BBDA207-4310-C601-5996-E69870180E74";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_twist_0_REL_MMX";
	rename -uid "54F9E224-4E2C-9CA1-C18B-6AB718AF6947";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.deform.1\"],[\"targets\",\"r_leg.twist.0.0|r_leg.twist.0.1|r_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"startRole\",\"right_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_0_REL_DCM";
	rename -uid "DE2DCC75-4ED1-3610-EAB2-CEB1157C8607";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode vectorProduct -n "r_leg_twist_0_TWIST_DOT";
	rename -uid "C7C81F58-4496-75DC-4365-F9BFBF7A0BF9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multiplyDivide -n "r_leg_twist_0_TWIST_PROJECT";
	rename -uid "55694DC6-4E73-8AF9-95F4-7AA60A192BEE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatNormalize -n "r_leg_twist_0_TWIST_NORM";
	rename -uid "324D11A7-4300-93AA-1139-04B0809984AC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_01_SLERP";
	rename -uid "B9A4098F-43AE-D200-A274-3F8266985256";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.0";
createNode quatToEuler -n "r_leg_twist_0_01_QTE";
	rename -uid "F392234F-4554-E71E-CFB0-828B9D219579";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_02_SLERP";
	rename -uid "D72D228A-448E-AE1D-08CD-E381D8304A51";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.1";
createNode quatToEuler -n "r_leg_twist_0_02_QTE";
	rename -uid "A8C0BA38-4894-849C-10F4-A78CC39F4F9A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_03_SLERP";
	rename -uid "272CF0EA-40A9-3DB8-62DC-8BB1F02F337A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.2";
createNode quatToEuler -n "r_leg_twist_0_03_QTE";
	rename -uid "DAEC305C-499D-B292-7F5F-C095C2DAD860";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multMatrix -n "r_leg_twist_1_REL_MMX";
	rename -uid "0E434DF1-40C0-2A1A-45A8-05BB2ADDE168";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoMatchSuccess";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.deform.2\"],[\"targets\",\"r_leg.twist.1.0|r_leg.twist.1.1|r_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"startRole\",\"right_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_1_REL_DCM";
	rename -uid "8D142217-4016-261E-8A3F-5490E6E76EE5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode vectorProduct -n "r_leg_twist_1_TWIST_DOT";
	rename -uid "3F9FB6F5-4180-073F-0E03-AAB184E8BA90";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multiplyDivide -n "r_leg_twist_1_TWIST_PROJECT";
	rename -uid "90E66AD1-4A04-8541-6B2F-6299A1660703";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatNormalize -n "r_leg_twist_1_TWIST_NORM";
	rename -uid "1B8B54A3-454B-7E77-0F60-8A920DF11DB8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_01_SLERP";
	rename -uid "4F995F69-4116-05F3-1C82-3CBB8C4B2D82";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.0";
createNode quatToEuler -n "r_leg_twist_1_01_QTE";
	rename -uid "EB2BD0AD-402C-069A-11AE-949E7A8DB69F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_02_SLERP";
	rename -uid "7FAB64DE-4F21-467D-E9D9-2B9F504823F6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.1";
createNode quatToEuler -n "r_leg_twist_1_02_QTE";
	rename -uid "21379A6D-4AB6-3E56-0B82-819B3FD0E7BA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_03_SLERP";
	rename -uid "6125641C-41B4-DC22-F434-FABD34591C29";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.2";
createNode quatToEuler -n "r_leg_twist_1_03_QTE";
	rename -uid "DBFF9D53-4D36-439E-C5E5-EAB509947366";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multMatrix -n "spine_drive_MMX";
	rename -uid "A9E5A7F7-451F-46C0-53FF-7FAECEE846BD";
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
	rename -uid "5A4710BC-4CE9-8C2F-3DE3-25B0B9066D0E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 18 24 -10;
createNode animCurveTA -n "L_forearm_FK_CTRL_rotateZ";
	rename -uid "E9DB4880-4769-FA9D-E947-B8B177D4767C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 -32 24 24.000000000000004;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "953FC61C-4F57-C060-E006-498667092CF5";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "12F2128D-4EBA-F12F-D22A-D7B078F5A1EE";
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
connectAttr "l_arm_bendy_0_CV0_DCM.ot" "curveShape1.cp[0]";
connectAttr "l_arm_bendy_0_CV1_DCM.ot" "curveShape1.cp[1]";
connectAttr "l_arm_bendy_0_CV2_DCM.ot" "curveShape1.cp[2]";
connectAttr "l_arm_bendy_0_CV3_DCM.ot" "curveShape1.cp[3]";
connectAttr "l_arm_bendy_1_CV0_DCM.ot" "curveShape2.cp[0]";
connectAttr "l_arm_bendy_1_CV1_DCM.ot" "curveShape2.cp[1]";
connectAttr "l_arm_bendy_1_CV2_DCM.ot" "curveShape2.cp[2]";
connectAttr "l_arm_bendy_1_CV3_DCM.ot" "curveShape2.cp[3]";
connectAttr "l_leg_bendy_0_CV0_DCM.ot" "curveShape3.cp[0]";
connectAttr "l_leg_bendy_0_CV1_DCM.ot" "curveShape3.cp[1]";
connectAttr "l_leg_bendy_0_CV2_DCM.ot" "curveShape3.cp[2]";
connectAttr "l_leg_bendy_0_CV3_DCM.ot" "curveShape3.cp[3]";
connectAttr "l_leg_bendy_1_CV0_DCM.ot" "curveShape4.cp[0]";
connectAttr "l_leg_bendy_1_CV1_DCM.ot" "curveShape4.cp[1]";
connectAttr "l_leg_bendy_1_CV2_DCM.ot" "curveShape4.cp[2]";
connectAttr "l_leg_bendy_1_CV3_DCM.ot" "curveShape4.cp[3]";
connectAttr "r_arm_bendy_0_CV0_DCM.ot" "curveShape5.cp[0]";
connectAttr "r_arm_bendy_0_CV1_DCM.ot" "curveShape5.cp[1]";
connectAttr "r_arm_bendy_0_CV2_DCM.ot" "curveShape5.cp[2]";
connectAttr "r_arm_bendy_0_CV3_DCM.ot" "curveShape5.cp[3]";
connectAttr "r_arm_bendy_1_CV0_DCM.ot" "curveShape6.cp[0]";
connectAttr "r_arm_bendy_1_CV1_DCM.ot" "curveShape6.cp[1]";
connectAttr "r_arm_bendy_1_CV2_DCM.ot" "curveShape6.cp[2]";
connectAttr "r_arm_bendy_1_CV3_DCM.ot" "curveShape6.cp[3]";
connectAttr "r_leg_bendy_0_CV0_DCM.ot" "curveShape7.cp[0]";
connectAttr "r_leg_bendy_0_CV1_DCM.ot" "curveShape7.cp[1]";
connectAttr "r_leg_bendy_0_CV2_DCM.ot" "curveShape7.cp[2]";
connectAttr "r_leg_bendy_0_CV3_DCM.ot" "curveShape7.cp[3]";
connectAttr "r_leg_bendy_1_CV0_DCM.ot" "curveShape8.cp[0]";
connectAttr "r_leg_bendy_1_CV1_DCM.ot" "curveShape8.cp[1]";
connectAttr "r_leg_bendy_1_CV2_DCM.ot" "curveShape8.cp[2]";
connectAttr "r_leg_bendy_1_CV3_DCM.ot" "curveShape8.cp[3]";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_01_JNT.sy";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_01_JNT.sz";
connectAttr "l_arm_bendy_0_01_MOP.ac" "L_upperArm_BENDY_01_JNT.t";
connectAttr "l_arm_bendy_0_01_MOP.r" "L_upperArm_BENDY_01_JNT.r";
connectAttr "L_upperArm_BENDY_01_JNT.s" "L_upperArm_TWIST_01_JNT.is";
connectAttr "l_arm_twist_0_01_QTE.ort" "L_upperArm_TWIST_01_JNT.r";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_02_JNT.sy";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_02_JNT.sz";
connectAttr "l_arm_bendy_0_02_MOP.ac" "L_upperArm_BENDY_02_JNT.t";
connectAttr "l_arm_bendy_0_02_MOP.r" "L_upperArm_BENDY_02_JNT.r";
connectAttr "L_upperArm_BENDY_02_JNT.s" "L_upperArm_TWIST_02_JNT.is";
connectAttr "l_arm_twist_0_02_QTE.ort" "L_upperArm_TWIST_02_JNT.r";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_03_JNT.sy";
connectAttr "l_arm_bendy_0_VOLUME_POW.ox" "L_upperArm_BENDY_03_JNT.sz";
connectAttr "l_arm_bendy_0_03_MOP.ac" "L_upperArm_BENDY_03_JNT.t";
connectAttr "l_arm_bendy_0_03_MOP.r" "L_upperArm_BENDY_03_JNT.r";
connectAttr "L_upperArm_BENDY_03_JNT.s" "L_upperArm_TWIST_03_JNT.is";
connectAttr "l_arm_twist_0_03_QTE.ort" "L_upperArm_TWIST_03_JNT.r";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_01_JNT.sy";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_01_JNT.sz";
connectAttr "l_arm_bendy_1_01_MOP.ac" "L_forearm_BENDY_01_JNT.t";
connectAttr "l_arm_bendy_1_01_MOP.r" "L_forearm_BENDY_01_JNT.r";
connectAttr "L_forearm_BENDY_01_JNT.s" "L_forearm_TWIST_01_JNT.is";
connectAttr "l_arm_twist_1_01_QTE.ort" "L_forearm_TWIST_01_JNT.r";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_02_JNT.sy";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_02_JNT.sz";
connectAttr "l_arm_bendy_1_02_MOP.ac" "L_forearm_BENDY_02_JNT.t";
connectAttr "l_arm_bendy_1_02_MOP.r" "L_forearm_BENDY_02_JNT.r";
connectAttr "L_forearm_BENDY_02_JNT.s" "L_forearm_TWIST_02_JNT.is";
connectAttr "l_arm_twist_1_02_QTE.ort" "L_forearm_TWIST_02_JNT.r";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_03_JNT.sy";
connectAttr "l_arm_bendy_1_VOLUME_POW.ox" "L_forearm_BENDY_03_JNT.sz";
connectAttr "l_arm_bendy_1_03_MOP.ac" "L_forearm_BENDY_03_JNT.t";
connectAttr "l_arm_bendy_1_03_MOP.r" "L_forearm_BENDY_03_JNT.r";
connectAttr "L_forearm_BENDY_03_JNT.s" "L_forearm_TWIST_03_JNT.is";
connectAttr "l_arm_twist_1_03_QTE.ort" "L_forearm_TWIST_03_JNT.r";
connectAttr "l_arm_blend_0_LOCAL_MMX.o" "L_upperArm_RESULT_JNT.opm";
connectAttr "L_upperArm_RESULT_JNT.s" "L_forearm_RESULT_JNT.is";
connectAttr "l_arm_blend_1_LOCAL_MMX.o" "L_forearm_RESULT_JNT.opm";
connectAttr "L_forearm_RESULT_JNT.s" "L_hand_RESULT_JNT.is";
connectAttr "l_arm_blend_2_LOCAL_MMX.o" "L_hand_RESULT_JNT.opm";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_01_JNT.sx";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_01_JNT.sz";
connectAttr "l_leg_bendy_0_01_MOP.ac" "L_thigh_BENDY_01_JNT.t";
connectAttr "l_leg_bendy_0_01_MOP.r" "L_thigh_BENDY_01_JNT.r";
connectAttr "L_thigh_BENDY_01_JNT.s" "L_thigh_TWIST_01_JNT.is";
connectAttr "l_leg_twist_0_01_QTE.ort" "L_thigh_TWIST_01_JNT.r";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_02_JNT.sx";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_02_JNT.sz";
connectAttr "l_leg_bendy_0_02_MOP.ac" "L_thigh_BENDY_02_JNT.t";
connectAttr "l_leg_bendy_0_02_MOP.r" "L_thigh_BENDY_02_JNT.r";
connectAttr "L_thigh_BENDY_02_JNT.s" "L_thigh_TWIST_02_JNT.is";
connectAttr "l_leg_twist_0_02_QTE.ort" "L_thigh_TWIST_02_JNT.r";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_03_JNT.sx";
connectAttr "l_leg_bendy_0_VOLUME_POW.ox" "L_thigh_BENDY_03_JNT.sz";
connectAttr "l_leg_bendy_0_03_MOP.ac" "L_thigh_BENDY_03_JNT.t";
connectAttr "l_leg_bendy_0_03_MOP.r" "L_thigh_BENDY_03_JNT.r";
connectAttr "L_thigh_BENDY_03_JNT.s" "L_thigh_TWIST_03_JNT.is";
connectAttr "l_leg_twist_0_03_QTE.ort" "L_thigh_TWIST_03_JNT.r";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_01_JNT.sx";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_01_JNT.sz";
connectAttr "l_leg_bendy_1_01_MOP.ac" "L_calf_BENDY_01_JNT.t";
connectAttr "l_leg_bendy_1_01_MOP.r" "L_calf_BENDY_01_JNT.r";
connectAttr "L_calf_BENDY_01_JNT.s" "L_calf_TWIST_01_JNT.is";
connectAttr "l_leg_twist_1_01_QTE.ort" "L_calf_TWIST_01_JNT.r";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_02_JNT.sx";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_02_JNT.sz";
connectAttr "l_leg_bendy_1_02_MOP.ac" "L_calf_BENDY_02_JNT.t";
connectAttr "l_leg_bendy_1_02_MOP.r" "L_calf_BENDY_02_JNT.r";
connectAttr "L_calf_BENDY_02_JNT.s" "L_calf_TWIST_02_JNT.is";
connectAttr "l_leg_twist_1_02_QTE.ort" "L_calf_TWIST_02_JNT.r";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_03_JNT.sx";
connectAttr "l_leg_bendy_1_VOLUME_POW.ox" "L_calf_BENDY_03_JNT.sz";
connectAttr "l_leg_bendy_1_03_MOP.ac" "L_calf_BENDY_03_JNT.t";
connectAttr "l_leg_bendy_1_03_MOP.r" "L_calf_BENDY_03_JNT.r";
connectAttr "L_calf_BENDY_03_JNT.s" "L_calf_TWIST_03_JNT.is";
connectAttr "l_leg_twist_1_03_QTE.ort" "L_calf_TWIST_03_JNT.r";
connectAttr "l_leg_blend_0_LOCAL_MMX.o" "L_thigh_RESULT_JNT.opm";
connectAttr "L_thigh_RESULT_JNT.s" "L_calf_RESULT_JNT.is";
connectAttr "l_leg_blend_1_LOCAL_MMX.o" "L_calf_RESULT_JNT.opm";
connectAttr "L_calf_RESULT_JNT.s" "L_foot_RESULT_JNT.is";
connectAttr "l_leg_blend_2_LOCAL_MMX.o" "L_foot_RESULT_JNT.opm";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_01_JNT.sy";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_01_JNT.sz";
connectAttr "r_arm_bendy_0_01_MOP.ac" "R_upperArm_BENDY_01_JNT.t";
connectAttr "r_arm_bendy_0_01_MOP.r" "R_upperArm_BENDY_01_JNT.r";
connectAttr "R_upperArm_BENDY_01_JNT.s" "R_upperArm_TWIST_01_JNT.is";
connectAttr "r_arm_twist_0_01_QTE.ort" "R_upperArm_TWIST_01_JNT.r";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_02_JNT.sy";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_02_JNT.sz";
connectAttr "r_arm_bendy_0_02_MOP.ac" "R_upperArm_BENDY_02_JNT.t";
connectAttr "r_arm_bendy_0_02_MOP.r" "R_upperArm_BENDY_02_JNT.r";
connectAttr "R_upperArm_BENDY_02_JNT.s" "R_upperArm_TWIST_02_JNT.is";
connectAttr "r_arm_twist_0_02_QTE.ort" "R_upperArm_TWIST_02_JNT.r";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_03_JNT.sy";
connectAttr "r_arm_bendy_0_VOLUME_POW.ox" "R_upperArm_BENDY_03_JNT.sz";
connectAttr "r_arm_bendy_0_03_MOP.ac" "R_upperArm_BENDY_03_JNT.t";
connectAttr "r_arm_bendy_0_03_MOP.r" "R_upperArm_BENDY_03_JNT.r";
connectAttr "R_upperArm_BENDY_03_JNT.s" "R_upperArm_TWIST_03_JNT.is";
connectAttr "r_arm_twist_0_03_QTE.ort" "R_upperArm_TWIST_03_JNT.r";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_01_JNT.sy";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_01_JNT.sz";
connectAttr "r_arm_bendy_1_01_MOP.ac" "R_forearm_BENDY_01_JNT.t";
connectAttr "r_arm_bendy_1_01_MOP.r" "R_forearm_BENDY_01_JNT.r";
connectAttr "R_forearm_BENDY_01_JNT.s" "R_forearm_TWIST_01_JNT.is";
connectAttr "r_arm_twist_1_01_QTE.ort" "R_forearm_TWIST_01_JNT.r";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_02_JNT.sy";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_02_JNT.sz";
connectAttr "r_arm_bendy_1_02_MOP.ac" "R_forearm_BENDY_02_JNT.t";
connectAttr "r_arm_bendy_1_02_MOP.r" "R_forearm_BENDY_02_JNT.r";
connectAttr "R_forearm_BENDY_02_JNT.s" "R_forearm_TWIST_02_JNT.is";
connectAttr "r_arm_twist_1_02_QTE.ort" "R_forearm_TWIST_02_JNT.r";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_03_JNT.sy";
connectAttr "r_arm_bendy_1_VOLUME_POW.ox" "R_forearm_BENDY_03_JNT.sz";
connectAttr "r_arm_bendy_1_03_MOP.ac" "R_forearm_BENDY_03_JNT.t";
connectAttr "r_arm_bendy_1_03_MOP.r" "R_forearm_BENDY_03_JNT.r";
connectAttr "R_forearm_BENDY_03_JNT.s" "R_forearm_TWIST_03_JNT.is";
connectAttr "r_arm_twist_1_03_QTE.ort" "R_forearm_TWIST_03_JNT.r";
connectAttr "r_arm_blend_0_LOCAL_MMX.o" "R_upperArm_RESULT_JNT.opm";
connectAttr "R_upperArm_RESULT_JNT.s" "R_forearm_RESULT_JNT.is";
connectAttr "r_arm_blend_1_LOCAL_MMX.o" "R_forearm_RESULT_JNT.opm";
connectAttr "R_forearm_RESULT_JNT.s" "R_hand_RESULT_JNT.is";
connectAttr "r_arm_blend_2_LOCAL_MMX.o" "R_hand_RESULT_JNT.opm";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_01_JNT.sx";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_01_JNT.sz";
connectAttr "r_leg_bendy_0_01_MOP.ac" "R_thigh_BENDY_01_JNT.t";
connectAttr "r_leg_bendy_0_01_MOP.r" "R_thigh_BENDY_01_JNT.r";
connectAttr "R_thigh_BENDY_01_JNT.s" "R_thigh_TWIST_01_JNT.is";
connectAttr "r_leg_twist_0_01_QTE.ort" "R_thigh_TWIST_01_JNT.r";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_02_JNT.sx";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_02_JNT.sz";
connectAttr "r_leg_bendy_0_02_MOP.ac" "R_thigh_BENDY_02_JNT.t";
connectAttr "r_leg_bendy_0_02_MOP.r" "R_thigh_BENDY_02_JNT.r";
connectAttr "R_thigh_BENDY_02_JNT.s" "R_thigh_TWIST_02_JNT.is";
connectAttr "r_leg_twist_0_02_QTE.ort" "R_thigh_TWIST_02_JNT.r";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_03_JNT.sx";
connectAttr "r_leg_bendy_0_VOLUME_POW.ox" "R_thigh_BENDY_03_JNT.sz";
connectAttr "r_leg_bendy_0_03_MOP.ac" "R_thigh_BENDY_03_JNT.t";
connectAttr "r_leg_bendy_0_03_MOP.r" "R_thigh_BENDY_03_JNT.r";
connectAttr "R_thigh_BENDY_03_JNT.s" "R_thigh_TWIST_03_JNT.is";
connectAttr "r_leg_twist_0_03_QTE.ort" "R_thigh_TWIST_03_JNT.r";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_01_JNT.sx";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_01_JNT.sz";
connectAttr "r_leg_bendy_1_01_MOP.ac" "R_calf_BENDY_01_JNT.t";
connectAttr "r_leg_bendy_1_01_MOP.r" "R_calf_BENDY_01_JNT.r";
connectAttr "R_calf_BENDY_01_JNT.s" "R_calf_TWIST_01_JNT.is";
connectAttr "r_leg_twist_1_01_QTE.ort" "R_calf_TWIST_01_JNT.r";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_02_JNT.sx";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_02_JNT.sz";
connectAttr "r_leg_bendy_1_02_MOP.ac" "R_calf_BENDY_02_JNT.t";
connectAttr "r_leg_bendy_1_02_MOP.r" "R_calf_BENDY_02_JNT.r";
connectAttr "R_calf_BENDY_02_JNT.s" "R_calf_TWIST_02_JNT.is";
connectAttr "r_leg_twist_1_02_QTE.ort" "R_calf_TWIST_02_JNT.r";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_03_JNT.sx";
connectAttr "r_leg_bendy_1_VOLUME_POW.ox" "R_calf_BENDY_03_JNT.sz";
connectAttr "r_leg_bendy_1_03_MOP.ac" "R_calf_BENDY_03_JNT.t";
connectAttr "r_leg_bendy_1_03_MOP.r" "R_calf_BENDY_03_JNT.r";
connectAttr "R_calf_BENDY_03_JNT.s" "R_calf_TWIST_03_JNT.is";
connectAttr "r_leg_twist_1_03_QTE.ort" "R_calf_TWIST_03_JNT.r";
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
connectAttr "L_upperArm_RESULT_JNT.wm" "l_arm_bendy_0_CV0_MMX.i[0]";
connectAttr "l_arm_bendy_0_CRV.wim" "l_arm_bendy_0_CV0_MMX.i[1]";
connectAttr "l_arm_bendy_0_CV0_MMX.o" "l_arm_bendy_0_CV0_DCM.imat";
connectAttr "L_upperArm_BENDY_IN_CTRL.wm" "l_arm_bendy_0_CV1_MMX.i[0]";
connectAttr "l_arm_bendy_0_CRV.wim" "l_arm_bendy_0_CV1_MMX.i[1]";
connectAttr "l_arm_bendy_0_CV1_MMX.o" "l_arm_bendy_0_CV1_DCM.imat";
connectAttr "L_upperArm_BENDY_OUT_CTRL.wm" "l_arm_bendy_0_CV2_MMX.i[0]";
connectAttr "l_arm_bendy_0_CRV.wim" "l_arm_bendy_0_CV2_MMX.i[1]";
connectAttr "l_arm_bendy_0_CV2_MMX.o" "l_arm_bendy_0_CV2_DCM.imat";
connectAttr "L_forearm_RESULT_JNT.wm" "l_arm_bendy_0_CV3_MMX.i[0]";
connectAttr "l_arm_bendy_0_CRV.wim" "l_arm_bendy_0_CV3_MMX.i[1]";
connectAttr "l_arm_bendy_0_CV3_MMX.o" "l_arm_bendy_0_CV3_DCM.imat";
connectAttr "curveShape1.ws" "l_arm_bendy_0_ARC_CIF.ic";
connectAttr "l_arm_bendy_0_CV0_DCM.ot" "l_arm_bendy_0_CHORD_DST.p1";
connectAttr "l_arm_bendy_0_CV3_DCM.ot" "l_arm_bendy_0_CHORD_DST.p2";
connectAttr "l_arm_bendy_0_ARC_CIF.al" "l_arm_bendy_0_STRETCH_DIV.i1x";
connectAttr "l_arm_bendy_0_CHORD_DST.d" "l_arm_bendy_0_STRETCH_DIV.i2x";
connectAttr "L_upperArm_BENDY_IN_CTRL.volume" "l_arm_bendy_0_VOLUME_EXP.i1x";
connectAttr "l_arm_bendy_0_STRETCH_DIV.ox" "l_arm_bendy_0_VOLUME_POW.i1x";
connectAttr "l_arm_bendy_0_VOLUME_EXP.ox" "l_arm_bendy_0_VOLUME_POW.i2x";
connectAttr "curveShape1.ws" "l_arm_bendy_0_01_MOP.gp";
connectAttr "curveShape1.ws" "l_arm_bendy_0_02_MOP.gp";
connectAttr "curveShape1.ws" "l_arm_bendy_0_03_MOP.gp";
connectAttr "L_forearm_RESULT_JNT.wm" "l_arm_bendy_1_CV0_MMX.i[0]";
connectAttr "l_arm_bendy_1_CRV.wim" "l_arm_bendy_1_CV0_MMX.i[1]";
connectAttr "l_arm_bendy_1_CV0_MMX.o" "l_arm_bendy_1_CV0_DCM.imat";
connectAttr "L_forearm_BENDY_IN_CTRL.wm" "l_arm_bendy_1_CV1_MMX.i[0]";
connectAttr "l_arm_bendy_1_CRV.wim" "l_arm_bendy_1_CV1_MMX.i[1]";
connectAttr "l_arm_bendy_1_CV1_MMX.o" "l_arm_bendy_1_CV1_DCM.imat";
connectAttr "L_forearm_BENDY_OUT_CTRL.wm" "l_arm_bendy_1_CV2_MMX.i[0]";
connectAttr "l_arm_bendy_1_CRV.wim" "l_arm_bendy_1_CV2_MMX.i[1]";
connectAttr "l_arm_bendy_1_CV2_MMX.o" "l_arm_bendy_1_CV2_DCM.imat";
connectAttr "L_hand_RESULT_JNT.wm" "l_arm_bendy_1_CV3_MMX.i[0]";
connectAttr "l_arm_bendy_1_CRV.wim" "l_arm_bendy_1_CV3_MMX.i[1]";
connectAttr "l_arm_bendy_1_CV3_MMX.o" "l_arm_bendy_1_CV3_DCM.imat";
connectAttr "curveShape2.ws" "l_arm_bendy_1_ARC_CIF.ic";
connectAttr "l_arm_bendy_1_CV0_DCM.ot" "l_arm_bendy_1_CHORD_DST.p1";
connectAttr "l_arm_bendy_1_CV3_DCM.ot" "l_arm_bendy_1_CHORD_DST.p2";
connectAttr "l_arm_bendy_1_ARC_CIF.al" "l_arm_bendy_1_STRETCH_DIV.i1x";
connectAttr "l_arm_bendy_1_CHORD_DST.d" "l_arm_bendy_1_STRETCH_DIV.i2x";
connectAttr "L_forearm_BENDY_IN_CTRL.volume" "l_arm_bendy_1_VOLUME_EXP.i1x";
connectAttr "l_arm_bendy_1_STRETCH_DIV.ox" "l_arm_bendy_1_VOLUME_POW.i1x";
connectAttr "l_arm_bendy_1_VOLUME_EXP.ox" "l_arm_bendy_1_VOLUME_POW.i2x";
connectAttr "curveShape2.ws" "l_arm_bendy_1_01_MOP.gp";
connectAttr "curveShape2.ws" "l_arm_bendy_1_02_MOP.gp";
connectAttr "curveShape2.ws" "l_arm_bendy_1_03_MOP.gp";
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
connectAttr "L_thigh_RESULT_JNT.wm" "l_leg_bendy_0_CV0_MMX.i[0]";
connectAttr "l_leg_bendy_0_CRV.wim" "l_leg_bendy_0_CV0_MMX.i[1]";
connectAttr "l_leg_bendy_0_CV0_MMX.o" "l_leg_bendy_0_CV0_DCM.imat";
connectAttr "L_thigh_BENDY_IN_CTRL.wm" "l_leg_bendy_0_CV1_MMX.i[0]";
connectAttr "l_leg_bendy_0_CRV.wim" "l_leg_bendy_0_CV1_MMX.i[1]";
connectAttr "l_leg_bendy_0_CV1_MMX.o" "l_leg_bendy_0_CV1_DCM.imat";
connectAttr "L_thigh_BENDY_OUT_CTRL.wm" "l_leg_bendy_0_CV2_MMX.i[0]";
connectAttr "l_leg_bendy_0_CRV.wim" "l_leg_bendy_0_CV2_MMX.i[1]";
connectAttr "l_leg_bendy_0_CV2_MMX.o" "l_leg_bendy_0_CV2_DCM.imat";
connectAttr "L_calf_RESULT_JNT.wm" "l_leg_bendy_0_CV3_MMX.i[0]";
connectAttr "l_leg_bendy_0_CRV.wim" "l_leg_bendy_0_CV3_MMX.i[1]";
connectAttr "l_leg_bendy_0_CV3_MMX.o" "l_leg_bendy_0_CV3_DCM.imat";
connectAttr "curveShape3.ws" "l_leg_bendy_0_ARC_CIF.ic";
connectAttr "l_leg_bendy_0_CV0_DCM.ot" "l_leg_bendy_0_CHORD_DST.p1";
connectAttr "l_leg_bendy_0_CV3_DCM.ot" "l_leg_bendy_0_CHORD_DST.p2";
connectAttr "l_leg_bendy_0_ARC_CIF.al" "l_leg_bendy_0_STRETCH_DIV.i1x";
connectAttr "l_leg_bendy_0_CHORD_DST.d" "l_leg_bendy_0_STRETCH_DIV.i2x";
connectAttr "L_thigh_BENDY_IN_CTRL.volume" "l_leg_bendy_0_VOLUME_EXP.i1x";
connectAttr "l_leg_bendy_0_STRETCH_DIV.ox" "l_leg_bendy_0_VOLUME_POW.i1x";
connectAttr "l_leg_bendy_0_VOLUME_EXP.ox" "l_leg_bendy_0_VOLUME_POW.i2x";
connectAttr "curveShape3.ws" "l_leg_bendy_0_01_MOP.gp";
connectAttr "curveShape3.ws" "l_leg_bendy_0_02_MOP.gp";
connectAttr "curveShape3.ws" "l_leg_bendy_0_03_MOP.gp";
connectAttr "L_calf_RESULT_JNT.wm" "l_leg_bendy_1_CV0_MMX.i[0]";
connectAttr "l_leg_bendy_1_CRV.wim" "l_leg_bendy_1_CV0_MMX.i[1]";
connectAttr "l_leg_bendy_1_CV0_MMX.o" "l_leg_bendy_1_CV0_DCM.imat";
connectAttr "L_calf_BENDY_IN_CTRL.wm" "l_leg_bendy_1_CV1_MMX.i[0]";
connectAttr "l_leg_bendy_1_CRV.wim" "l_leg_bendy_1_CV1_MMX.i[1]";
connectAttr "l_leg_bendy_1_CV1_MMX.o" "l_leg_bendy_1_CV1_DCM.imat";
connectAttr "L_calf_BENDY_OUT_CTRL.wm" "l_leg_bendy_1_CV2_MMX.i[0]";
connectAttr "l_leg_bendy_1_CRV.wim" "l_leg_bendy_1_CV2_MMX.i[1]";
connectAttr "l_leg_bendy_1_CV2_MMX.o" "l_leg_bendy_1_CV2_DCM.imat";
connectAttr "L_foot_RESULT_JNT.wm" "l_leg_bendy_1_CV3_MMX.i[0]";
connectAttr "l_leg_bendy_1_CRV.wim" "l_leg_bendy_1_CV3_MMX.i[1]";
connectAttr "l_leg_bendy_1_CV3_MMX.o" "l_leg_bendy_1_CV3_DCM.imat";
connectAttr "curveShape4.ws" "l_leg_bendy_1_ARC_CIF.ic";
connectAttr "l_leg_bendy_1_CV0_DCM.ot" "l_leg_bendy_1_CHORD_DST.p1";
connectAttr "l_leg_bendy_1_CV3_DCM.ot" "l_leg_bendy_1_CHORD_DST.p2";
connectAttr "l_leg_bendy_1_ARC_CIF.al" "l_leg_bendy_1_STRETCH_DIV.i1x";
connectAttr "l_leg_bendy_1_CHORD_DST.d" "l_leg_bendy_1_STRETCH_DIV.i2x";
connectAttr "L_calf_BENDY_IN_CTRL.volume" "l_leg_bendy_1_VOLUME_EXP.i1x";
connectAttr "l_leg_bendy_1_STRETCH_DIV.ox" "l_leg_bendy_1_VOLUME_POW.i1x";
connectAttr "l_leg_bendy_1_VOLUME_EXP.ox" "l_leg_bendy_1_VOLUME_POW.i2x";
connectAttr "curveShape4.ws" "l_leg_bendy_1_01_MOP.gp";
connectAttr "curveShape4.ws" "l_leg_bendy_1_02_MOP.gp";
connectAttr "curveShape4.ws" "l_leg_bendy_1_03_MOP.gp";
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
connectAttr "R_upperArm_RESULT_JNT.wm" "r_arm_bendy_0_CV0_MMX.i[0]";
connectAttr "r_arm_bendy_0_CRV.wim" "r_arm_bendy_0_CV0_MMX.i[1]";
connectAttr "r_arm_bendy_0_CV0_MMX.o" "r_arm_bendy_0_CV0_DCM.imat";
connectAttr "R_upperArm_BENDY_IN_CTRL.wm" "r_arm_bendy_0_CV1_MMX.i[0]";
connectAttr "r_arm_bendy_0_CRV.wim" "r_arm_bendy_0_CV1_MMX.i[1]";
connectAttr "r_arm_bendy_0_CV1_MMX.o" "r_arm_bendy_0_CV1_DCM.imat";
connectAttr "R_upperArm_BENDY_OUT_CTRL.wm" "r_arm_bendy_0_CV2_MMX.i[0]";
connectAttr "r_arm_bendy_0_CRV.wim" "r_arm_bendy_0_CV2_MMX.i[1]";
connectAttr "r_arm_bendy_0_CV2_MMX.o" "r_arm_bendy_0_CV2_DCM.imat";
connectAttr "R_forearm_RESULT_JNT.wm" "r_arm_bendy_0_CV3_MMX.i[0]";
connectAttr "r_arm_bendy_0_CRV.wim" "r_arm_bendy_0_CV3_MMX.i[1]";
connectAttr "r_arm_bendy_0_CV3_MMX.o" "r_arm_bendy_0_CV3_DCM.imat";
connectAttr "curveShape5.ws" "r_arm_bendy_0_ARC_CIF.ic";
connectAttr "r_arm_bendy_0_CV0_DCM.ot" "r_arm_bendy_0_CHORD_DST.p1";
connectAttr "r_arm_bendy_0_CV3_DCM.ot" "r_arm_bendy_0_CHORD_DST.p2";
connectAttr "r_arm_bendy_0_ARC_CIF.al" "r_arm_bendy_0_STRETCH_DIV.i1x";
connectAttr "r_arm_bendy_0_CHORD_DST.d" "r_arm_bendy_0_STRETCH_DIV.i2x";
connectAttr "R_upperArm_BENDY_IN_CTRL.volume" "r_arm_bendy_0_VOLUME_EXP.i1x";
connectAttr "r_arm_bendy_0_STRETCH_DIV.ox" "r_arm_bendy_0_VOLUME_POW.i1x";
connectAttr "r_arm_bendy_0_VOLUME_EXP.ox" "r_arm_bendy_0_VOLUME_POW.i2x";
connectAttr "curveShape5.ws" "r_arm_bendy_0_01_MOP.gp";
connectAttr "curveShape5.ws" "r_arm_bendy_0_02_MOP.gp";
connectAttr "curveShape5.ws" "r_arm_bendy_0_03_MOP.gp";
connectAttr "R_forearm_RESULT_JNT.wm" "r_arm_bendy_1_CV0_MMX.i[0]";
connectAttr "r_arm_bendy_1_CRV.wim" "r_arm_bendy_1_CV0_MMX.i[1]";
connectAttr "r_arm_bendy_1_CV0_MMX.o" "r_arm_bendy_1_CV0_DCM.imat";
connectAttr "R_forearm_BENDY_IN_CTRL.wm" "r_arm_bendy_1_CV1_MMX.i[0]";
connectAttr "r_arm_bendy_1_CRV.wim" "r_arm_bendy_1_CV1_MMX.i[1]";
connectAttr "r_arm_bendy_1_CV1_MMX.o" "r_arm_bendy_1_CV1_DCM.imat";
connectAttr "R_forearm_BENDY_OUT_CTRL.wm" "r_arm_bendy_1_CV2_MMX.i[0]";
connectAttr "r_arm_bendy_1_CRV.wim" "r_arm_bendy_1_CV2_MMX.i[1]";
connectAttr "r_arm_bendy_1_CV2_MMX.o" "r_arm_bendy_1_CV2_DCM.imat";
connectAttr "R_hand_RESULT_JNT.wm" "r_arm_bendy_1_CV3_MMX.i[0]";
connectAttr "r_arm_bendy_1_CRV.wim" "r_arm_bendy_1_CV3_MMX.i[1]";
connectAttr "r_arm_bendy_1_CV3_MMX.o" "r_arm_bendy_1_CV3_DCM.imat";
connectAttr "curveShape6.ws" "r_arm_bendy_1_ARC_CIF.ic";
connectAttr "r_arm_bendy_1_CV0_DCM.ot" "r_arm_bendy_1_CHORD_DST.p1";
connectAttr "r_arm_bendy_1_CV3_DCM.ot" "r_arm_bendy_1_CHORD_DST.p2";
connectAttr "r_arm_bendy_1_ARC_CIF.al" "r_arm_bendy_1_STRETCH_DIV.i1x";
connectAttr "r_arm_bendy_1_CHORD_DST.d" "r_arm_bendy_1_STRETCH_DIV.i2x";
connectAttr "R_forearm_BENDY_IN_CTRL.volume" "r_arm_bendy_1_VOLUME_EXP.i1x";
connectAttr "r_arm_bendy_1_STRETCH_DIV.ox" "r_arm_bendy_1_VOLUME_POW.i1x";
connectAttr "r_arm_bendy_1_VOLUME_EXP.ox" "r_arm_bendy_1_VOLUME_POW.i2x";
connectAttr "curveShape6.ws" "r_arm_bendy_1_01_MOP.gp";
connectAttr "curveShape6.ws" "r_arm_bendy_1_02_MOP.gp";
connectAttr "curveShape6.ws" "r_arm_bendy_1_03_MOP.gp";
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
connectAttr "R_thigh_RESULT_JNT.wm" "r_leg_bendy_0_CV0_MMX.i[0]";
connectAttr "r_leg_bendy_0_CRV.wim" "r_leg_bendy_0_CV0_MMX.i[1]";
connectAttr "r_leg_bendy_0_CV0_MMX.o" "r_leg_bendy_0_CV0_DCM.imat";
connectAttr "R_thigh_BENDY_IN_CTRL.wm" "r_leg_bendy_0_CV1_MMX.i[0]";
connectAttr "r_leg_bendy_0_CRV.wim" "r_leg_bendy_0_CV1_MMX.i[1]";
connectAttr "r_leg_bendy_0_CV1_MMX.o" "r_leg_bendy_0_CV1_DCM.imat";
connectAttr "R_thigh_BENDY_OUT_CTRL.wm" "r_leg_bendy_0_CV2_MMX.i[0]";
connectAttr "r_leg_bendy_0_CRV.wim" "r_leg_bendy_0_CV2_MMX.i[1]";
connectAttr "r_leg_bendy_0_CV2_MMX.o" "r_leg_bendy_0_CV2_DCM.imat";
connectAttr "R_calf_RESULT_JNT.wm" "r_leg_bendy_0_CV3_MMX.i[0]";
connectAttr "r_leg_bendy_0_CRV.wim" "r_leg_bendy_0_CV3_MMX.i[1]";
connectAttr "r_leg_bendy_0_CV3_MMX.o" "r_leg_bendy_0_CV3_DCM.imat";
connectAttr "curveShape7.ws" "r_leg_bendy_0_ARC_CIF.ic";
connectAttr "r_leg_bendy_0_CV0_DCM.ot" "r_leg_bendy_0_CHORD_DST.p1";
connectAttr "r_leg_bendy_0_CV3_DCM.ot" "r_leg_bendy_0_CHORD_DST.p2";
connectAttr "r_leg_bendy_0_ARC_CIF.al" "r_leg_bendy_0_STRETCH_DIV.i1x";
connectAttr "r_leg_bendy_0_CHORD_DST.d" "r_leg_bendy_0_STRETCH_DIV.i2x";
connectAttr "R_thigh_BENDY_IN_CTRL.volume" "r_leg_bendy_0_VOLUME_EXP.i1x";
connectAttr "r_leg_bendy_0_STRETCH_DIV.ox" "r_leg_bendy_0_VOLUME_POW.i1x";
connectAttr "r_leg_bendy_0_VOLUME_EXP.ox" "r_leg_bendy_0_VOLUME_POW.i2x";
connectAttr "curveShape7.ws" "r_leg_bendy_0_01_MOP.gp";
connectAttr "curveShape7.ws" "r_leg_bendy_0_02_MOP.gp";
connectAttr "curveShape7.ws" "r_leg_bendy_0_03_MOP.gp";
connectAttr "R_calf_RESULT_JNT.wm" "r_leg_bendy_1_CV0_MMX.i[0]";
connectAttr "r_leg_bendy_1_CRV.wim" "r_leg_bendy_1_CV0_MMX.i[1]";
connectAttr "r_leg_bendy_1_CV0_MMX.o" "r_leg_bendy_1_CV0_DCM.imat";
connectAttr "R_calf_BENDY_IN_CTRL.wm" "r_leg_bendy_1_CV1_MMX.i[0]";
connectAttr "r_leg_bendy_1_CRV.wim" "r_leg_bendy_1_CV1_MMX.i[1]";
connectAttr "r_leg_bendy_1_CV1_MMX.o" "r_leg_bendy_1_CV1_DCM.imat";
connectAttr "R_calf_BENDY_OUT_CTRL.wm" "r_leg_bendy_1_CV2_MMX.i[0]";
connectAttr "r_leg_bendy_1_CRV.wim" "r_leg_bendy_1_CV2_MMX.i[1]";
connectAttr "r_leg_bendy_1_CV2_MMX.o" "r_leg_bendy_1_CV2_DCM.imat";
connectAttr "R_foot_RESULT_JNT.wm" "r_leg_bendy_1_CV3_MMX.i[0]";
connectAttr "r_leg_bendy_1_CRV.wim" "r_leg_bendy_1_CV3_MMX.i[1]";
connectAttr "r_leg_bendy_1_CV3_MMX.o" "r_leg_bendy_1_CV3_DCM.imat";
connectAttr "curveShape8.ws" "r_leg_bendy_1_ARC_CIF.ic";
connectAttr "r_leg_bendy_1_CV0_DCM.ot" "r_leg_bendy_1_CHORD_DST.p1";
connectAttr "r_leg_bendy_1_CV3_DCM.ot" "r_leg_bendy_1_CHORD_DST.p2";
connectAttr "r_leg_bendy_1_ARC_CIF.al" "r_leg_bendy_1_STRETCH_DIV.i1x";
connectAttr "r_leg_bendy_1_CHORD_DST.d" "r_leg_bendy_1_STRETCH_DIV.i2x";
connectAttr "R_calf_BENDY_IN_CTRL.volume" "r_leg_bendy_1_VOLUME_EXP.i1x";
connectAttr "r_leg_bendy_1_STRETCH_DIV.ox" "r_leg_bendy_1_VOLUME_POW.i1x";
connectAttr "r_leg_bendy_1_VOLUME_EXP.ox" "r_leg_bendy_1_VOLUME_POW.i2x";
connectAttr "curveShape8.ws" "r_leg_bendy_1_01_MOP.gp";
connectAttr "curveShape8.ws" "r_leg_bendy_1_02_MOP.gp";
connectAttr "curveShape8.ws" "r_leg_bendy_1_03_MOP.gp";
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
// End of mayacraft_match_success.ma
