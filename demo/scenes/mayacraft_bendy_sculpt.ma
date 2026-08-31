//Maya ASCII 2025ff03 scene
//Name: mayacraft_bendy_sculpt.ma
//Last modified: Sun, Aug 30, 2026 07:20:56 PM
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
fileInfo "UUID" "BB323AE8-41F0-8B96-9D2B-4688F7A17F44";
createNode transform -s -n "persp";
	rename -uid "B2021727-4640-DD2E-38D3-B388DDC95219";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "BCBCCA89-494C-426C-5931-0FAEE4821089";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "475BB835-46A6-70B7-862A-EA9180596382";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "EBD93C1C-4634-2C60-8683-A490B1243B8F";
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
	rename -uid "7D576F17-4529-AF67-4BDB-4484F36CAB3C";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "93479751-4491-197D-1D36-64A57590BD49";
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
	rename -uid "6FCE1815-4249-EA6E-B3CD-73924018DAEE";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "D7F04AA2-482F-8C42-ED73-2DA33F147E31";
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
	rename -uid "DDD99E5E-4247-4A00-A269-02A796FB5C8C";
	addAttr -ci true -sn "mayacraftDemoScenario" -ln "mayacraftDemoScenario" -dt "string";
	addAttr -ci true -sn "mayacraftExpectedResult" -ln "mayacraftExpectedResult" -dt "string";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".mayacraftDemoScenario" -type "string" "BENDY_ARC_SCULPT";
	setAttr ".mayacraftExpectedResult" -type "string" "�� 12 ֡������α仡����Ԥ����Ӧ�� S ������ö�Ȼ����ؽڡ���������� quaternion Twist �Ӳ㱣���������ɳ���";
createNode joint -n "pelvis_JNT" -p "root_JNT";
	rename -uid "2A102A35-47FA-BC2C-C737-FCB861851398";
	setAttr ".t" -type "double3" 0 10 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "spine_JNT" -p "pelvis_JNT";
	rename -uid "129FD251-44AD-1EA0-35B6-D6AF3CFCFB70";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "chest_JNT" -p "spine_JNT";
	rename -uid "06345848-4813-5F5A-8C25-FF8BFB3C0B6A";
	setAttr ".t" -type "double3" 0 4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "neck_JNT" -p "chest_JNT";
	rename -uid "CD9CB85B-41C3-C2F6-F5CD-D6A046995D6F";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "head_JNT" -p "neck_JNT";
	rename -uid "DB9CD607-4A93-049B-6F06-C99953D4C4BC";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_upperArm_JNT" -p "chest_JNT";
	rename -uid "A4A7146D-42DB-259A-2928-6F9AEFED0585";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_forearm_JNT" -p "L_upperArm_JNT";
	rename -uid "1F6EDFAA-479A-9E68-8336-319AF38BAB1B";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_hand_JNT" -p "L_forearm_JNT";
	rename -uid "A10B35E0-4CBC-3EB2-D1FD-01AF9FA0CD80";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_upperArm_JNT" -p "chest_JNT";
	rename -uid "19AD1F83-47F9-D29A-6724-378F83D33696";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_forearm_JNT" -p "R_upperArm_JNT";
	rename -uid "7262D7C4-4D10-389D-5545-69917A082D85";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_hand_JNT" -p "R_forearm_JNT";
	rename -uid "8A8BC060-4644-4AAD-68BA-F4B2FB9DA365";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_thigh_JNT" -p "pelvis_JNT";
	rename -uid "359A3299-4C20-0919-0DFB-AC8131E98F86";
	setAttr ".t" -type "double3" 3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_calf_JNT" -p "L_thigh_JNT";
	rename -uid "6D6424B1-48B3-29A7-A7E9-9C9D3ACC6D68";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_foot_JNT" -p "L_calf_JNT";
	rename -uid "47EA5169-400E-D545-BE6B-5C913F5A85A4";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_thigh_JNT" -p "pelvis_JNT";
	rename -uid "F0BF506A-45DF-F63F-EA50-D9B9BAFDA207";
	setAttr ".t" -type "double3" -3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_calf_JNT" -p "R_thigh_JNT";
	rename -uid "7F550C0B-426E-86AF-0978-2CBD52353C05";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_foot_JNT" -p "R_calf_JNT";
	rename -uid "56D1E93C-4BF8-5E61-A477-259E0B6544BD";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode transform -n "MC_RIG";
	rename -uid "8F87D578-498B-E89C-FD29-9DB845AA32A2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.root";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "MC_CONTROLS" -p "MC_RIG";
	rename -uid "8F3AF433-4E78-9DB3-3BC4-26B4CD8B5772";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.controls";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_arm_MOD" -p "MC_CONTROLS";
	rename -uid "E8359A6A-4C8D-E7A8-16E0-01B295F34CF4";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_upperArm_BENDY_IN_CTRL" -p "L_arm_MOD";
	rename -uid "6F464674-4DA6-06D1-B63A-C79D60C18444";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_IN_CTRLShape" -p "L_upperArm_BENDY_IN_CTRL";
	rename -uid "ED45F362-4114-1811-0500-1BBCB91219D4";
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
	rename -uid "9CBA7783-44B0-B805-EE03-F78050FCF6E7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_OUT_CTRLShape" -p "L_upperArm_BENDY_OUT_CTRL";
	rename -uid "61023392-4CF6-EB6D-6374-C4A527A6CD9F";
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
	rename -uid "B5800A83-4E81-B315-B082-1BA4A918BC19";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_IN_CTRLShape" -p "L_forearm_BENDY_IN_CTRL";
	rename -uid "85ECFDD1-4C0B-4B74-C0A2-97AA56972979";
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
	rename -uid "E7AC520A-47D0-1EA4-F4AC-8AB173582FD4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_OUT_CTRLShape" -p "L_forearm_BENDY_OUT_CTRL";
	rename -uid "AE6DFDEF-4A44-20F4-CD8B-BEBF47AD4940";
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
	rename -uid "1AA7696E-4F4D-1C2E-CC35-BCB4104E2F91";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_FK_CTRLShape" -p "L_upperArm_FK_CTRL";
	rename -uid "4764AE72-4848-24C6-32BF-C8998A7F945D";
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
	rename -uid "89F68393-481C-1F0C-8CA6-A8AC56661022";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_FK_CTRLShape" -p "L_forearm_FK_CTRL";
	rename -uid "CF77CBCE-48A3-BBD7-59D1-128D575EA633";
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
	rename -uid "9885DA15-4D44-7D1C-0293-A0BEB7E18AF8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode nurbsCurve -n "L_hand_FK_CTRLShape" -p "L_hand_FK_CTRL";
	rename -uid "A1963472-43BB-15DE-04EB-6AAC9B539826";
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
	rename -uid "28589B98-4DE6-4462-24A0-A0BF2936FFF0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_hand_IK_CTRL" -p "L_arm_IK_SPACE";
	rename -uid "0CAB6246-4BE6-7122-CDC4-5FB97154F136";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
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
	rename -uid "14358559-4CB4-D184-BB72-A9B79C3C974E";
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
	rename -uid "E9A89538-4F76-4802-9C62-2890F91EC6E2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.ik.ctrl|l_arm.pole.ctrl\"],[\"targets\",\"l_arm.ik_joint.0|l_arm.ik_joint.1|l_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_arm_rp_ik_PVC" -p "l_arm_rp_ik_IKH";
	rename -uid "DA776025-4A4E-3FDA-39DF-91BE03890EB2";
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
	rename -uid "872D6DE0-4A3F-D98A-5A7A-1681C5FC3BD4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_arm|left_lower_arm|left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_arm_POLE_CTRLShape" -p "L_arm_POLE_CTRL";
	rename -uid "89980899-4447-AEA4-95FA-47A8DAFE4740";
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
	rename -uid "F0D633EE-4033-426F-51F1-BFA893DFDBF0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_thigh_BENDY_IN_CTRL" -p "L_leg_MOD";
	rename -uid "7675826D-44AC-BDED-D353-CC88AD9D6A67";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_IN_CTRLShape" -p "L_thigh_BENDY_IN_CTRL";
	rename -uid "A31B2648-4140-9841-5D22-8CBEFCD39620";
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
	rename -uid "77D786B8-4D73-0A49-BC1C-A5919949401B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_OUT_CTRLShape" -p "L_thigh_BENDY_OUT_CTRL";
	rename -uid "A77CA525-49AE-6465-0DCE-6EA4610574FB";
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
	rename -uid "36038E5F-40B9-D5DC-7553-9E91988CA7F4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_IN_CTRLShape" -p "L_calf_BENDY_IN_CTRL";
	rename -uid "A749FB41-41F6-1B7D-28E7-FFADACDE2149";
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
	rename -uid "31983218-4DF0-EFE5-4FC3-1394F904DB9C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_OUT_CTRLShape" -p "L_calf_BENDY_OUT_CTRL";
	rename -uid "5894C910-4521-4929-0DF0-9A9D72BD7FB9";
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
	rename -uid "BCB14FEE-4B47-413B-CC13-29857845CE38";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_FK_CTRLShape" -p "L_thigh_FK_CTRL";
	rename -uid "F86D967D-4F54-FD71-4AB6-B293020C255F";
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
	rename -uid "EF26DDB7-4AB5-60E5-0ECD-709BF75469B0";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_FK_CTRLShape" -p "L_calf_FK_CTRL";
	rename -uid "64A10964-4380-3A52-CF92-C0909C0B8BD1";
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
	rename -uid "F1C365DB-41D2-EF59-C86C-7C8164744531";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode nurbsCurve -n "L_foot_FK_CTRLShape" -p "L_foot_FK_CTRL";
	rename -uid "B4D4433A-486B-0E5C-3E09-AC801562862C";
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
	rename -uid "409A41DA-4C38-5ACE-3A89-8CB4359314D8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_foot_IK_CTRL" -p "L_leg_IK_SPACE";
	rename -uid "0F9353B3-423D-F7BE-B9B1-45B6CDB30393";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
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
	rename -uid "91384F11-40D2-281D-DF80-4A9FC57DB039";
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
	rename -uid "7754CE6E-4BA4-0EF8-E872-42BB04C9A6D4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.ik.ctrl|l_leg.pole.ctrl\"],[\"targets\",\"l_leg.ik_joint.0|l_leg.ik_joint.1|l_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_leg_rp_ik_PVC" -p "l_leg_rp_ik_IKH";
	rename -uid "90B853A8-43F1-1516-3EF6-D7B4573329C1";
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
	rename -uid "7939B3C4-43D3-1BF0-A32F-98AF6C147512";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_leg|left_lower_leg|left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_leg_POLE_CTRLShape" -p "L_leg_POLE_CTRL";
	rename -uid "66F36DD1-4E8A-5DEB-7A64-F99A524BF1E6";
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
	rename -uid "541E09BA-47EA-DBF0-06E1-559EFD3FE90B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_upperArm_BENDY_IN_CTRL" -p "R_arm_MOD";
	rename -uid "9BEF7217-4CCC-EAD4-3712-5597513B3083";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_IN_CTRLShape" -p "R_upperArm_BENDY_IN_CTRL";
	rename -uid "BCEC326B-4089-F130-24F2-858B4CDE27C8";
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
	rename -uid "9096974B-4E4E-5544-540D-169E4575A908";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_OUT_CTRLShape" -p "R_upperArm_BENDY_OUT_CTRL";
	rename -uid "1437E335-413E-8E13-37A8-FDBE48A62370";
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
	rename -uid "D30B3A58-4CD6-CD7B-A7F6-95B4258896E3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_IN_CTRLShape" -p "R_forearm_BENDY_IN_CTRL";
	rename -uid "9B77D01C-42DE-A1A5-AEA4-E1966B8EE366";
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
	rename -uid "9C9E4632-40D9-1262-CEDA-168F1279D50A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_OUT_CTRLShape" -p "R_forearm_BENDY_OUT_CTRL";
	rename -uid "A05611B6-4F43-28E7-6C55-CD9EBA329449";
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
	rename -uid "5D2A8DFA-4148-C894-35EB-ECA607F6BC68";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_FK_CTRLShape" -p "R_upperArm_FK_CTRL";
	rename -uid "C1B95C89-4E89-B9E5-4761-CCB5FF4E87ED";
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
	rename -uid "505968A2-47FC-8950-3AE6-D18CC0F69928";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_FK_CTRLShape" -p "R_forearm_FK_CTRL";
	rename -uid "EDBAF511-4262-CD73-966C-298D08A62219";
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
	rename -uid "963130D1-41A4-620E-DE3B-758A789FCDDD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode nurbsCurve -n "R_hand_FK_CTRLShape" -p "R_hand_FK_CTRL";
	rename -uid "074FA372-4DCC-BB06-CF26-76BB8EB5F59E";
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
	rename -uid "096532A7-4990-C222-A697-F7910D3F638B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_hand_IK_CTRL" -p "R_arm_IK_SPACE";
	rename -uid "BE38F166-40AE-9CC5-1D0A-5DBC98E9D01F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
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
	rename -uid "2A8DBC42-4A16-10C1-51C7-F29945431121";
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
	rename -uid "871EE4ED-4060-829D-55A2-F78A6BD7B459";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.ik.ctrl|r_arm.pole.ctrl\"],[\"targets\",\"r_arm.ik_joint.0|r_arm.ik_joint.1|r_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_arm_rp_ik_PVC" -p "r_arm_rp_ik_IKH";
	rename -uid "30053F8A-4C94-DE75-328D-9D93A50D5A80";
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
	rename -uid "6A2D287A-482E-B7AC-6635-208C289E5AA3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_arm|right_lower_arm|right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,-4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_arm_POLE_CTRLShape" -p "R_arm_POLE_CTRL";
	rename -uid "A261E70F-4358-D945-B195-8FBA0B5B735C";
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
	rename -uid "60088CE5-40DC-5359-2E8C-3EAA922932AE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_thigh_BENDY_IN_CTRL" -p "R_leg_MOD";
	rename -uid "82FE78BD-46A3-0B1D-72B1-A2829B42A09C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_IN_CTRLShape" -p "R_thigh_BENDY_IN_CTRL";
	rename -uid "C363FD3F-4991-0A12-CBC5-37904B7725AE";
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
	rename -uid "71984A51-4455-3F24-942B-D180FE5D3EA2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_OUT_CTRLShape" -p "R_thigh_BENDY_OUT_CTRL";
	rename -uid "B26F7E6D-4BCF-E320-14F6-21BD83856641";
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
	rename -uid "A4597E29-42E6-87AA-47EB-A6869CDF30B9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_IN_CTRLShape" -p "R_calf_BENDY_IN_CTRL";
	rename -uid "917104C2-42A1-3B70-F5FB-F595B091BA35";
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
	rename -uid "85E448B3-41F8-0C16-A678-BA91E8A96144";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_OUT_CTRLShape" -p "R_calf_BENDY_OUT_CTRL";
	rename -uid "1AF16909-4557-2C9C-4D2D-D1BAEC9698C7";
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
	rename -uid "36E3359D-46D1-0C46-E29F-F7A3445A8540";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_FK_CTRLShape" -p "R_thigh_FK_CTRL";
	rename -uid "415BC360-4BA3-5E4E-1DF5-B294B5733948";
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
	rename -uid "023B7EB7-40F6-DBB2-F9A3-57871994D55A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_FK_CTRLShape" -p "R_calf_FK_CTRL";
	rename -uid "96102C0C-485A-0BDC-7C3A-458D3CAD54F7";
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
	rename -uid "9DB91FC2-4202-1BBC-8C54-77BE0232084B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode nurbsCurve -n "R_foot_FK_CTRLShape" -p "R_foot_FK_CTRL";
	rename -uid "AEF4C525-4E4A-A6BC-3B4E-138459772ACD";
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
	rename -uid "ED79B971-4526-D750-BF48-988FE19F728F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_foot_IK_CTRL" -p "R_leg_IK_SPACE";
	rename -uid "7B815C7A-4FE0-0624-095B-0BBE2BFE27CF";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
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
	rename -uid "C957BD5E-43CA-721F-0134-B9BA6D027644";
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
	rename -uid "09DBB1BE-4887-614C-D88D-89A3B0C56C8C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.ik.ctrl|r_leg.pole.ctrl\"],[\"targets\",\"r_leg.ik_joint.0|r_leg.ik_joint.1|r_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_leg_rp_ik_PVC" -p "r_leg_rp_ik_IKH";
	rename -uid "19B154B0-4DC8-9B7E-95C9-E28A74F5BAE7";
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
	rename -uid "7037C198-4137-FAB6-0713-C888E766292D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_leg|right_lower_leg|right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_leg_POLE_CTRLShape" -p "R_leg_POLE_CTRL";
	rename -uid "BC2DC0C8-47D6-F31F-E08F-0EAD18590F5C";
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
	rename -uid "0103EF0A-4CCD-AD8F-44A8-F1A8AA800C27";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "C_chest_FK_CTRL" -p "C_spine_MOD";
	rename -uid "5A518865-40D3-9728-F24E-35BD48B107F9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode nurbsCurve -n "C_chest_FK_CTRLShape" -p "C_chest_FK_CTRL";
	rename -uid "C5D503F1-423C-EBCE-41D0-B785B5B9FD24";
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
	rename -uid "03AC52DF-457A-5CB8-AB07-1086D3A13584";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode nurbsCurve -n "C_head_FK_CTRLShape" -p "C_head_FK_CTRL";
	rename -uid "BF2C3A9E-4A19-8987-5425-89893B000057";
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
	rename -uid "900E72BB-43FF-93A5-DDBC-018F6EE34174";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "0889E710-4062-C9DD-8404-08AC974437D3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_FK_DRV_JNT" -p "L_upperArm_FK_DRV_JNT";
	rename -uid "ED7D8A2B-44DB-F21B-52F2-D082A449754E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_FK_DRV_JNT" -p "L_forearm_FK_DRV_JNT";
	rename -uid "079A87D9-4430-4535-B08A-3FB9A03A3A08";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "3C59376F-4E58-63A5-4FC3-5CAC9513249A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_IK_DRV_JNT" -p "L_upperArm_IK_DRV_JNT";
	rename -uid "0ADAD8A2-4C76-715E-D897-D9B65DC05551";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_IK_DRV_JNT" -p "L_forearm_IK_DRV_JNT";
	rename -uid "AAD144CC-4B73-1999-423F-098E20BC00C7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode ikEffector -n "effector1" -p "L_forearm_IK_DRV_JNT";
	rename -uid "16444AD1-4B03-7048-1D4C-D7B4BFACFFA3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode joint -n "L_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "6E57C587-41A1-45FD-47F0-05A82AE035FE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_FK_DRV_JNT" -p "L_thigh_FK_DRV_JNT";
	rename -uid "FCB64F93-4FD9-45BC-BDE4-A38AAFD8F5FD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_FK_DRV_JNT" -p "L_calf_FK_DRV_JNT";
	rename -uid "5943F601-4307-80C7-3E60-6EBB12DC7B2F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "L_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "4B5F293A-4468-4CFA-EBD5-E882B4DAEF4A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_IK_DRV_JNT" -p "L_thigh_IK_DRV_JNT";
	rename -uid "E4E04E6B-4D99-A0C5-C7F2-91A5A864B796";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_IK_DRV_JNT" -p "L_calf_IK_DRV_JNT";
	rename -uid "179795F0-4A0E-B9C0-D027-A7B034494010";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode ikEffector -n "effector2" -p "L_calf_IK_DRV_JNT";
	rename -uid "4C21BDC0-49E3-3E8D-C234-4DAF2C91E207";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode joint -n "R_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "77672C49-4216-F82E-4F83-C887889D4C49";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_FK_DRV_JNT" -p "R_upperArm_FK_DRV_JNT";
	rename -uid "BB0EACBC-421A-C4ED-DFEE-54884DBE30C0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_FK_DRV_JNT" -p "R_forearm_FK_DRV_JNT";
	rename -uid "2E503621-46A2-1147-2B61-8FA6706DC499";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "4F01F5AD-4A1D-3FCA-9C0A-9B88E2866A71";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_IK_DRV_JNT" -p "R_upperArm_IK_DRV_JNT";
	rename -uid "9E6237D6-4375-75DB-EF6D-D3AC47F7DF53";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_IK_DRV_JNT" -p "R_forearm_IK_DRV_JNT";
	rename -uid "51F89042-4CE3-1809-3B1C-028ABF776FEE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode ikEffector -n "effector3" -p "R_forearm_IK_DRV_JNT";
	rename -uid "5B7D1008-4608-A4C3-2293-B4BD050F49BB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode joint -n "R_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "6F55F428-4E55-CE2B-6D7C-1A9942EEBB25";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_FK_DRV_JNT" -p "R_thigh_FK_DRV_JNT";
	rename -uid "CFFD077D-4477-EC46-C581-34B5B0E58C6E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_FK_DRV_JNT" -p "R_calf_FK_DRV_JNT";
	rename -uid "65F250BB-4648-943E-740F-93B51153C793";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode joint -n "R_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "8D5F0C99-4D0E-9BDA-80BA-779506548C5F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_IK_DRV_JNT" -p "R_thigh_IK_DRV_JNT";
	rename -uid "65AA0F4D-468E-B812-ED0B-7597C197FC40";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_IK_DRV_JNT" -p "R_calf_IK_DRV_JNT";
	rename -uid "9838156A-46BD-F986-FA80-C9B8912C0561";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode ikEffector -n "effector4" -p "R_calf_IK_DRV_JNT";
	rename -uid "AB5C7A46-495B-4A77-9382-F19DDB7B1A4F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode joint -n "C_chest_DRV_JNT" -p "MC_DEFORM";
	rename -uid "8FE0ABC6-420F-1052-C19E-418E04073DBC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode joint -n "C_head_DRV_JNT" -p "C_chest_DRV_JNT";
	rename -uid "DFDF474E-4B01-1CBD-21CB-8DB82C71F7E5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "head.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode transform -n "l_arm_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "819E9361-4686-9312-449F-7690A0FCF491";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.bendy.0.in|l_arm.bendy.0.out|l_arm.deform.1\"],[\"targets\",\"l_arm.bendy.0.0|l_arm.bendy.0.1|l_arm.bendy.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape1" -p "l_arm_bendy_0_CRV";
	rename -uid "B3C85B50-4E73-056B-1620-B6915DEA59F3";
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
	rename -uid "088F34B9-4436-57C5-2DE5-0C89B12CB53C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.bendy.1.in|l_arm.bendy.1.out|l_arm.deform.2\"],[\"targets\",\"l_arm.bendy.1.0|l_arm.bendy.1.1|l_arm.bendy.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape2" -p "l_arm_bendy_1_CRV";
	rename -uid "5D443938-424E-ED2B-5336-FEB6FC64869E";
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
	rename -uid "F4D72215-402E-EBA1-DAAE-689E0C94F7E9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.bendy.0.in|l_leg.bendy.0.out|l_leg.deform.1\"],[\"targets\",\"l_leg.bendy.0.0|l_leg.bendy.0.1|l_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape3" -p "l_leg_bendy_0_CRV";
	rename -uid "69FD7EDD-4AF7-30A3-2E13-1888CF982834";
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
	rename -uid "3492388B-4286-6532-1A8A-5DA7CD9597E8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.bendy.1.in|l_leg.bendy.1.out|l_leg.deform.2\"],[\"targets\",\"l_leg.bendy.1.0|l_leg.bendy.1.1|l_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape4" -p "l_leg_bendy_1_CRV";
	rename -uid "CD63F69C-44E1-8B84-954E-EDABB76DF3E7";
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
	rename -uid "32B1B5B7-46C5-73D1-D04E-69858FDF512D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.bendy.0.in|r_arm.bendy.0.out|r_arm.deform.1\"],[\"targets\",\"r_arm.bendy.0.0|r_arm.bendy.0.1|r_arm.bendy.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape5" -p "r_arm_bendy_0_CRV";
	rename -uid "A4C7E3EC-4531-C066-6655-0C8FFA8AEBEB";
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
	rename -uid "702713A1-4E34-5DD2-28A2-F6A54C39FB8A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.bendy.1.in|r_arm.bendy.1.out|r_arm.deform.2\"],[\"targets\",\"r_arm.bendy.1.0|r_arm.bendy.1.1|r_arm.bendy.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape6" -p "r_arm_bendy_1_CRV";
	rename -uid "D5D0546E-4F0D-7E01-8D7E-5D8336543CB3";
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
	rename -uid "044122E2-4FD6-181B-D84D-059CA3A25D0A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.bendy.0.in|r_leg.bendy.0.out|r_leg.deform.1\"],[\"targets\",\"r_leg.bendy.0.0|r_leg.bendy.0.1|r_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape7" -p "r_leg_bendy_0_CRV";
	rename -uid "7E95805F-40C1-BD03-47A5-04A17762AB62";
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
	rename -uid "43CB4B0C-44A7-E7F6-FD9E-B29D1EA039C7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.bendy.1.in|r_leg.bendy.1.out|r_leg.deform.2\"],[\"targets\",\"r_leg.bendy.1.0|r_leg.bendy.1.1|r_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape8" -p "r_leg_bendy_1_CRV";
	rename -uid "1E94CCF6-458A-3263-678F-8B90045E3C34";
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
	rename -uid "48832B5B-4F87-3586-7323-04B7DE9754A8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.delivery";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "29E38585-485B-BBFD-C8BA-748DD7BAF7B0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_01_JNT" -p "L_upperArm_BENDY_01_JNT";
	rename -uid "6677F988-4467-E686-664E-D5BE806B691B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "C83E27FF-4E51-1FB9-E010-339215BC4514";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_02_JNT" -p "L_upperArm_BENDY_02_JNT";
	rename -uid "446AF515-4D24-DE74-D41A-3DA13F370FD0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "1407696E-466E-BF02-F1EB-3C9B68CFF2F7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_03_JNT" -p "L_upperArm_BENDY_03_JNT";
	rename -uid "F6365C09-4F6A-AE25-F4FA-E6ADA0D4F51C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "59D2CBF3-45A4-2AA9-E5F0-15847616741B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_01_JNT" -p "L_forearm_BENDY_01_JNT";
	rename -uid "F30D8FF1-49C3-94F5-72C2-F8A013AFB387";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "21CC88E7-493E-CB4F-366B-3395085F269A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_02_JNT" -p "L_forearm_BENDY_02_JNT";
	rename -uid "B2128FFF-43A7-E6B9-BD9D-82969952C92C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "32953A9D-4086-3963-BD56-A3A1B759C171";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_03_JNT" -p "L_forearm_BENDY_03_JNT";
	rename -uid "57D7FF5A-42D4-ED0B-D095-3C8421DBDBEB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "345BB733-42A2-13B8-354F-E99843A8BBC9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_RESULT_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "D73D6A61-44CE-9CE3-2AD9-3EBC607F3DC3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_RESULT_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "EAB73A19-4A31-CA02-B3A7-C49FD8AEDFCB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "E20C713B-4084-C521-B8DE-E580B4A6D8DC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_01_JNT" -p "L_thigh_BENDY_01_JNT";
	rename -uid "3F85CC50-440B-3F1D-F1FF-CBA019CC82FA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "FD39D5B4-4B6E-7FD0-0320-BDA308FD5F34";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_02_JNT" -p "L_thigh_BENDY_02_JNT";
	rename -uid "EC67BC6C-48A1-FD78-5037-3FBBB725E5AF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "BC991ECE-49A9-0930-F811-269A2B24C915";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_03_JNT" -p "L_thigh_BENDY_03_JNT";
	rename -uid "DD29F880-4291-13B8-1A2A-FC984756FA19";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "BE17EBE1-4D5D-6ACF-8D7B-EAAF9481CB44";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_01_JNT" -p "L_calf_BENDY_01_JNT";
	rename -uid "D0A13FFC-47EE-9B52-5272-088017CEB025";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "256BA9D6-4308-0ECA-144C-3C92D8BD2659";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_02_JNT" -p "L_calf_BENDY_02_JNT";
	rename -uid "62E8D9F1-4DA4-0DE8-1942-9CB5AEC1A030";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "4C4EFF8D-49E3-B639-7485-14B983A73B94";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_03_JNT" -p "L_calf_BENDY_03_JNT";
	rename -uid "C42144E3-461D-3E80-117E-26B7E0C68312";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "DF155562-4A96-986D-8AB6-DA92271FE212";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_RESULT_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "6A55166B-448B-E0C0-7F0C-FCB5E00DA396";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_RESULT_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "7F0A82E3-46F0-753A-62AE-A9A79439EC49";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "R_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "842CA191-46D8-89F8-C1FA-278D8608AECD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_01_JNT" -p "R_upperArm_BENDY_01_JNT";
	rename -uid "7608A28C-467E-1CA7-53E6-F4B25D251B4A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "1BA69105-4F35-9F78-AFC2-788F49AA4A82";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_02_JNT" -p "R_upperArm_BENDY_02_JNT";
	rename -uid "3F24E415-498B-48F8-D90C-95AAEB23F067";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "68B4D131-49C0-FB15-90FC-9C9E6E38006D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_03_JNT" -p "R_upperArm_BENDY_03_JNT";
	rename -uid "838285E1-46DD-27E4-129B-BFB6C2ECB5EF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "AB4C78F7-4F68-EC98-D8A1-A98AA4B2657A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_01_JNT" -p "R_forearm_BENDY_01_JNT";
	rename -uid "FA1C9AEB-4B1D-2A62-F725-F1970AF14ACB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "0527643F-48BC-8A63-C533-5F8240111AC8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_02_JNT" -p "R_forearm_BENDY_02_JNT";
	rename -uid "CF5FCD11-48F0-60B8-688C-3EB7D139CC1F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "3474A59B-480F-8E3A-F336-D98EEB13CE85";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_03_JNT" -p "R_forearm_BENDY_03_JNT";
	rename -uid "EC022DC0-4EAE-704A-0FC7-BE9641B1282B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "B8835B24-493C-0D73-E19F-96B3723B9D74";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_RESULT_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "586C75F3-41BD-6FFF-09F4-E389F91F0E03";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_RESULT_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "00C8A952-4695-4E45-D979-45B0D499AA2B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "C70EC205-494A-7E6A-A7F2-33AECEED2ABE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_01_JNT" -p "R_thigh_BENDY_01_JNT";
	rename -uid "36DA5346-4143-09E2-4899-798728714181";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "596C825B-4FEB-1DEF-0F9B-F99FF80CA13F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_02_JNT" -p "R_thigh_BENDY_02_JNT";
	rename -uid "AE058C7C-4A71-07B1-5066-8D95D483B4CE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "1C7632A9-4E16-9150-B912-22B4DA926E17";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_03_JNT" -p "R_thigh_BENDY_03_JNT";
	rename -uid "BEEA3A86-4448-A587-FA83-EC84781D4D27";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "20C66217-4300-2D06-ABB7-E6A78DDAB3CF";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_01_JNT" -p "R_calf_BENDY_01_JNT";
	rename -uid "B839FF3E-4F01-F733-1394-79AC8D35394D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "54EDA773-428A-58C2-A166-18A14C26E21A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_02_JNT" -p "R_calf_BENDY_02_JNT";
	rename -uid "45793B3A-4D07-10B8-017F-CAAC370600BA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "7FD7D207-4355-6221-C093-F68F423E898C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_03_JNT" -p "R_calf_BENDY_03_JNT";
	rename -uid "92090DB3-43EE-0931-9B78-28AB686B0836";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "B2FABFEC-42FA-F29C-5292-CD84B52650A1";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_RESULT_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "0CF88133-4D31-21FB-7C40-81A8FDC397AB";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_RESULT_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "7588E2E6-484D-8B42-BAB2-EA8F347C562B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "6CF79FE4-4E20-0B93-5CB7-A28839C47CF3";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "AFDAB0EA-4A4B-19C5-F429-E8BA4ADCCA96";
createNode displayLayer -n "defaultLayer";
	rename -uid "5E044A23-4A6F-A606-374E-5ABEEF0BB9B9";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "E32EC531-4067-2651-DC11-339721F6085D";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "77EE39DC-42D8-DA11-FD5B-0C9E6E98B987";
	setAttr ".g" yes;
createNode multMatrix -n "head_drive_MMX";
	rename -uid "8E5A04E8-4437-A3C8-1F5C-AFA2CC096EED";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"head.ctrl\"],[\"targets\",\"head.deform\"]]";
createNode multMatrix -n "l_arm_bendy_0_CV0_MMX";
	rename -uid "6327FD2D-4C4E-CFD5-BD59-3B89C65063C8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV0_DCM";
	rename -uid "F2B93C7E-4335-E4AE-FAFD-C5AC274674CA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV1_MMX";
	rename -uid "D471D1D3-4E65-9C21-CBF8-8CA5979E662A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV1_DCM";
	rename -uid "8790D002-448D-62E9-0BA8-2085F6BAC598";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV2_MMX";
	rename -uid "30ACCC02-40C4-2464-5EC7-DB9DC3090467";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV2_DCM";
	rename -uid "7D84EE50-45EB-1795-3FD9-2BB210EE4D80";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV3_MMX";
	rename -uid "01A935A2-4C9E-8A2E-4554-A2B5BEF80DEB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV3_DCM";
	rename -uid "5C3CA267-4578-36F6-D96A-228F37403419";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode curveInfo -n "l_arm_bendy_0_ARC_CIF";
	rename -uid "5956440F-43D7-1AC5-6B0D-B8A329D6C757";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode distanceBetween -n "l_arm_bendy_0_CHORD_DST";
	rename -uid "0A5BD136-4E03-762B-C127-0286BA2F5769";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_STRETCH_DIV";
	rename -uid "04B53F27-4B45-D44C-EAED-1DB042903EEF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_EXP";
	rename -uid "32F44192-40EC-5DFD-38FF-809356B2BA6D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_POW";
	rename -uid "A6EBB048-47AB-FD67-CFD6-628AB5960B0E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode motionPath -n "l_arm_bendy_0_01_MOP";
	rename -uid "E82115C4-4A92-F70F-3CDB-E2A5CE53A798";
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
	rename -uid "A09C6D08-46FA-EE5F-1FB5-31BE198E4B6B";
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
	rename -uid "B5AA2370-49CC-0F6B-F35B-819A6A16861A";
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
	rename -uid "A773BB31-40E5-0B6F-B964-FBBC5035E4AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV0_DCM";
	rename -uid "37C018F4-4EA7-EB7D-8833-0FAB9F4204A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV1_MMX";
	rename -uid "075ADD34-44A5-3216-5119-5A9339100074";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV1_DCM";
	rename -uid "D74007FE-4D63-A9A0-EEF3-9ABA1587E398";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV2_MMX";
	rename -uid "3F9A19E1-4CB9-D790-D714-41A8222917AA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV2_DCM";
	rename -uid "5F9CF45F-4F28-E2A6-7122-0CA405D19684";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV3_MMX";
	rename -uid "C07EC524-43C2-489E-C8B9-4AA4B77A60B6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV3_DCM";
	rename -uid "45A6C617-400F-11B3-7F34-EAA9161CFD0A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode curveInfo -n "l_arm_bendy_1_ARC_CIF";
	rename -uid "067236FF-4CC8-790F-EA1E-A0817C3BAEC8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode distanceBetween -n "l_arm_bendy_1_CHORD_DST";
	rename -uid "CB580C14-4712-1413-1B27-4093EC98B705";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_STRETCH_DIV";
	rename -uid "802286B8-4EC7-9AE9-1448-37AF2B7FD9AF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_EXP";
	rename -uid "F214DFBD-4748-A543-E6D6-43B4E573EC04";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_POW";
	rename -uid "81A802C1-4D65-774F-A17A-BF8752F13ACC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode motionPath -n "l_arm_bendy_1_01_MOP";
	rename -uid "9D69A313-4188-0B88-094A-698FE976504A";
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
	rename -uid "CB8EACBC-471A-D8AD-68A0-999FFC421F2E";
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
	rename -uid "1F55BBD4-4F9D-22AF-25A2-C4B8415AF85E";
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
	rename -uid "D6EBCC88-4811-4580-7891-2080C8FA6AF3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.0|l_arm.ik_joint.0|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_0_CORRECT_CMP";
	rename -uid "09A6A424-4761-9FF7-4383-CFA41A5E33E4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_CORRECT_MMX";
	rename -uid "946B41C4-4948-2CE1-EABF-87AD08408126";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_LOCAL_MMX";
	rename -uid "EB08FD45-4083-3888-F3EA-FFB8F0AC41D3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode blendMatrix -n "l_arm_blend_1_BLM";
	rename -uid "0292F421-456B-E7B7-D091-EF9C2884F083";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.1|l_arm.ik_joint.1|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_1_CORRECT_CMP";
	rename -uid "F2F06EE6-45A6-EB56-6216-17930BEEDF11";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_CORRECT_MMX";
	rename -uid "7C218ECD-446A-30E9-2A59-48B7C08A6478";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_LOCAL_MMX";
	rename -uid "66804BAA-46B8-E4E4-F476-D2B54D058EF3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode blendMatrix -n "l_arm_blend_2_BLM";
	rename -uid "83E146DB-4653-B8F2-429F-C2B95F7CA1FF";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.2|l_arm.ik_joint.2|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_2_CORRECT_CMP";
	rename -uid "9F3FB002-41AF-8A93-ED11-73834A769F21";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_CORRECT_MMX";
	rename -uid "0581C4CF-4044-BC02-9AB5-ABB728C40743";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_LOCAL_MMX";
	rename -uid "88621C1F-488D-E39F-A467-DB87ADF837E3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_drive_0_MMX";
	rename -uid "54CDB27C-4455-9DE8-BC7F-DA8A38A3B968";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.0\"],[\"targets\",\"l_arm.fk_joint.0\"]]";
createNode multMatrix -n "l_arm_drive_1_MMX";
	rename -uid "5C2135F5-4688-57D3-FD86-2188752F70F1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.1\"],[\"targets\",\"l_arm.fk_joint.1\"]]";
createNode multMatrix -n "l_arm_drive_2_MMX";
	rename -uid "DFED5649-45C7-8492-1A71-F6B25D2DFD8F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.2\"],[\"targets\",\"l_arm.fk_joint.2\"]]";
createNode ikRPsolver -n "ikRPsolver";
	rename -uid "AB70960E-4935-B99C-F897-B8A347ED16F3";
createNode unitConversion -n "unitConversion1";
	rename -uid "56C0A01B-4692-06E8-A97A-D9A99B6C1376";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_arm_space_CHOICE";
	rename -uid "C88876CC-4E94-1170-197B-93847D1FCD79";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_arm_space_LOCAL_MMX";
	rename -uid "C743ACD9-409F-4F28-0CF8-2EBFD638AAB3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE0_MMX";
	rename -uid "E36BAEE2-450A-E3AE-32A6-279A9778B28B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE1_MMX";
	rename -uid "9BEAAA8E-4A96-8AFB-5D8D-D2A2C86E192E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_twist_0_REL_MMX";
	rename -uid "3BA9698C-4066-D982-99BD-8C89B3A5C578";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.deform.1\"],[\"targets\",\"l_arm.twist.0.0|l_arm.twist.0.1|l_arm.twist.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"startRole\",\"left_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_0_REL_DCM";
	rename -uid "88EB0B72-44D7-230C-DC79-4FA930FB359B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode vectorProduct -n "l_arm_twist_0_TWIST_DOT";
	rename -uid "FF309C90-40B5-D3FE-1927-34B8B17A13A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multiplyDivide -n "l_arm_twist_0_TWIST_PROJECT";
	rename -uid "F551184D-4594-240B-0035-B9A151371FAE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatNormalize -n "l_arm_twist_0_TWIST_NORM";
	rename -uid "8E117121-4B41-1799-6CE0-96B3C6FCF83F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_01_SLERP";
	rename -uid "0A750E4C-43A2-6D49-50DE-45AEBA0901CA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.0";
createNode quatToEuler -n "l_arm_twist_0_01_QTE";
	rename -uid "AAD3BCBD-46A6-FA80-F7D2-EAB17689257E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_02_SLERP";
	rename -uid "EE266EB8-46D3-8EDB-2B19-B7B0E6FAC0A7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.1";
createNode quatToEuler -n "l_arm_twist_0_02_QTE";
	rename -uid "E9E0BCE0-4C59-2CE8-06C1-EA8DA8F29063";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_03_SLERP";
	rename -uid "CAA5B6F2-4C58-501F-B929-FA91372D155C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.2";
createNode quatToEuler -n "l_arm_twist_0_03_QTE";
	rename -uid "C51DEB16-48D1-ADA5-091C-A1ABD67E2484";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multMatrix -n "l_arm_twist_1_REL_MMX";
	rename -uid "3EF4AA3B-4098-D120-CE26-0A8BD62183A9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.deform.2\"],[\"targets\",\"l_arm.twist.1.0|l_arm.twist.1.1|l_arm.twist.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"startRole\",\"left_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_1_REL_DCM";
	rename -uid "2B6E0787-4F28-C04B-0BC9-8780239C0BD7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode vectorProduct -n "l_arm_twist_1_TWIST_DOT";
	rename -uid "E6158FEF-46A0-35A4-F2E8-52941C77D06D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multiplyDivide -n "l_arm_twist_1_TWIST_PROJECT";
	rename -uid "1D935A1A-4033-5AE0-9E00-6996EA4EB3FD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatNormalize -n "l_arm_twist_1_TWIST_NORM";
	rename -uid "ED569F03-4304-383C-90CD-548A8FE240AB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_01_SLERP";
	rename -uid "B10B61CF-4482-07C6-7D13-2BA9BD3DECA1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.0";
createNode quatToEuler -n "l_arm_twist_1_01_QTE";
	rename -uid "38835496-4C5C-9EFE-45E6-D0800609A5E1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_02_SLERP";
	rename -uid "93E32126-4956-1432-E938-97B45C8F78A5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.1";
createNode quatToEuler -n "l_arm_twist_1_02_QTE";
	rename -uid "D707384F-429E-983D-108C-7182D4A4CE1F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_03_SLERP";
	rename -uid "4B8C29E5-4A20-566B-850F-668C0E15E0E3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.2";
createNode quatToEuler -n "l_arm_twist_1_03_QTE";
	rename -uid "ACAD1C0F-4D5C-48E6-76CE-F3AE10A902FF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multMatrix -n "l_leg_bendy_0_CV0_MMX";
	rename -uid "05DE5E02-41EC-C169-05E6-EDBE50E81DEB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV0_DCM";
	rename -uid "73E215FC-499B-E225-7910-63B29F481569";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV1_MMX";
	rename -uid "18502F3B-4BBB-2705-7FC4-C3BCBA1DB86C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV1_DCM";
	rename -uid "D8164629-4550-D6A0-A6A9-07915BC866D7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV2_MMX";
	rename -uid "E87587FA-424C-B71C-4B80-BA8A6775F134";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV2_DCM";
	rename -uid "669F0352-4302-6AE0-D559-A5996AF4414D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV3_MMX";
	rename -uid "D4C0DEBC-490D-11CB-6288-E7A487C337A6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV3_DCM";
	rename -uid "2515C26E-4A62-C6F6-4F4B-D688FD17DD70";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode curveInfo -n "l_leg_bendy_0_ARC_CIF";
	rename -uid "C75836FC-488E-1475-E5B1-A381D7466C4E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode distanceBetween -n "l_leg_bendy_0_CHORD_DST";
	rename -uid "900F1393-45AD-2039-6BD3-A09AD6402CB5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_STRETCH_DIV";
	rename -uid "01D27955-41EF-E1A8-0F07-3084A1DCD15E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_EXP";
	rename -uid "DA55FF00-4FE3-268F-DB0F-EAB9484FF37F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_POW";
	rename -uid "1F599A6F-4B32-5C9A-1CE0-B78AC11B3F53";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode motionPath -n "l_leg_bendy_0_01_MOP";
	rename -uid "4A67D687-4B40-81C9-924F-C9842FBBE1C8";
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
	rename -uid "6AFEAEC8-4483-989D-6392-33B4E3CCAD77";
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
	rename -uid "88F39A38-488D-CD9B-830D-D1BE541DF2CE";
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
	rename -uid "E2F4288C-4661-6B24-B9EC-CAA05CB25AA7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV0_DCM";
	rename -uid "6873E94F-44F2-8B23-7B87-C5956A4859F9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV1_MMX";
	rename -uid "FD119260-4B67-8967-04AC-C98FCDA0BF75";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV1_DCM";
	rename -uid "5D24753C-4878-3680-791A-7497A3749BF8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV2_MMX";
	rename -uid "74FE1523-4C01-39E2-622F-4C9191A43CED";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV2_DCM";
	rename -uid "032D0C02-43C6-618E-2F57-498820AA3914";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV3_MMX";
	rename -uid "FC6618D8-455C-A39C-D370-2B8656C23B80";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV3_DCM";
	rename -uid "643C59E7-4944-A543-228B-35A5E899CACF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode curveInfo -n "l_leg_bendy_1_ARC_CIF";
	rename -uid "19A6F465-48D8-DD95-2118-7E87F1EF1346";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode distanceBetween -n "l_leg_bendy_1_CHORD_DST";
	rename -uid "3901A9F6-4C9C-127D-81C1-FB8C2E76FD1C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_STRETCH_DIV";
	rename -uid "CA5EBE23-416F-B390-6665-1A9EA312A99D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_EXP";
	rename -uid "887B5D5F-48A4-C930-B528-9C84D39BB270";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_POW";
	rename -uid "517E8A4A-41D9-344A-46F2-D3AC862CC142";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode motionPath -n "l_leg_bendy_1_01_MOP";
	rename -uid "5E6A428E-40C2-230D-2080-02B115B029AE";
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
	rename -uid "AD89E75F-4401-A10B-9CE3-0CB029A6AD1C";
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
	rename -uid "A6DC4FBB-4BF4-A930-7541-3889146F384A";
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
	rename -uid "729F29AA-4663-8F76-A04C-20ADFB96AD83";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.0|l_leg.ik_joint.0|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_0_CORRECT_CMP";
	rename -uid "53558CC1-4EA3-DB6E-4E6C-F6B48C1CF3EA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_CORRECT_MMX";
	rename -uid "9E0086D2-4D8D-20F8-4D5A-01BACDFBB607";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_LOCAL_MMX";
	rename -uid "483D36BF-4FEC-FA0F-BDF1-2AA4BBDBB07A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode blendMatrix -n "l_leg_blend_1_BLM";
	rename -uid "869BFB02-42DE-ABF6-FDF7-75B5C24F1203";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.1|l_leg.ik_joint.1|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_1_CORRECT_CMP";
	rename -uid "765E13CA-4B69-375C-8E01-96AC2BED8CF8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_CORRECT_MMX";
	rename -uid "C5D75440-4D02-0BC9-0E68-419D4C4A54BB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_LOCAL_MMX";
	rename -uid "7EC88F83-4456-1A93-C0EA-47858D675DD6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode blendMatrix -n "l_leg_blend_2_BLM";
	rename -uid "BDB87E2C-44C4-FE98-E470-1FA7A58BCD6B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.2|l_leg.ik_joint.2|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_2_CORRECT_CMP";
	rename -uid "45406DBA-4555-C9FF-27F0-3E9508AE7527";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_CORRECT_MMX";
	rename -uid "68818485-4521-1042-165F-5889393DB16E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_LOCAL_MMX";
	rename -uid "0998A741-4ADB-E3D1-035D-B4A737EC7AE7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_drive_0_MMX";
	rename -uid "1DE084F9-4DBF-DDE9-1CB9-3597D6F3432B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.0\"],[\"targets\",\"l_leg.fk_joint.0\"]]";
createNode multMatrix -n "l_leg_drive_1_MMX";
	rename -uid "32E354E7-453D-60B6-4910-B79533C45E18";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.1\"],[\"targets\",\"l_leg.fk_joint.1\"]]";
createNode multMatrix -n "l_leg_drive_2_MMX";
	rename -uid "1D4FC365-43AC-C170-87ED-F68D76610F36";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.2\"],[\"targets\",\"l_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion2";
	rename -uid "82276CC8-4232-EBF5-D32C-878ABFD1F851";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_leg_space_CHOICE";
	rename -uid "80263489-49EB-4785-5605-75A78A4F54DC";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_leg_space_LOCAL_MMX";
	rename -uid "05A1F23E-417C-F8AB-6BA1-90AC16670BCA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE0_MMX";
	rename -uid "1477A589-44F5-5988-3147-7E983E141A21";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE1_MMX";
	rename -uid "F445B77A-46B5-3718-D5C8-308B89F99636";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_twist_0_REL_MMX";
	rename -uid "3AF6C230-4597-04D0-8B16-BEB789E975A7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.deform.1\"],[\"targets\",\"l_leg.twist.0.0|l_leg.twist.0.1|l_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"startRole\",\"left_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_0_REL_DCM";
	rename -uid "EA0CA2A2-4E64-61B5-1414-3B9683E3DF11";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode vectorProduct -n "l_leg_twist_0_TWIST_DOT";
	rename -uid "12A11A78-4A3A-87F4-7978-13BEA8A2AAAC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multiplyDivide -n "l_leg_twist_0_TWIST_PROJECT";
	rename -uid "BACD2371-4D22-6BC5-3DB3-999AE5763C73";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatNormalize -n "l_leg_twist_0_TWIST_NORM";
	rename -uid "177F66CA-4888-F178-7BBA-D89AD5EBE774";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_01_SLERP";
	rename -uid "536354D2-4486-9B13-9ACA-64BC47C0707A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.0";
createNode quatToEuler -n "l_leg_twist_0_01_QTE";
	rename -uid "88508461-4DC2-0642-05D7-609C5BE5FCCB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_02_SLERP";
	rename -uid "266E784D-410B-0802-BC4C-C4AADEF0AAF2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.1";
createNode quatToEuler -n "l_leg_twist_0_02_QTE";
	rename -uid "21E31B7B-4EE0-8304-39EC-B6A0AA08A94C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_03_SLERP";
	rename -uid "F78A5BB3-474A-F548-E0C9-9DB2BCC214CC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.2";
createNode quatToEuler -n "l_leg_twist_0_03_QTE";
	rename -uid "0B9EE494-4661-B9FF-5DA3-18AFF21DE575";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multMatrix -n "l_leg_twist_1_REL_MMX";
	rename -uid "1F5ABF07-4C88-75BA-435F-1D8C66006FFD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.deform.2\"],[\"targets\",\"l_leg.twist.1.0|l_leg.twist.1.1|l_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"startRole\",\"left_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_1_REL_DCM";
	rename -uid "9C45D1D3-4466-A897-B5BE-F9AEF0212E73";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode vectorProduct -n "l_leg_twist_1_TWIST_DOT";
	rename -uid "DAF129FA-4DFD-87D8-86F7-6BAA4105B91D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multiplyDivide -n "l_leg_twist_1_TWIST_PROJECT";
	rename -uid "BF6FBD1A-4FB9-A7A7-A73D-3CBA6599C998";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatNormalize -n "l_leg_twist_1_TWIST_NORM";
	rename -uid "EC41D660-46C0-4A00-A91C-DDA99720623E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_01_SLERP";
	rename -uid "0F162FCC-47ED-8D33-968B-56BCEE73EE79";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.0";
createNode quatToEuler -n "l_leg_twist_1_01_QTE";
	rename -uid "EE7A8667-46D5-F5F0-E496-C381E5F5F259";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_02_SLERP";
	rename -uid "78DF100C-449E-DB3A-E5FC-C4AC446317A6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.1";
createNode quatToEuler -n "l_leg_twist_1_02_QTE";
	rename -uid "56520A60-4379-C4B4-4BAD-0B8B54867E93";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_03_SLERP";
	rename -uid "E7EA7C3A-4BC3-D503-7319-47AF3D95D42B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.2";
createNode quatToEuler -n "l_leg_twist_1_03_QTE";
	rename -uid "46FDD4B1-42E0-67AE-5D5A-4D98CA578007";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multMatrix -n "r_arm_bendy_0_CV0_MMX";
	rename -uid "732801F0-4229-FC3A-6415-30971830E032";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV0_DCM";
	rename -uid "BF48916D-4E37-E120-660F-A8A4B9273D68";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV1_MMX";
	rename -uid "E5DB0FCC-4D89-2807-5F88-EEB5EE09FAD4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV1_DCM";
	rename -uid "FE71DB98-4BE9-0B54-F85D-8F85E22A7B68";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV2_MMX";
	rename -uid "36801E57-46AA-9033-AA4E-8F83AB8C8DE3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV2_DCM";
	rename -uid "727FD482-4921-926C-8B26-11960F3FC5B8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV3_MMX";
	rename -uid "0E799977-458C-A3DB-E1A1-269BEBFAE08F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV3_DCM";
	rename -uid "FBBA8347-4AF1-3359-EFE9-B0A0CE2E7E5D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode curveInfo -n "r_arm_bendy_0_ARC_CIF";
	rename -uid "058B0470-4D22-8513-D736-13952317D52C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode distanceBetween -n "r_arm_bendy_0_CHORD_DST";
	rename -uid "9B2922FA-4FAA-76F4-E599-0D95ED3DA57B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_STRETCH_DIV";
	rename -uid "BC9A318C-4923-BCD0-8625-5A8FBD35A4E2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_EXP";
	rename -uid "30FBE1AA-4FD3-6D6A-A84B-18B99229250E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_POW";
	rename -uid "D9371A12-4C1D-4C7D-D97B-F887E01FCCA3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode motionPath -n "r_arm_bendy_0_01_MOP";
	rename -uid "96AD80E2-467F-1B20-A8B7-2E9203917D0C";
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
	rename -uid "C632678C-4577-3243-1385-8AA484BE2F50";
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
	rename -uid "49404E76-4BB0-330D-F41E-2FBADEED5408";
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
	rename -uid "409D84AF-4C1D-8C75-0ABA-5285112F32F2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV0_DCM";
	rename -uid "3AFECE29-4174-0D61-BA8E-3AABDBDE1729";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV1_MMX";
	rename -uid "1EE07DC0-46C6-34A1-7D7B-8E8BE5AB2D54";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV1_DCM";
	rename -uid "635469FA-40C4-8F31-8FD2-13908B314CA7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV2_MMX";
	rename -uid "10C1A1B8-4B37-E8FA-ED42-0F9E506FC920";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV2_DCM";
	rename -uid "87E3D847-4591-5D45-3AAD-EB85121CBFC8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV3_MMX";
	rename -uid "282D2E85-4D8F-B039-DF9F-9597810F3331";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV3_DCM";
	rename -uid "B0C44AEB-411B-7F9D-9FFD-519DC8391D84";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode curveInfo -n "r_arm_bendy_1_ARC_CIF";
	rename -uid "38DF9D84-4616-5695-2604-FFA339E4924F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode distanceBetween -n "r_arm_bendy_1_CHORD_DST";
	rename -uid "B3310783-43C6-9189-011E-87A49D419CA2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_STRETCH_DIV";
	rename -uid "BA9A424C-42E8-E0FE-092B-399B6E66E327";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_EXP";
	rename -uid "783324C4-4ADB-F1F5-EF76-05A766069736";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_POW";
	rename -uid "ADF86B30-449A-5C2D-BFCF-D695098CED13";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode motionPath -n "r_arm_bendy_1_01_MOP";
	rename -uid "3B019AB8-4E5D-BFCC-C78B-478D33DF89AE";
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
	rename -uid "23C8A56E-4FDB-87E3-E392-8B9501D88D19";
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
	rename -uid "58EF6693-4B9E-16E8-34FE-E6B7930B57DA";
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
	rename -uid "09F55245-43ED-3B8E-F94A-5FB6827E6057";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.0|r_arm.ik_joint.0|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_0_CORRECT_CMP";
	rename -uid "8AD3F978-4BB3-C9C7-1063-98BB75098FAD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_CORRECT_MMX";
	rename -uid "175E9CED-4E81-C8E4-94C0-C1996E83DB88";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_LOCAL_MMX";
	rename -uid "C65821BF-42CA-E1DE-9D36-D7925C6DA6DC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode blendMatrix -n "r_arm_blend_1_BLM";
	rename -uid "D169EBE3-404C-6065-1FDC-37A96C3EA06E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.1|r_arm.ik_joint.1|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_1_CORRECT_CMP";
	rename -uid "72CB878B-4173-9DCD-0405-DFB3C07EBA07";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_CORRECT_MMX";
	rename -uid "E44F28DD-49CE-6177-6A3C-B6A05D90B63A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_LOCAL_MMX";
	rename -uid "8D8B8B52-4E40-112E-FA97-658B856A01F1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode blendMatrix -n "r_arm_blend_2_BLM";
	rename -uid "BB97023F-4C9A-3373-A60F-1096545D0F39";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.2|r_arm.ik_joint.2|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_2_CORRECT_CMP";
	rename -uid "5AAE2BE9-49F4-1969-1B14-3899FCFFF3F4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_CORRECT_MMX";
	rename -uid "9097BB01-4F58-A64A-7870-73BBE84B94F6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_LOCAL_MMX";
	rename -uid "B94ABFE6-44B0-36F0-0B28-5BA07D12CA5D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_drive_0_MMX";
	rename -uid "A586746E-4D1D-F2C0-2EB0-19B2EE278BF4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.0\"],[\"targets\",\"r_arm.fk_joint.0\"]]";
createNode multMatrix -n "r_arm_drive_1_MMX";
	rename -uid "0B586D10-4723-655E-5B3E-D7BC4FD9F6A8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.1\"],[\"targets\",\"r_arm.fk_joint.1\"]]";
createNode multMatrix -n "r_arm_drive_2_MMX";
	rename -uid "902867FF-49CC-5DD9-6885-9C88509DE380";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.2\"],[\"targets\",\"r_arm.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion3";
	rename -uid "3CA5EB59-417A-060B-844D-9DB380CAAFFC";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_arm_space_CHOICE";
	rename -uid "F651996C-4F0F-72BC-87E2-FAA6B6B45220";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_arm_space_LOCAL_MMX";
	rename -uid "BBA657CA-4EF7-1088-849D-11A86ACD0452";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE0_MMX";
	rename -uid "65D3E736-4B9B-C21B-44A0-9E8C24A18E26";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE1_MMX";
	rename -uid "216CFF3C-495F-0473-109F-B2B066AFAB6F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_twist_0_REL_MMX";
	rename -uid "B104C1F5-4974-0D34-0A98-BF985E1108F6";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.deform.1\"],[\"targets\",\"r_arm.twist.0.0|r_arm.twist.0.1|r_arm.twist.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"startRole\",\"right_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_0_REL_DCM";
	rename -uid "AD8F2E9C-4162-4D27-ECEF-B3B24755EA94";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode vectorProduct -n "r_arm_twist_0_TWIST_DOT";
	rename -uid "1DAD81A4-48DE-722B-A5E2-50A83918A4DE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multiplyDivide -n "r_arm_twist_0_TWIST_PROJECT";
	rename -uid "40141849-49E6-95B1-F613-D2941B7D1156";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatNormalize -n "r_arm_twist_0_TWIST_NORM";
	rename -uid "0C765597-4023-0BD6-0BC6-7DB2D63777F0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_01_SLERP";
	rename -uid "99264CD6-42D9-C7FE-5B1A-D395E7CE7290";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.0";
createNode quatToEuler -n "r_arm_twist_0_01_QTE";
	rename -uid "FDAAC329-4913-BAF4-A631-298B12A75AAA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_02_SLERP";
	rename -uid "F910D704-4444-739B-7781-9C9C0ED0ABC1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.1";
createNode quatToEuler -n "r_arm_twist_0_02_QTE";
	rename -uid "E97959EE-4BCC-24F5-53DB-EE9AFBFE920F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_03_SLERP";
	rename -uid "00F938FC-46F8-FEC2-F490-C89086B3DC11";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.2";
createNode quatToEuler -n "r_arm_twist_0_03_QTE";
	rename -uid "2713C0CF-483F-8B77-177D-64A73418814A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multMatrix -n "r_arm_twist_1_REL_MMX";
	rename -uid "5FFFABAB-4191-C42A-7309-61BD62E3B37D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.deform.2\"],[\"targets\",\"r_arm.twist.1.0|r_arm.twist.1.1|r_arm.twist.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"startRole\",\"right_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_1_REL_DCM";
	rename -uid "0E60D545-49BD-ED83-80D3-DEA87A33FA8A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode vectorProduct -n "r_arm_twist_1_TWIST_DOT";
	rename -uid "77AAE12B-46C3-1B47-B8A0-29AF14D4E8E2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multiplyDivide -n "r_arm_twist_1_TWIST_PROJECT";
	rename -uid "6F676A9E-40F2-E6E4-DB87-55842F48AA2A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatNormalize -n "r_arm_twist_1_TWIST_NORM";
	rename -uid "868E16DE-4CE8-19E6-DE55-76AC502F97B5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_01_SLERP";
	rename -uid "BEDFF8FB-422E-F904-F511-249658127B6D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.0";
createNode quatToEuler -n "r_arm_twist_1_01_QTE";
	rename -uid "41709968-4096-A44B-0B71-5EAE6A7A8B79";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_02_SLERP";
	rename -uid "58A6B2B3-4C52-8A4D-1CA0-6C988761184A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.1";
createNode quatToEuler -n "r_arm_twist_1_02_QTE";
	rename -uid "4218E04F-44E8-FCC9-7943-70B21006A5EA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_03_SLERP";
	rename -uid "39FD5782-414B-F02B-D5E2-0E88E1DA4022";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.2";
createNode quatToEuler -n "r_arm_twist_1_03_QTE";
	rename -uid "3D8FBFA4-4723-ECA5-720D-CDBA66DA0307";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multMatrix -n "r_leg_bendy_0_CV0_MMX";
	rename -uid "27D3C301-4FE4-695A-A174-9CB7793F60AF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV0_DCM";
	rename -uid "B41B867C-48BA-8278-7A76-379D59CF5416";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV1_MMX";
	rename -uid "D36C7A9F-4496-0FC1-DAC9-3F9A2B5FF0BB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV1_DCM";
	rename -uid "FA73C177-4962-416A-EC75-419B9E04B3A2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV2_MMX";
	rename -uid "02A479BF-4496-7685-963E-62848C575612";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV2_DCM";
	rename -uid "0DC52E83-4B2C-5183-E45A-40A768EF72F2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV3_MMX";
	rename -uid "835D8A3A-417D-5740-A85A-B492E70C88E0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV3_DCM";
	rename -uid "D910B838-4ACF-0AD1-7197-C48BA3EEBAF1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode curveInfo -n "r_leg_bendy_0_ARC_CIF";
	rename -uid "CE1BBD63-4716-0A33-2C20-DDAD6707787E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode distanceBetween -n "r_leg_bendy_0_CHORD_DST";
	rename -uid "8A0812B0-4999-105D-7573-86A2C5FE2116";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_STRETCH_DIV";
	rename -uid "71822E90-4FF5-BEC5-BA63-3E86D4911B7F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_EXP";
	rename -uid "7BD53519-4164-B069-9055-FC8029EA1202";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_POW";
	rename -uid "5A42ED4E-4D47-CD6F-80DC-129044339217";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode motionPath -n "r_leg_bendy_0_01_MOP";
	rename -uid "92DBB9D4-447C-3B5C-5147-E8AC843E09BA";
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
	rename -uid "C3DD7493-49C0-3DFB-A2BB-0586988E35F6";
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
	rename -uid "9D6F33BA-49FB-AB2C-358C-919A3EF74F26";
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
	rename -uid "467F39BF-42EA-7E6F-EBAD-53962305EF47";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV0_DCM";
	rename -uid "9F8A2495-40D5-A4D3-92DC-06B18E439238";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV1_MMX";
	rename -uid "FAF688E8-47C5-F3B4-5CC0-358590D371F3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV1_DCM";
	rename -uid "FD6E501E-4752-237B-FA8C-56BE94B23B47";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV2_MMX";
	rename -uid "0BA133DB-40B9-A725-6AD6-72A84E6D7DFA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV2_DCM";
	rename -uid "957B4FC3-4C77-2B3D-45DB-42BE77D810A3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV3_MMX";
	rename -uid "FCA1235B-4BED-0A50-EC0A-E8BA3E9B3E77";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV3_DCM";
	rename -uid "EC384E77-46F9-46BC-6978-87921D5DF1C5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode curveInfo -n "r_leg_bendy_1_ARC_CIF";
	rename -uid "2DCAE14E-45B0-12C9-9AB0-6CA42A9068DD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode distanceBetween -n "r_leg_bendy_1_CHORD_DST";
	rename -uid "D42FB46F-4D35-FFEB-09D2-099B18251CC7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_STRETCH_DIV";
	rename -uid "79FAC160-4EA9-5FF2-438D-108B464676D1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_EXP";
	rename -uid "9B3E1059-41E7-7C80-EA19-E580AC533A0A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_POW";
	rename -uid "664F0C7D-4DFC-3BF5-66D0-129ADF71AB01";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode motionPath -n "r_leg_bendy_1_01_MOP";
	rename -uid "6EB23D85-4E11-48AD-EF2D-6D9BA3BEB5E1";
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
	rename -uid "1A44D4EB-4731-88E5-AA6F-E0A117C2B93A";
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
	rename -uid "A3B6CA77-423A-45E5-5B86-BDB19644303A";
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
	rename -uid "546A0834-42B4-F386-EB06-29A3F4AF2B4A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.0|r_leg.ik_joint.0|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_0_CORRECT_CMP";
	rename -uid "A4DADFD7-4409-DAA0-3FD8-0FB0F780DBB8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_CORRECT_MMX";
	rename -uid "A9B51609-4FC8-F27A-B443-F68BE650BE5F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_LOCAL_MMX";
	rename -uid "14602BB2-4900-951F-7338-B690BDD9CA99";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode blendMatrix -n "r_leg_blend_1_BLM";
	rename -uid "66878E02-4FC6-46B0-0957-C098007417DC";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.1|r_leg.ik_joint.1|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_1_CORRECT_CMP";
	rename -uid "5D960422-4307-F56A-4728-E98341559A11";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_CORRECT_MMX";
	rename -uid "2EFD5C04-4D81-B055-BB8F-5298ADD43666";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_LOCAL_MMX";
	rename -uid "CEF91F45-4A41-DFBA-9515-C8BAF7A0524F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode blendMatrix -n "r_leg_blend_2_BLM";
	rename -uid "5DC18D41-4988-D12E-08E5-078A3F17AFC9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.2|r_leg.ik_joint.2|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_2_CORRECT_CMP";
	rename -uid "683AC7E0-4D1E-A011-C6B4-A084CDE414ED";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_CORRECT_MMX";
	rename -uid "BA1D11C1-49C0-846A-AC5F-2A8E300F2ABA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_LOCAL_MMX";
	rename -uid "B135F14C-4205-BCBF-2B5C-D599E52AEFA3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_drive_0_MMX";
	rename -uid "0C3B486C-4B67-A6CC-78E1-3EBA2394B34A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.0\"],[\"targets\",\"r_leg.fk_joint.0\"]]";
createNode multMatrix -n "r_leg_drive_1_MMX";
	rename -uid "61A785F1-4FF6-2F36-A6D8-09B21542AE26";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.1\"],[\"targets\",\"r_leg.fk_joint.1\"]]";
createNode multMatrix -n "r_leg_drive_2_MMX";
	rename -uid "7CD0B24E-4341-1CE9-CC72-309B2CC14D11";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.2\"],[\"targets\",\"r_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion4";
	rename -uid "15F5CFD1-48DD-F671-0A24-D2A7809FFFC9";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_leg_space_CHOICE";
	rename -uid "BEAA0A2F-4799-3197-DB7E-A1B518ED0650";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_leg_space_LOCAL_MMX";
	rename -uid "98435C59-44C1-906D-FC89-CBBF45F3DB30";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE0_MMX";
	rename -uid "1725F3B4-4742-874B-B7E2-A1B1BDFAB41B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE1_MMX";
	rename -uid "E65F4CE3-4A24-D911-FC27-FCB34794A52A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_twist_0_REL_MMX";
	rename -uid "CB62F11E-489B-25C6-E4F4-1EBE9869D0DF";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.deform.1\"],[\"targets\",\"r_leg.twist.0.0|r_leg.twist.0.1|r_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"startRole\",\"right_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_0_REL_DCM";
	rename -uid "36E72A94-4751-75C8-666C-B783743C8396";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode vectorProduct -n "r_leg_twist_0_TWIST_DOT";
	rename -uid "46E60261-4D94-5D97-2AFD-7EA95C4E06AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multiplyDivide -n "r_leg_twist_0_TWIST_PROJECT";
	rename -uid "F6C4D96D-4340-19DC-5448-B09646D190C4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatNormalize -n "r_leg_twist_0_TWIST_NORM";
	rename -uid "A4C357E5-4022-3A5B-1A25-07B626986487";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_01_SLERP";
	rename -uid "FB5B103D-4AFF-DC7B-23E1-A4A6A1B4A383";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.0";
createNode quatToEuler -n "r_leg_twist_0_01_QTE";
	rename -uid "6EB6D764-4EFC-8266-31FD-9C84A3C44AFC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_02_SLERP";
	rename -uid "2D503B6C-4091-5C75-A12E-29856EB1984C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.1";
createNode quatToEuler -n "r_leg_twist_0_02_QTE";
	rename -uid "6736F05A-442D-9042-F061-FD9B8ADF0431";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_03_SLERP";
	rename -uid "A121340A-46F8-41A9-258D-AD93CB8A467B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.2";
createNode quatToEuler -n "r_leg_twist_0_03_QTE";
	rename -uid "C196E49C-42EA-CBA7-1DD8-B49222AB91FB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multMatrix -n "r_leg_twist_1_REL_MMX";
	rename -uid "F5397579-44F3-A102-151D-A0882722168E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.deform.2\"],[\"targets\",\"r_leg.twist.1.0|r_leg.twist.1.1|r_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"startRole\",\"right_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_1_REL_DCM";
	rename -uid "6F197C52-4D67-37BE-D46B-B5BEE9518938";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode vectorProduct -n "r_leg_twist_1_TWIST_DOT";
	rename -uid "B72830BE-49DA-4842-E9EC-1EBEBAFC0DCC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multiplyDivide -n "r_leg_twist_1_TWIST_PROJECT";
	rename -uid "828D135B-485C-AB74-5156-62843B0DB1FC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatNormalize -n "r_leg_twist_1_TWIST_NORM";
	rename -uid "D549AA92-404A-1FF9-E10A-9C955AAC1A87";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_01_SLERP";
	rename -uid "A4D7279F-4EB5-8EC0-8DDD-4985C8AA86A2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.0";
createNode quatToEuler -n "r_leg_twist_1_01_QTE";
	rename -uid "FFE8A27D-4D9D-4D12-DF80-B8B17307EFB2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_02_SLERP";
	rename -uid "39EC8342-4047-8B77-17F5-14A80BFF637C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.1";
createNode quatToEuler -n "r_leg_twist_1_02_QTE";
	rename -uid "9B192C26-4A32-0BD3-C59B-17BD7C79F4AE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_03_SLERP";
	rename -uid "19A1C861-426B-D6EC-9479-E6A785709A1D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.2";
createNode quatToEuler -n "r_leg_twist_1_03_QTE";
	rename -uid "25490635-44F5-3053-A1D5-FD9A9BC0FC84";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multMatrix -n "spine_drive_MMX";
	rename -uid "9896A316-4D1C-935D-6DCF-5FA362C92A4B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoBendySculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"spine.ctrl\"],[\"targets\",\"spine.deform\"]]";
createNode animCurveTA -n "L_forearm_FK_CTRL_rotateX";
	rename -uid "4A162E7F-4F00-F315-89D5-7DB8ABB88425";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 75 24 -40;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "59F2A370-4A1E-BA80-EEC9-F9BF548DB83A";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "110AAB6A-4021-9D5A-4D58-73AD4C1AFDBD";
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
connectAttr "L_forearm_FK_CTRL_rotateX.o" "L_forearm_FK_CTRL.rx";
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
// End of mayacraft_bendy_sculpt.ma
