//Maya ASCII 2025ff03 scene
//Name: mayacraft_twist_sculpt.ma
//Last modified: Sun, Aug 30, 2026 07:20:52 PM
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
fileInfo "UUID" "4433B24A-42BD-56BB-AAD6-AEA68059CC71";
createNode transform -s -n "persp";
	rename -uid "FC8449E8-4004-7E8B-9966-BF80A4F5B5BA";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "0E795B2B-4B20-8AC7-E770-D4A646F32F13";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "8C1AEC04-4D83-0FC5-B805-9F93C9C11D08";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "7BD79C49-4AC9-929A-84E7-EB9FED423982";
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
	rename -uid "783F9A7E-46B3-2170-DDB2-1A8D733D9038";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "F5AF156E-43E0-13CD-B344-D2A3977558BD";
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
	rename -uid "AE5B50A9-4AB0-D923-EE83-9E96FC1F5752";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "E89028DA-4AC7-8A62-60DB-F88952199247";
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
	rename -uid "26EDA6FF-4674-45AA-90B1-7A947A8E2BF0";
	addAttr -ci true -sn "mayacraftDemoScenario" -ln "mayacraftDemoScenario" -dt "string";
	addAttr -ci true -sn "mayacraftExpectedResult" -ln "mayacraftExpectedResult" -dt "string";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".mayacraftDemoScenario" -type "string" "QUATERNION_TWIST_SCULPT";
	setAttr ".mayacraftExpectedResult" -type "string" "�� 12 ֡��� 90 �ȴ� Twist��Ԥ��ƫ�����ߺ�Ӧ�ã���öʵʱ�ؽڰ� quaternion slerp ���䲢�ɳ���";
createNode joint -n "pelvis_JNT" -p "root_JNT";
	rename -uid "A0FE124E-4C7F-2C45-60EB-759680C6A024";
	setAttr ".t" -type "double3" 0 10 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "spine_JNT" -p "pelvis_JNT";
	rename -uid "B5EE9191-4B74-9924-E972-9E9E428F6B36";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "chest_JNT" -p "spine_JNT";
	rename -uid "B49024F6-4F79-5D94-46F6-7EB88F096CCC";
	setAttr ".t" -type "double3" 0 4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "neck_JNT" -p "chest_JNT";
	rename -uid "16C973F8-404D-2A0E-BE48-33BAFAAE646B";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "head_JNT" -p "neck_JNT";
	rename -uid "6947863D-49AB-2760-10F7-8D9B182C980C";
	setAttr ".t" -type "double3" 0 3 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_upperArm_JNT" -p "chest_JNT";
	rename -uid "80F0917C-43DB-E266-401D-54A710DA58BC";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_forearm_JNT" -p "L_upperArm_JNT";
	rename -uid "D2E60C16-4EB5-9AB2-E877-E2B5D58AAEF2";
	setAttr ".t" -type "double3" 4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_hand_JNT" -p "L_forearm_JNT";
	rename -uid "0E3A74D9-4A41-92B6-99D1-39825658D1E5";
	setAttr ".t" -type "double3" 3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_upperArm_JNT" -p "chest_JNT";
	rename -uid "12D638F5-4609-A4DE-00ED-9787F4EFEE93";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_forearm_JNT" -p "R_upperArm_JNT";
	rename -uid "735810B6-435C-44EE-459F-5BB6DB600106";
	setAttr ".t" -type "double3" -4 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_hand_JNT" -p "R_forearm_JNT";
	rename -uid "EB515DCD-4B04-F89D-2AF6-AC9C9A7EBC45";
	setAttr ".t" -type "double3" -3 0 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_thigh_JNT" -p "pelvis_JNT";
	rename -uid "9F10A53A-45D1-FB1D-75DD-AEAD7630CAFF";
	setAttr ".t" -type "double3" 3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_calf_JNT" -p "L_thigh_JNT";
	rename -uid "4CB5C4C7-4061-7631-B1B7-51BDA5E43E19";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "L_foot_JNT" -p "L_calf_JNT";
	rename -uid "18F48DAB-41BA-D101-E22A-859328D2D79F";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_thigh_JNT" -p "pelvis_JNT";
	rename -uid "633D1D0C-4F37-BFA7-B819-6EB2020F26FE";
	setAttr ".t" -type "double3" -3 -1 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_calf_JNT" -p "R_thigh_JNT";
	rename -uid "196F5F34-4DE1-0464-C8C9-9890C4ADDD5E";
	setAttr ".t" -type "double3" 0 -4 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode joint -n "R_foot_JNT" -p "R_calf_JNT";
	rename -uid "154D253B-4FE3-D42B-4184-1E9305EF0AE9";
	setAttr ".t" -type "double3" 0 -4 1 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
createNode transform -n "MC_RIG";
	rename -uid "81010798-419E-1585-CA3C-B7878CD10D86";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.root";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "MC_CONTROLS" -p "MC_RIG";
	rename -uid "02A96154-417B-F663-167B-45819E76B25B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.controls";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_arm_MOD" -p "MC_CONTROLS";
	rename -uid "19520AC4-43BC-45F2-1977-CD917F696146";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_upperArm_BENDY_IN_CTRL" -p "L_arm_MOD";
	rename -uid "7334F19A-4A46-2991-BF66-F2AB5454EB20";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_IN_CTRLShape" -p "L_upperArm_BENDY_IN_CTRL";
	rename -uid "FDE87A8B-40FA-436B-1088-5FAA860F8708";
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
	rename -uid "0127EA6A-4147-181D-AB57-2F9B3C3CDE58";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_BENDY_OUT_CTRLShape" -p "L_upperArm_BENDY_OUT_CTRL";
	rename -uid "656C76C9-4A22-4AB4-75CC-0CBAD2C03BD9";
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
	rename -uid "E8BB642D-4F9D-EF74-A43F-CA98457F3CDE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_IN_CTRLShape" -p "L_forearm_BENDY_IN_CTRL";
	rename -uid "63FE3B57-49C8-8381-3F33-1CA10DDD5317";
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
	rename -uid "D8D6E45C-4F42-09FA-A0B5-73A67A0340F0";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_BENDY_OUT_CTRLShape" -p "L_forearm_BENDY_OUT_CTRL";
	rename -uid "4D442ABF-493D-8240-32DF-D3B1F889C7E7";
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
	rename -uid "29DCCA26-41A1-3FD5-8CFA-7FBC8F870EBD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode nurbsCurve -n "L_upperArm_FK_CTRLShape" -p "L_upperArm_FK_CTRL";
	rename -uid "BFC96696-428A-76EF-35DE-D985B5A0C070";
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
	rename -uid "E978BBB6-45F9-D21C-B35D-0CAD40AD9C7D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_forearm_FK_CTRLShape" -p "L_forearm_FK_CTRL";
	rename -uid "108D0D36-4F6C-BFA6-5F74-3AB6F954BA3A";
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
	rename -uid "C526645C-4EB0-4E04-147C-C08E0412DA84";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode nurbsCurve -n "L_hand_FK_CTRLShape" -p "L_hand_FK_CTRL";
	rename -uid "3B8F20E1-4063-E8DC-B5AB-919705B8ECAB";
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
	rename -uid "68FE430E-4611-9D08-1C23-E087C9505335";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_hand_IK_CTRL" -p "L_arm_IK_SPACE";
	rename -uid "78901909-4DD6-A9FA-04AA-54B7A38F9F49";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
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
	rename -uid "8EBC42AE-4203-B521-455F-E282956F4B7B";
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
	rename -uid "3AB6A6F1-4C01-499C-E768-758274A4B72C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.ik.ctrl|l_arm.pole.ctrl\"],[\"targets\",\"l_arm.ik_joint.0|l_arm.ik_joint.1|l_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_arm_rp_ik_PVC" -p "l_arm_rp_ik_IKH";
	rename -uid "E09BDC95-4430-6265-9471-A38DDDF01CAF";
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
	rename -uid "8BBE47A9-458E-05AB-EA1C-9197184D607E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_arm|left_lower_arm|left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode nurbsCurve -n "L_arm_POLE_CTRLShape" -p "L_arm_POLE_CTRL";
	rename -uid "988D3005-4E7A-1301-921D-2F99EBE45016";
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
	rename -uid "9F27831C-4A26-DB36-4143-77A431292D68";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_thigh_BENDY_IN_CTRL" -p "L_leg_MOD";
	rename -uid "14E695BF-4206-CA9D-0DE8-FB8627ECEC63";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_IN_CTRLShape" -p "L_thigh_BENDY_IN_CTRL";
	rename -uid "FF5D201E-46F9-011A-72D6-26B06F81B8D1";
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
	rename -uid "4509B1FB-4BF0-8EEF-76D4-28A4FC5999D6";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_BENDY_OUT_CTRLShape" -p "L_thigh_BENDY_OUT_CTRL";
	rename -uid "EB74B062-4C93-5097-3AF8-6B8295380776";
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
	rename -uid "4947BF2C-4E5D-0C9F-0C11-C787E51A8B20";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_IN_CTRLShape" -p "L_calf_BENDY_IN_CTRL";
	rename -uid "2876CBB5-4DBC-9791-4516-09BC835C2422";
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
	rename -uid "EFAA4C4D-4E13-E174-3F52-4FA55CC361CB";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_BENDY_OUT_CTRLShape" -p "L_calf_BENDY_OUT_CTRL";
	rename -uid "A156C6B4-4E9C-60AE-B5C4-D0AB6A208903";
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
	rename -uid "031552A4-49C6-839E-DCA5-A2BACA46C642";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode nurbsCurve -n "L_thigh_FK_CTRLShape" -p "L_thigh_FK_CTRL";
	rename -uid "145FD215-4BD8-A368-191E-7CA0E20B18AA";
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
	rename -uid "45341CA7-4980-4C8D-0ADB-DAAA2CC2FEC5";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_calf_FK_CTRLShape" -p "L_calf_FK_CTRL";
	rename -uid "E350F9CA-46F3-3C81-90E0-37BAD6044235";
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
	rename -uid "28250EBA-4294-A3AC-476A-EBBD5243E826";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode nurbsCurve -n "L_foot_FK_CTRLShape" -p "L_foot_FK_CTRL";
	rename -uid "FA01D730-4D8D-21AD-9C13-489211F31BF1";
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
	rename -uid "F6A975AC-4DA5-2355-4FA3-FF9BF782347A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "L_foot_IK_CTRL" -p "L_leg_IK_SPACE";
	rename -uid "CCE6E262-4841-8237-9FCF-15A85399A71B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
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
	rename -uid "4953495D-4D28-A136-CBBC-9BA9F6E8413B";
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
	rename -uid "8FF837DA-43E4-113D-AFEC-F8AB5DAA6C73";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.ik.ctrl|l_leg.pole.ctrl\"],[\"targets\",\"l_leg.ik_joint.0|l_leg.ik_joint.1|l_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "l_leg_rp_ik_PVC" -p "l_leg_rp_ik_IKH";
	rename -uid "FD7609C2-442F-541F-8E53-70BF493E84BD";
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
	rename -uid "1F83C9A9-4DE2-78EB-34B7-E689F211219D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"left_upper_leg|left_lower_leg|left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode nurbsCurve -n "L_leg_POLE_CTRLShape" -p "L_leg_POLE_CTRL";
	rename -uid "7542CE41-4F06-56D1-BFC7-69975DA0F86E";
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
	rename -uid "A5EB9264-472F-346D-FD1B-7294C262867A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_upperArm_BENDY_IN_CTRL" -p "R_arm_MOD";
	rename -uid "3B4A3CB5-45E6-D87F-07D4-92A0962CFB61";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5.32,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_IN_CTRLShape" -p "R_upperArm_BENDY_IN_CTRL";
	rename -uid "956DFB17-4AF3-99CF-32B8-B1911CFE88FE";
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
	rename -uid "3983D233-4426-D4A1-D990-2FB370E1278A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6.68,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_BENDY_OUT_CTRLShape" -p "R_upperArm_BENDY_OUT_CTRL";
	rename -uid "70EBF671-4FCB-F961-6610-338FC9A96133";
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
	rename -uid "445B1B11-4E81-146C-C647-EF877C3672E8";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.99,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_IN_CTRLShape" -p "R_forearm_BENDY_IN_CTRL";
	rename -uid "4344F0E0-4A60-7E4E-019C-AF8F6EB039C9";
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
	rename -uid "F43FFA67-43C3-02C9-D8B2-AEAD57D50F01";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.01,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_BENDY_OUT_CTRLShape" -p "R_forearm_BENDY_OUT_CTRL";
	rename -uid "E2D1E7C5-420F-6D4B-CF2E-98B6DD3C49FE";
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
	rename -uid "881A84B2-4453-1409-6460-E8BFDA525649";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode nurbsCurve -n "R_upperArm_FK_CTRLShape" -p "R_upperArm_FK_CTRL";
	rename -uid "5C0E6E6C-43A3-EE21-0BE2-B5B65F8BA40E";
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
	rename -uid "60EEF2B1-4BBB-5AC5-B9EA-F19376219241";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_forearm_FK_CTRLShape" -p "R_forearm_FK_CTRL";
	rename -uid "D066F822-4CC6-1E0D-09B1-2AAA6C5446F7";
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
	rename -uid "92C02297-4583-5FC6-9695-7B9F893CC3BA";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode nurbsCurve -n "R_hand_FK_CTRLShape" -p "R_hand_FK_CTRL";
	rename -uid "38CDDC09-41A0-DDE0-E981-4FA0F704E9E0";
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
	rename -uid "0B86EF46-445C-D5D2-839A-E49F3E997C5C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_hand_IK_CTRL" -p "R_arm_IK_SPACE";
	rename -uid "36273DEA-494A-7DA9-976C-0F9157852F76";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
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
	rename -uid "5647AFD1-43E8-B470-6BEC-B5AFAAE9EA78";
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
	rename -uid "E96D007D-45D2-4E18-F36E-0D9744DA2975";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.ik.ctrl|r_arm.pole.ctrl\"],[\"targets\",\"r_arm.ik_joint.0|r_arm.ik_joint.1|r_arm.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_arm_rp_ik_PVC" -p "r_arm_rp_ik_IKH";
	rename -uid "955A100C-487E-1501-00F9-73850517D7E4";
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
	rename -uid "CC1F0F05-4E6B-EFFB-CA0D-4392D6CE6DA0";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_arm|right_lower_arm|right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,-4.55\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode nurbsCurve -n "R_arm_POLE_CTRLShape" -p "R_arm_POLE_CTRL";
	rename -uid "E60E9F69-4CC9-8654-1403-3581F3C6F073";
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
	rename -uid "404E0317-4A58-4BD1-F27A-E485EF94830B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_thigh_BENDY_IN_CTRL" -p "R_leg_MOD";
	rename -uid "B5783BE5-4D1E-89D5-CB93-A59BEDF69B7B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7.68,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_IN_CTRLShape" -p "R_thigh_BENDY_IN_CTRL";
	rename -uid "8D034A7E-41D6-98AD-4D2B-0AA1FA305B08";
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
	rename -uid "61ED4EFA-423F-1EBB-5116-9CAD5021D1A1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6.32,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_BENDY_OUT_CTRLShape" -p "R_thigh_BENDY_OUT_CTRL";
	rename -uid "E5FB3D04-4601-886F-8498-8191F9897797";
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
	rename -uid "8DA02975-423F-97DF-3F34-65B8CCEF766C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.33\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"customFloat:volume\",\"0.65|0|1\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3.68,0.33\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr -k on ".volume";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_IN_CTRLShape" -p "R_calf_BENDY_IN_CTRL";
	rename -uid "7D94FF77-430D-DBC7-2418-7B92E5DC867A";
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
	rename -uid "227B271A-4D69-675F-EBBD-67B0D1B99838";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.67\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"controlShape\",\"circle\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2.32,0.67\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_BENDY_OUT_CTRLShape" -p "R_calf_BENDY_OUT_CTRL";
	rename -uid "32735A60-4A20-2AF0-062C-609D192298F6";
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
	rename -uid "08FCA3F5-4758-E978-1175-BDB3CBFA3BA4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode nurbsCurve -n "R_thigh_FK_CTRLShape" -p "R_thigh_FK_CTRL";
	rename -uid "662F0A49-44B3-6AF0-275F-709A271BDADA";
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
	rename -uid "F89CE922-4070-8DE9-5282-AE872CBF64FD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_calf_FK_CTRLShape" -p "R_calf_FK_CTRL";
	rename -uid "D9A1F5F9-43DB-1B01-4255-7683CDBBCCD1";
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
	rename -uid "BEB9C854-493B-FBAD-9690-27A4BEC1679F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode nurbsCurve -n "R_foot_FK_CTRLShape" -p "R_foot_FK_CTRL";
	rename -uid "E9216855-4ACD-DAE4-367E-DAA84CF01631";
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
	rename -uid "594580BD-454A-7364-62E0-1BB0326167E8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.ik.space";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "R_foot_IK_CTRL" -p "R_leg_IK_SPACE";
	rename -uid "373EB9BB-4DAD-3087-A07F-8D8779F7B00A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
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
	rename -uid "7C8A86C3-4AFD-0FBE-A1CD-36A3CA38D5D4";
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
	rename -uid "EC49DF0B-4ED8-CB60-1015-FFB47CA84F69";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.ik.ctrl|r_leg.pole.ctrl\"],[\"targets\",\"r_leg.ik_joint.0|r_leg.ik_joint.1|r_leg.ik_joint.2\"],[\"solver\",\"ikRPsolver\"]]";
createNode poleVectorConstraint -n "r_leg_rp_ik_PVC" -p "r_leg_rp_ik_IKH";
	rename -uid "E695E263-42FB-1435-60E6-3281849E444B";
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
	rename -uid "F01F1D92-4B2F-F5FD-189C-6297AFBE5BAA";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"diamond\"],[\"poleRoles\",\"right_upper_leg|right_lower_leg|right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4.34509429,-5.2392457\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode nurbsCurve -n "R_leg_POLE_CTRLShape" -p "R_leg_POLE_CTRL";
	rename -uid "207E62A1-4795-AAA4-DF74-609396BC7F27";
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
	rename -uid "B489A10B-4963-362C-E417-D29A6E019FDC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.module";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "meta";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode transform -n "C_chest_FK_CTRL" -p "C_spine_MOD";
	rename -uid "660A0083-4BDC-A687-60CB-84903B9485BD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode nurbsCurve -n "C_chest_FK_CTRLShape" -p "C_chest_FK_CTRL";
	rename -uid "B994FD3E-4577-8777-BC32-128EBBFC42CD";
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
	rename -uid "A528CC0E-4C6E-2F48-5629-069964699C65";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "control";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"controlShape\",\"circle\"],[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode nurbsCurve -n "C_head_FK_CTRLShape" -p "C_head_FK_CTRL";
	rename -uid "451D2100-44FE-3E56-B9A6-68849BEA0549";
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
	rename -uid "77197080-4E85-1C5D-AB89-4D9A691C5D89";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "108B7443-472E-1630-4915-77B4E6C266E9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_FK_DRV_JNT" -p "L_upperArm_FK_DRV_JNT";
	rename -uid "DBFBDC92-4CCF-FDF4-9E90-A3B2F3CB47CC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_FK_DRV_JNT" -p "L_forearm_FK_DRV_JNT";
	rename -uid "062DF065-4424-5BFC-88FD-6D9E20DC8EC9";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "DE71D83B-40FB-092D-D96D-E3818A03D604";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_IK_DRV_JNT" -p "L_upperArm_IK_DRV_JNT";
	rename -uid "53467D03-4E54-AD28-E85B-2AA43150430C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_IK_DRV_JNT" -p "L_forearm_IK_DRV_JNT";
	rename -uid "5C37EA05-43E5-51F0-0DA7-B3820757C637";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode ikEffector -n "effector1" -p "L_forearm_IK_DRV_JNT";
	rename -uid "CE47D419-455E-1C3C-182D-F5806291B66B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.rp_ik";
createNode joint -n "L_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "337845D2-4A35-B107-4478-1CAC922F0096";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_FK_DRV_JNT" -p "L_thigh_FK_DRV_JNT";
	rename -uid "470B067F-4287-5201-86A2-04ABD139E52A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_FK_DRV_JNT" -p "L_calf_FK_DRV_JNT";
	rename -uid "A74D9663-42A9-7633-CFFE-D486F0443316";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "L_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "C8131AF1-41DB-F434-4324-2CAEB100848B";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_IK_DRV_JNT" -p "L_thigh_IK_DRV_JNT";
	rename -uid "C947BE3A-410A-2CC4-D576-ACA9A7032F96";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_IK_DRV_JNT" -p "L_calf_IK_DRV_JNT";
	rename -uid "21CA3AAA-49AC-025C-4333-F88CD09AE0F0";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode ikEffector -n "effector2" -p "L_calf_IK_DRV_JNT";
	rename -uid "29614746-43AC-4FCA-87C9-788758A1D846";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.rp_ik";
createNode joint -n "R_upperArm_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "4C105760-4EBD-17F3-AAC5-A4842C0ECE2E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_FK_DRV_JNT" -p "R_upperArm_FK_DRV_JNT";
	rename -uid "EF0A66F2-486D-9539-5E05-7FBF96088514";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_FK_DRV_JNT" -p "R_forearm_FK_DRV_JNT";
	rename -uid "2CE3E35E-439A-5AE5-A2A1-0F95734C2C0F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_upperArm_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "242A52E6-4A82-2628-99F6-C58A26BEF485";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_IK_DRV_JNT" -p "R_upperArm_IK_DRV_JNT";
	rename -uid "475C62DD-41B6-FA93-556B-4BBE63C43673";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_IK_DRV_JNT" -p "R_forearm_IK_DRV_JNT";
	rename -uid "91837103-4A55-E8AB-3CEE-C7A1FBF7C530";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode ikEffector -n "effector3" -p "R_forearm_IK_DRV_JNT";
	rename -uid "3C8830CA-487F-6173-36EB-CF9C774C9501";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.rp_ik";
createNode joint -n "R_thigh_FK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "63BAE7A0-49AA-55B9-5768-5AB20B09C177";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_FK_DRV_JNT" -p "R_thigh_FK_DRV_JNT";
	rename -uid "9BDE4F24-4E9F-9591-8113-698BED0829CA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_FK_DRV_JNT" -p "R_calf_FK_DRV_JNT";
	rename -uid "2BE61287-4D96-72E4-9A6B-AAB97DA5441D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.fk_joint.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode joint -n "R_thigh_IK_DRV_JNT" -p "MC_DEFORM";
	rename -uid "30AC38DC-4200-751F-D4D2-E6A404158043";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_IK_DRV_JNT" -p "R_thigh_IK_DRV_JNT";
	rename -uid "AC4CFACD-4A3D-F63E-08D6-F58DCA6FE23C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_IK_DRV_JNT" -p "R_calf_IK_DRV_JNT";
	rename -uid "35C8D4F7-4C20-5078-6BC0-02A9620FC605";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode ikEffector -n "effector4" -p "R_calf_IK_DRV_JNT";
	rename -uid "5ABE3ED4-4D87-5EAB-ED36-289AA3D9AB50";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".v" no;
	setAttr ".hd" yes;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.rp_ik";
createNode joint -n "C_chest_DRV_JNT" -p "MC_DEFORM";
	rename -uid "6E7EEA51-4DF8-6002-6839-4FA95BF7B668";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "spine.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"chest\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT\"],[\"worldPosition\",\"0,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT";
createNode joint -n "C_head_DRV_JNT" -p "C_chest_DRV_JNT";
	rename -uid "5C6C716B-4CB7-2CF6-96B8-3BAFA4CB78C1";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "head.deform";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"head\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT\"],[\"worldPosition\",\"0,23,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|neck_JNT|head_JNT";
createNode transform -n "l_arm_bendy_0_CRV" -p "MC_DEFORM";
	rename -uid "DD628192-45D9-5DB4-FD74-28A6A8DB1466";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.bendy.0.in|l_arm.bendy.0.out|l_arm.deform.1\"],[\"targets\",\"l_arm.bendy.0.0|l_arm.bendy.0.1|l_arm.bendy.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape1" -p "l_arm_bendy_0_CRV";
	rename -uid "EB6EC42F-470E-35D4-4897-47B70FF618AF";
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
	rename -uid "B1B517E2-4052-899D-7000-14AB151E0FCB";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.bendy.1.in|l_arm.bendy.1.out|l_arm.deform.2\"],[\"targets\",\"l_arm.bendy.1.0|l_arm.bendy.1.1|l_arm.bendy.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape2" -p "l_arm_bendy_1_CRV";
	rename -uid "DDAE9565-4F74-146B-6466-4FA223E50DDB";
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
	rename -uid "424716F1-4E2B-F7F1-E827-96A30274FAF2";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.bendy.0.in|l_leg.bendy.0.out|l_leg.deform.1\"],[\"targets\",\"l_leg.bendy.0.0|l_leg.bendy.0.1|l_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape3" -p "l_leg_bendy_0_CRV";
	rename -uid "95B7488B-4A63-E2AB-BA43-02A05FB7084E";
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
	rename -uid "3F73EA4C-475D-F271-8677-3FA6EABFBD01";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.bendy.1.in|l_leg.bendy.1.out|l_leg.deform.2\"],[\"targets\",\"l_leg.bendy.1.0|l_leg.bendy.1.1|l_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"left_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape4" -p "l_leg_bendy_1_CRV";
	rename -uid "DA616F6B-4399-D4DB-BECA-41A63296259A";
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
	rename -uid "5238DDB3-46F2-8A8D-252C-8E8B6623BCD5";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.bendy.0.in|r_arm.bendy.0.out|r_arm.deform.1\"],[\"targets\",\"r_arm.bendy.0.0|r_arm.bendy.0.1|r_arm.bendy.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape5" -p "r_arm_bendy_0_CRV";
	rename -uid "1193B1B4-4E6E-AD57-35C9-429FC0BE9114";
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
	rename -uid "B04AEAD5-4CC9-A5B6-651C-729819EDBC28";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.bendy.1.in|r_arm.bendy.1.out|r_arm.deform.2\"],[\"targets\",\"r_arm.bendy.1.0|r_arm.bendy.1.1|r_arm.bendy.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_arm\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape6" -p "r_arm_bendy_1_CRV";
	rename -uid "FDD4F1C5-4F67-4B83-0AE9-8599EAF159E8";
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
	rename -uid "F22F92A2-479B-B801-69A0-09891DFC96BE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.bendy.0.in|r_leg.bendy.0.out|r_leg.deform.1\"],[\"targets\",\"r_leg.bendy.0.0|r_leg.bendy.0.1|r_leg.bendy.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_upper_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape7" -p "r_leg_bendy_0_CRV";
	rename -uid "5C89438B-4146-5851-C042-32BF1ED81A17";
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
	rename -uid "6ED31F0D-43AC-5617-F0AA-BE9279B122B7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.bendy.1.in|r_leg.bendy.1.out|r_leg.deform.2\"],[\"targets\",\"r_leg.bendy.1.0|r_leg.bendy.1.1|r_leg.bendy.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"fractions\",\"0.25|0.5|0.75\"],[\"startRole\",\"right_lower_leg\"],[\"volumeAttribute\",\"volume\"]]";
createNode nurbsCurve -n "curveShape8" -p "r_leg_bendy_1_CRV";
	rename -uid "4B73E8CD-4066-AE38-D09F-17A54F212937";
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
	rename -uid "289107CD-4FB1-6C09-2EDC-A4B4817822DE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "rig.delivery";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "root";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[]";
createNode joint -n "L_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "872C1FF6-4017-54A1-67B9-69AE6D06DE14";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_01_JNT" -p "L_upperArm_BENDY_01_JNT";
	rename -uid "017F25A3-48AA-414A-DC10-3E8C675FEED7";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "05F2BE62-4E0F-F525-EF1A-F7A86F71C3F8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_02_JNT" -p "L_upperArm_BENDY_02_JNT";
	rename -uid "4EA4272E-4668-9CE6-E66C-DCBA3181601C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "4C1046EB-4004-60E2-85CF-6C84E74564DE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_upperArm_TWIST_03_JNT" -p "L_upperArm_BENDY_03_JNT";
	rename -uid "4BF9D69B-4F88-D606-63F7-5DA712928017";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"twistEndRole\",\"left_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_arm\"],[\"worldPosition\",\"7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "D465CD24-4CBD-9015-7D25-D9937729C1FC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_01_JNT" -p "L_forearm_BENDY_01_JNT";
	rename -uid "1725C130-420B-32B6-4756-9798184CB88B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "CAC471E3-49D7-7CB7-EBCC-DB85B6CC65DD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_02_JNT" -p "L_forearm_BENDY_02_JNT";
	rename -uid "2878E8DB-481A-7EDA-15C1-97B1B57DDF5D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "AA180286-4E2C-C95D-91BC-A2912473D668";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_forearm_TWIST_03_JNT" -p "L_forearm_BENDY_03_JNT";
	rename -uid "69E2061F-4643-A341-3F0A-D6B8EBBE2A70";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"twistEndRole\",\"left_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_arm\"],[\"worldPosition\",\"10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "597DBB71-4465-36B3-4B17-2490373F6D21";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT\"],[\"worldPosition\",\"4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT";
createNode joint -n "L_forearm_RESULT_JNT" -p "L_upperArm_RESULT_JNT";
	rename -uid "692C66CC-40C6-ECFF-0D3D-5882E979104C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT\"],[\"worldPosition\",\"8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT";
createNode joint -n "L_hand_RESULT_JNT" -p "L_forearm_RESULT_JNT";
	rename -uid "83978F9A-4508-9BF4-4508-95BBBF14E0F3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT\"],[\"worldPosition\",\"11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|L_upperArm_JNT|L_forearm_JNT|L_hand_JNT";
createNode joint -n "L_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "A7F582AB-45A0-64DB-B41C-668C7FF84E9D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_01_JNT" -p "L_thigh_BENDY_01_JNT";
	rename -uid "82D4823B-4FF1-2E5D-AED5-6C9157D42BA2";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "A0E405F0-41C3-CCE9-4DB1-5EA9D713C756";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_02_JNT" -p "L_thigh_BENDY_02_JNT";
	rename -uid "F87AB7DD-481B-5896-6A26-D0B5033E3A92";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "99C03BFE-4196-7F22-29CB-4483FB86C4ED";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_thigh_TWIST_03_JNT" -p "L_thigh_BENDY_03_JNT";
	rename -uid "A7207DA9-4EFC-1B0A-582A-1D9A19A28F8E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"twistEndRole\",\"left_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_upper_leg\"],[\"worldPosition\",\"3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "2E76F99A-41FC-36B9-B991-70A5A0384373";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_01_JNT" -p "L_calf_BENDY_01_JNT";
	rename -uid "8C10D5CE-4843-17F1-96C7-92A73842F72B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "7FB19B4B-4409-E34A-204B-8F9BEFEB33A8";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_02_JNT" -p "L_calf_BENDY_02_JNT";
	rename -uid "EA81A296-4B95-78BF-4C5F-99BC6D0A8BB0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "7041A44E-43C1-CDC6-FBF1-F8BBDC11B1C0";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"left_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_calf_TWIST_03_JNT" -p "L_calf_BENDY_03_JNT";
	rename -uid "0A775CA0-49AA-0B06-CB10-ABBCB017322B";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"twistEndRole\",\"left_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"left_lower_leg\"],[\"worldPosition\",\"3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "99618C59-4AF5-06A2-969A-7592F65F076D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT\"],[\"worldPosition\",\"3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT";
createNode joint -n "L_calf_RESULT_JNT" -p "L_thigh_RESULT_JNT";
	rename -uid "F924A75F-4BD3-102D-313B-3DA9955A0A8D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT\"],[\"worldPosition\",\"3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT";
createNode joint -n "L_foot_RESULT_JNT" -p "L_calf_RESULT_JNT";
	rename -uid "A113D81A-47C3-F7BD-FD0A-38A72BEEC776";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "l_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"left_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT\"],[\"worldPosition\",\"3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|L_thigh_JNT|L_calf_JNT|L_foot_JNT";
createNode joint -n "R_upperArm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "939A5F87-4DC2-1C6C-133F-BD915811DEEC";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_01_JNT" -p "R_upperArm_BENDY_01_JNT";
	rename -uid "FA5D9DD9-4566-D5BD-388E-7FB937C9A2DE";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "C0FC2E15-4486-466C-F606-2C98AD0F671E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_02_JNT" -p "R_upperArm_BENDY_02_JNT";
	rename -uid "C2A1203E-4EB1-202A-7B23-72B2F785FF6A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-6,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "29CB2BC9-4B78-D231-A2EE-07A72992DD42";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_arm\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_upperArm_TWIST_03_JNT" -p "R_upperArm_BENDY_03_JNT";
	rename -uid "B4E315E5-47FD-9B81-60B2-32B5D740A65C";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"twistEndRole\",\"right_lower_arm\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_arm\"],[\"worldPosition\",\"-7,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "0F455639-4CFC-4AED-4289-9BAB9CBCDF99";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_01_JNT" -p "R_forearm_BENDY_01_JNT";
	rename -uid "3D11B024-493C-74F5-D586-D6A7F40D106F";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-8.75,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "72AA40BF-4C49-AB05-3D08-1A95BDF3C849";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_02_JNT" -p "R_forearm_BENDY_02_JNT";
	rename -uid "A35931DC-445E-41B2-9767-CE88A45A2228";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-9.5,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "4903B06E-4BE2-4583-011B-809FA03B8983";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_hand\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_forearm_TWIST_03_JNT" -p "R_forearm_BENDY_03_JNT";
	rename -uid "9C8B0B5B-49BC-B9C9-F05E-E094319D63E3";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"twistEndRole\",\"right_hand\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_arm\"],[\"worldPosition\",\"-10.25,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_upperArm_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "556A5D0C-4259-C4C4-9D9D-15B3E43C459D";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT\"],[\"worldPosition\",\"-4,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT";
createNode joint -n "R_forearm_RESULT_JNT" -p "R_upperArm_RESULT_JNT";
	rename -uid "973D2FA8-41FE-6AA8-2EB1-96A39CAFD151";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_arm\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT\"],[\"worldPosition\",\"-8,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT";
createNode joint -n "R_hand_RESULT_JNT" -p "R_forearm_RESULT_JNT";
	rename -uid "918F90CB-438A-128E-B13C-DC8E80078399";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_arm.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_hand\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT\"],[\"worldPosition\",\"-11,17,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|spine_JNT|chest_JNT|R_upperArm_JNT|R_forearm_JNT|R_hand_JNT";
createNode joint -n "R_thigh_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "613095CA-43EA-8AAD-7810-67BFBFBE1BB5";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_01_JNT" -p "R_thigh_BENDY_01_JNT";
	rename -uid "E55A76C6-4DB8-65A6-4500-279538EF013E";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,8,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "34820CB9-4710-D30A-11E8-8F9801884D07";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_02_JNT" -p "R_thigh_BENDY_02_JNT";
	rename -uid "CAD4E917-4E28-58DA-F8AB-F999476FA511";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,7,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "5DBF7F27-4928-9993-C3F5-4D8E33787480";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_lower_leg\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_thigh_TWIST_03_JNT" -p "R_thigh_BENDY_03_JNT";
	rename -uid "EC1F1716-44C7-0075-53A2-9DA0CE539227";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.0.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"twistEndRole\",\"right_lower_leg\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_upper_leg\"],[\"worldPosition\",\"-3,6,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_BENDY_01_JNT" -p "MC_DELIVERY";
	rename -uid "F446BEED-4F57-620E-4124-67A60DCE0F8A";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.25\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_01_JNT" -p "R_calf_BENDY_01_JNT";
	rename -uid "D47DE18E-4EEE-BAF3-D92A-EFBA1F515136";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.25\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,4,0.25\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_02_JNT" -p "MC_DELIVERY";
	rename -uid "A1E28B58-414C-D01C-C428-84B74BFDE827";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.50\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_02_JNT" -p "R_calf_BENDY_02_JNT";
	rename -uid "974E24EE-41EE-9374-B4CD-8EB32AF17752";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.50\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,3,0.5\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_BENDY_03_JNT" -p "MC_DELIVERY";
	rename -uid "BA2F572F-4B12-AB71-41EE-5DB39BCDC670";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.bendy.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"bendyEndRole\",\"right_foot\"],[\"bendyFraction\",\"0.75\"],[\"bendyStartRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_calf_TWIST_03_JNT" -p "R_calf_BENDY_03_JNT";
	rename -uid "448B8A9A-46BC-6027-27D9-3689D5E90E26";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.twist.1.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "deform";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"twistEndRole\",\"right_foot\"],[\"twistFraction\",\"0.75\"],[\"twistStartRole\",\"right_lower_leg\"],[\"worldPosition\",\"-3,2,0.75\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_thigh_RESULT_JNT" -p "MC_DELIVERY";
	rename -uid "841221B3-4EDF-9C43-35B0-9EA704108225";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.0";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_upper_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT\"],[\"worldPosition\",\"-3,9,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT";
createNode joint -n "R_calf_RESULT_JNT" -p "R_thigh_RESULT_JNT";
	rename -uid "320172D7-4688-0BFC-0C1C-8DA4A21087FA";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.1";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_lower_leg\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT\"],[\"worldPosition\",\"-3,5,0\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT";
createNode joint -n "R_foot_RESULT_JNT" -p "R_calf_RESULT_JNT";
	rename -uid "390AA4B3-4F0F-B773-D6AA-759B19F616AD";
	addAttr -ci true -sn "mayacraftRigNode" -ln "mayacraftRigNode" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "mayacraftRigNodeId" -ln "mayacraftRigNodeId" -dt "string";
	addAttr -ci true -sn "mayacraftRigGraphId" -ln "mayacraftRigGraphId" -dt "string";
	addAttr -ci true -sn "mayacraftRigModuleId" -ln "mayacraftRigModuleId" -dt "string";
	addAttr -ci true -sn "mayacraftRigLayer" -ln "mayacraftRigLayer" -dt "string";
	addAttr -ci true -sn "mayacraftRigSignature" -ln "mayacraftRigSignature" -dt "string";
	addAttr -ci true -sn "mayacraftSourceJoint" -ln "mayacraftSourceJoint" -dt "string";
	setAttr ".mayacraftRigNode" yes;
	setAttr ".mayacraftRigNodeId" -type "string" "r_leg.deform.2";
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigLayer" -type "string" "delivery";
	setAttr ".mayacraftRigSignature" -type "string" "[[\"semanticRole\",\"right_foot\"],[\"sourceJoint\",\"|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT\"],[\"worldPosition\",\"-3,1,1\"],[\"worldQuaternion\",\"0,0,0,1\"]]";
	setAttr ".mayacraftSourceJoint" -type "string" "|root_JNT|pelvis_JNT|R_thigh_JNT|R_calf_JNT|R_foot_JNT";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "AA8DB28A-4131-A8CC-2AE0-ECAEC4CA1A3F";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "A990C778-4E8C-3861-D84E-FEB43816048B";
createNode displayLayer -n "defaultLayer";
	rename -uid "F2D1F7D2-4E99-C58B-7275-D7BFCA2290BD";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "EF67894A-4384-DC14-D1D2-2F849769D6E1";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "A8DBE195-4226-43AE-1B2C-8B98C961B7B0";
	setAttr ".g" yes;
createNode multMatrix -n "head_drive_MMX";
	rename -uid "3E6A615A-4FF9-1C25-58C6-B29ADDAF31BE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "head";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"head.ctrl\"],[\"targets\",\"head.deform\"]]";
createNode multMatrix -n "l_arm_bendy_0_CV0_MMX";
	rename -uid "88E90977-4E35-78CC-8C26-1585DC241836";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV0_DCM";
	rename -uid "DF9BD4DA-4838-1E06-235B-B5B4F8122229";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV1_MMX";
	rename -uid "264A25C2-421E-FDAB-4D0E-79B52938AE15";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV1_DCM";
	rename -uid "01092A2E-4FE6-0111-2EA3-679DDD655164";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV2_MMX";
	rename -uid "64546CE6-4D47-5B25-4D86-24ABFA844D70";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV2_DCM";
	rename -uid "FDE17E4C-4245-B9AA-B8E5-53AEFBCB4CEC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multMatrix -n "l_arm_bendy_0_CV3_MMX";
	rename -uid "EE497531-46E5-73F0-80C8-63BE36AEC7AA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode decomposeMatrix -n "l_arm_bendy_0_CV3_DCM";
	rename -uid "A89615E6-42FC-5ED2-65EA-EB98261BC92D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode curveInfo -n "l_arm_bendy_0_ARC_CIF";
	rename -uid "60332321-4716-CA30-331E-65B8F5FFAF6B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode distanceBetween -n "l_arm_bendy_0_CHORD_DST";
	rename -uid "C1CEE42A-4B54-45A8-BDAC-259A81DC58F3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_STRETCH_DIV";
	rename -uid "C2AA4E47-46E8-032C-CCD3-69AD870A6B10";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_EXP";
	rename -uid "935C8EE5-46E0-5C16-ABB5-7D8F69B2DBE7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode multiplyDivide -n "l_arm_bendy_0_VOLUME_POW";
	rename -uid "FEAB16FC-43CC-A403-4B0E-7B80EC80B2C5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.0";
createNode motionPath -n "l_arm_bendy_0_01_MOP";
	rename -uid "6ABC978C-49E7-15B3-A0C7-1394FD801178";
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
	rename -uid "CAFF90FF-445C-1CD1-F94B-38BF539F15A1";
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
	rename -uid "A4AE8998-47BC-7819-1BC2-0DB087E95B21";
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
	rename -uid "24C7C664-4A76-81B1-AECC-96B54A719DF4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV0_DCM";
	rename -uid "0C970C73-4509-B939-DF81-4C90C9A14DE7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV1_MMX";
	rename -uid "A78EC568-4FF0-43CB-361F-069D732CD0DD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV1_DCM";
	rename -uid "77D3ECCF-46DE-969C-AE6D-9DB0FA66BBB4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV2_MMX";
	rename -uid "ACF9C0BF-45F1-4657-D7B8-099A0F21BB7E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV2_DCM";
	rename -uid "45E425B9-4BDD-7F31-CC0F-75852B437309";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multMatrix -n "l_arm_bendy_1_CV3_MMX";
	rename -uid "2D7EB830-4EF1-A525-60E3-59857E34D011";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode decomposeMatrix -n "l_arm_bendy_1_CV3_DCM";
	rename -uid "42AC5058-4DA1-04F8-6218-D5BA638B4003";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode curveInfo -n "l_arm_bendy_1_ARC_CIF";
	rename -uid "68C299A6-4D9D-4D9A-FDA7-1685378FB94D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode distanceBetween -n "l_arm_bendy_1_CHORD_DST";
	rename -uid "A7F323FF-4EF2-FDE2-1A4F-729ED77C98F7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_STRETCH_DIV";
	rename -uid "B98F48AB-4582-2573-B8A1-C6BBBEA9D904";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_EXP";
	rename -uid "5408AD2E-419D-49B8-0594-8AA20E77B715";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode multiplyDivide -n "l_arm_bendy_1_VOLUME_POW";
	rename -uid "9EBBDD2F-4A55-287C-586E-769D9227300C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.bendy.1";
createNode motionPath -n "l_arm_bendy_1_01_MOP";
	rename -uid "F4DFA7B5-4EA0-A7A9-9382-14B8FB1E448A";
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
	rename -uid "E623CDFD-4755-06BE-971C-F99B5A3F3612";
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
	rename -uid "146D2478-4FFD-41BA-DCFB-4FB1D06FA252";
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
	rename -uid "F0DD2773-49CB-FA03-F821-A3B36CA689C3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.0|l_arm.ik_joint.0|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_0_CORRECT_CMP";
	rename -uid "7B7DCD36-401E-DD3C-0B81-AFA7BD684597";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_CORRECT_MMX";
	rename -uid "6ADD7C4E-42B4-BE09-D83C-7482DB99FC05";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode multMatrix -n "l_arm_blend_0_LOCAL_MMX";
	rename -uid "34D45F2E-469B-2F69-FEA2-5D902AF38710";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.0";
createNode blendMatrix -n "l_arm_blend_1_BLM";
	rename -uid "7D0C783D-4D5E-D039-F82C-B09005BF1ACA";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.1|l_arm.ik_joint.1|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_1_CORRECT_CMP";
	rename -uid "F53E4934-4399-185E-23BF-A69E2BD9FA77";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_CORRECT_MMX";
	rename -uid "4251486E-4674-A1E1-7758-D087F43E9CBC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode multMatrix -n "l_arm_blend_1_LOCAL_MMX";
	rename -uid "8230ED82-49B4-0019-5210-899ECB0592A1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.1";
createNode blendMatrix -n "l_arm_blend_2_BLM";
	rename -uid "7B3CA16A-48BB-AD21-E0E5-3E8C36A6E7D1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk_joint.2|l_arm.ik_joint.2|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_arm_blend_2_CORRECT_CMP";
	rename -uid "E4D591A1-41B8-4945-1877-26951B721FDE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_CORRECT_MMX";
	rename -uid "37A35015-41AB-0C50-9D81-AEBCD2F40082";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_blend_2_LOCAL_MMX";
	rename -uid "289DC396-4519-2DA5-1AB8-40B4C074C523";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.blend.2";
createNode multMatrix -n "l_arm_drive_0_MMX";
	rename -uid "28A99AA8-4E38-C67E-D6C0-81B4628DFA76";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.0\"],[\"targets\",\"l_arm.fk_joint.0\"]]";
createNode multMatrix -n "l_arm_drive_1_MMX";
	rename -uid "1E99E8B1-4AE6-1680-808B-569FB9FCF2FE";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.1\"],[\"targets\",\"l_arm.fk_joint.1\"]]";
createNode multMatrix -n "l_arm_drive_2_MMX";
	rename -uid "89E38546-4C92-7744-86A0-20A4AE2D3234";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.fk.2\"],[\"targets\",\"l_arm.fk_joint.2\"]]";
createNode ikRPsolver -n "ikRPsolver";
	rename -uid "BE68315D-4D1C-A9B3-3DBE-F9B52F75EE3D";
createNode unitConversion -n "unitConversion1";
	rename -uid "06FF3286-4552-0156-D72A-2C94726E29E6";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_arm_space_CHOICE";
	rename -uid "F77023A4-436C-9949-EB12-E5BD9357416D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_arm.ik.ctrl\"],[\"targets\",\"l_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_arm_space_LOCAL_MMX";
	rename -uid "B13FBCB5-4C63-E9B2-FDF2-E3BBEE4120B5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE0_MMX";
	rename -uid "73020287-4651-8F92-CA75-DBBDE42140CF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_space_SPACE1_MMX";
	rename -uid "2432BDD3-46A4-E364-BD19-3882251F0466";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.space";
createNode multMatrix -n "l_arm_twist_0_REL_MMX";
	rename -uid "3798DD62-422C-7545-E646-5389C5BFEBDD";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.0|l_arm.deform.1\"],[\"targets\",\"l_arm.twist.0.0|l_arm.twist.0.1|l_arm.twist.0.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_lower_arm\"],[\"startRole\",\"left_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_0_REL_DCM";
	rename -uid "133F6BD7-41A7-B570-0374-1F95AD77C563";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode vectorProduct -n "l_arm_twist_0_TWIST_DOT";
	rename -uid "DD4583FC-4508-5151-A6A0-5CA185B3224B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multiplyDivide -n "l_arm_twist_0_TWIST_PROJECT";
	rename -uid "8ED93014-4F11-8B90-DC2F-C495D1C7DD20";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatNormalize -n "l_arm_twist_0_TWIST_NORM";
	rename -uid "8BD63C2C-48ED-7EE5-F631-A7A6342FB02A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_01_SLERP";
	rename -uid "A6091576-4590-6B1B-9D70-A7A64F3867A2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.0";
createNode quatToEuler -n "l_arm_twist_0_01_QTE";
	rename -uid "C9DAD720-427A-A833-CC55-5E805A9BB812";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_02_SLERP";
	rename -uid "1663D37B-423F-DFC2-B251-8D86A1E31D54";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.1";
createNode quatToEuler -n "l_arm_twist_0_02_QTE";
	rename -uid "FB168CE5-46F0-B827-DD79-BBB76886EF57";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode quatSlerp -n "l_arm_twist_0_03_SLERP";
	rename -uid "E76D8DD8-4306-AB98-71E6-20A783339666";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.0.2";
createNode quatToEuler -n "l_arm_twist_0_03_QTE";
	rename -uid "31DAA993-43EB-9D8B-B4BF-C99BF881843E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.0";
createNode multMatrix -n "l_arm_twist_1_REL_MMX";
	rename -uid "E9C0B31F-44DC-D3A0-2CA7-569D52C8116A";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_arm.deform.1|l_arm.deform.2\"],[\"targets\",\"l_arm.twist.1.0|l_arm.twist.1.1|l_arm.twist.1.2\"],[\"aimAxis\",\"1,0,0\"],[\"endRole\",\"left_hand\"],[\"startRole\",\"left_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_arm_twist_1_REL_DCM";
	rename -uid "69772D20-4CD2-6FF6-9829-F797BCD8C245";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode vectorProduct -n "l_arm_twist_1_TWIST_DOT";
	rename -uid "1769FD60-4BE7-BEB1-3328-988E75C6CBC9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multiplyDivide -n "l_arm_twist_1_TWIST_PROJECT";
	rename -uid "5D41C0EB-4BAF-A7B7-8F1D-068C2F8CA0F0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatNormalize -n "l_arm_twist_1_TWIST_NORM";
	rename -uid "5007F668-41C5-859C-593E-E9832BDAE014";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_01_SLERP";
	rename -uid "31B1A446-4C3B-A0C0-E0DC-51B0EEDA4AD1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.0";
createNode quatToEuler -n "l_arm_twist_1_01_QTE";
	rename -uid "11F3D167-4913-E0EE-DA43-A68EB48166ED";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_02_SLERP";
	rename -uid "BC8A8B8C-4133-BFB1-C2E1-4191A9E9883C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.1";
createNode quatToEuler -n "l_arm_twist_1_02_QTE";
	rename -uid "111D6805-4C6F-CF4D-FBFE-B0876804B0AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode quatSlerp -n "l_arm_twist_1_03_SLERP";
	rename -uid "4D11017A-4A42-C6D0-B2CF-0EBEEEDBB1DA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_arm.twist.1.2";
createNode quatToEuler -n "l_arm_twist_1_03_QTE";
	rename -uid "8309B524-4187-AF65-E4D8-B293E73DEF37";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_arm.twist.1";
createNode multMatrix -n "l_leg_bendy_0_CV0_MMX";
	rename -uid "FC4B3AB3-4509-4EA1-5797-61A44143FBBE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV0_DCM";
	rename -uid "3D4A8A2E-43D4-4795-24BF-238C8266A3E4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV1_MMX";
	rename -uid "5DEC9144-40CD-92EB-0091-BFA57180B2E0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV1_DCM";
	rename -uid "6AB8D134-4AE3-B006-1EA5-488BC714781B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV2_MMX";
	rename -uid "0A5E0A28-4712-60C6-E1F9-0F9E72CE768F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV2_DCM";
	rename -uid "331E78B8-45CE-6F3A-EDFE-DCAB5F880BEB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multMatrix -n "l_leg_bendy_0_CV3_MMX";
	rename -uid "EBCDEEB7-405B-D1EC-88CB-65BCFED590EF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode decomposeMatrix -n "l_leg_bendy_0_CV3_DCM";
	rename -uid "D8E971F4-450C-9CF9-EF2B-7D95CB53DCC8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode curveInfo -n "l_leg_bendy_0_ARC_CIF";
	rename -uid "8C389C74-465A-989A-E96C-D58D52D8CB6D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode distanceBetween -n "l_leg_bendy_0_CHORD_DST";
	rename -uid "5C4E50EC-4506-F69F-5F72-A78286CE1B3E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_STRETCH_DIV";
	rename -uid "6166CA86-4153-97D5-C5C1-67BDA021A5FA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_EXP";
	rename -uid "83B55716-422A-D64D-2655-FD801CCE40F7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode multiplyDivide -n "l_leg_bendy_0_VOLUME_POW";
	rename -uid "22C765AF-468A-FE71-614A-E48F67EE2A41";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.0";
createNode motionPath -n "l_leg_bendy_0_01_MOP";
	rename -uid "0687FD8A-401F-4CC2-75A7-8A98EBC0C3D2";
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
	rename -uid "4330E140-4973-E2D7-6096-D092810ED5C2";
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
	rename -uid "E697A92F-45CB-5946-B9B7-179B83A9CE20";
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
	rename -uid "9932B532-4FAD-19BE-6998-C2B9453F27D9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV0_DCM";
	rename -uid "352D40EF-4931-E7E5-3E02-B9A2E11C3561";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV1_MMX";
	rename -uid "6D054ABD-43EF-70A4-8EF3-ADB4FAD9CB0F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV1_DCM";
	rename -uid "1F9DDE87-46CE-21AC-CCC1-0A85784A0437";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV2_MMX";
	rename -uid "E7CE7E83-4349-0A7D-A99B-D987A68BEA6B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV2_DCM";
	rename -uid "A7E57217-4856-8E5F-3D76-B6AE548D469E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multMatrix -n "l_leg_bendy_1_CV3_MMX";
	rename -uid "27B7C9E6-4590-C564-D4FF-CD87F6F6B73F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode decomposeMatrix -n "l_leg_bendy_1_CV3_DCM";
	rename -uid "EAFEDF17-4C41-8F5E-AE5C-72B8649F8086";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode curveInfo -n "l_leg_bendy_1_ARC_CIF";
	rename -uid "EB91098F-4926-3DD2-4D50-24929657404C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode distanceBetween -n "l_leg_bendy_1_CHORD_DST";
	rename -uid "4A669B1D-412E-80D9-5167-F8B2E41CA4F3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_STRETCH_DIV";
	rename -uid "657E3FC2-4779-33FF-F00F-2D84FB3AD905";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_EXP";
	rename -uid "AFAAAB2C-4879-7B17-D3FA-8FA4D809CEBA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode multiplyDivide -n "l_leg_bendy_1_VOLUME_POW";
	rename -uid "88E5249D-4A59-32AC-4754-51A2765AFC9D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.bendy.1";
createNode motionPath -n "l_leg_bendy_1_01_MOP";
	rename -uid "8E8F31A9-449B-8F36-151B-CF8348AA79BA";
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
	rename -uid "55934934-42CA-23D0-40E7-F3A155EFECAD";
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
	rename -uid "3DCAFD8E-4C70-952D-2891-32BC92003253";
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
	rename -uid "7CC51598-4F9A-364B-7C7B-29B10787215C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.0|l_leg.ik_joint.0|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_0_CORRECT_CMP";
	rename -uid "01DC31CC-4B86-EE2D-C958-058D058C57C5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_CORRECT_MMX";
	rename -uid "61A23016-420A-D1EB-0B2D-C2BA19C5C04B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode multMatrix -n "l_leg_blend_0_LOCAL_MMX";
	rename -uid "E6A9F0ED-4D28-FA3F-9338-778DD70E6302";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.0";
createNode blendMatrix -n "l_leg_blend_1_BLM";
	rename -uid "6280F399-455D-183E-6C7A-3BB3D6775321";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.1|l_leg.ik_joint.1|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_1_CORRECT_CMP";
	rename -uid "7423E463-465B-712C-E20B-53A701F83B41";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_CORRECT_MMX";
	rename -uid "8DCA4116-4A04-8C19-25CB-BAA0E720ADE2";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode multMatrix -n "l_leg_blend_1_LOCAL_MMX";
	rename -uid "4A0E5C2D-4F92-8B5B-0106-9C9E435B52C1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.1";
createNode blendMatrix -n "l_leg_blend_2_BLM";
	rename -uid "37E63238-4D27-70CD-BA91-93AFA8B11E64";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk_joint.2|l_leg.ik_joint.2|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "l_leg_blend_2_CORRECT_CMP";
	rename -uid "15FABDC8-483F-A9CF-E63E-2CAF6204F5C4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_CORRECT_MMX";
	rename -uid "755249EB-44F8-B0AB-BC75-6AB8788CED4E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_blend_2_LOCAL_MMX";
	rename -uid "6DC7D1EF-429F-2B0C-D2A6-26BC870F82A8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.blend.2";
createNode multMatrix -n "l_leg_drive_0_MMX";
	rename -uid "EC535BBB-4DA1-2942-FF46-01A1953AB547";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.0\"],[\"targets\",\"l_leg.fk_joint.0\"]]";
createNode multMatrix -n "l_leg_drive_1_MMX";
	rename -uid "FFF8AF6E-498A-C0C6-D20A-AC929164F067";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.1\"],[\"targets\",\"l_leg.fk_joint.1\"]]";
createNode multMatrix -n "l_leg_drive_2_MMX";
	rename -uid "CEFAC4E7-4B15-4150-8BEF-C3B494976D66";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.fk.2\"],[\"targets\",\"l_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion2";
	rename -uid "F0E00A57-40D4-857D-7951-CF8D92342CD4";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "l_leg_space_CHOICE";
	rename -uid "5E71A526-48B4-533F-0034-379C34B02ED9";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|l_leg.ik.ctrl\"],[\"targets\",\"l_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "l_leg_space_LOCAL_MMX";
	rename -uid "CB128EB6-4050-0883-6707-22A475AC9C7D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE0_MMX";
	rename -uid "45F2C3D2-4B56-D57A-1004-0F9D86CAD4DF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_space_SPACE1_MMX";
	rename -uid "720088A2-4F82-EF7B-395D-AE826A94D0D0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.space";
createNode multMatrix -n "l_leg_twist_0_REL_MMX";
	rename -uid "1B0DAA03-4C52-8F0D-140B-3EBCD0D18494";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.0|l_leg.deform.1\"],[\"targets\",\"l_leg.twist.0.0|l_leg.twist.0.1|l_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"left_lower_leg\"],[\"startRole\",\"left_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_0_REL_DCM";
	rename -uid "FCFFCCAB-42FE-0116-DF72-2D9ED93F6FAE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode vectorProduct -n "l_leg_twist_0_TWIST_DOT";
	rename -uid "8F5D03B8-432C-AC00-2E1D-D191A7959B24";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multiplyDivide -n "l_leg_twist_0_TWIST_PROJECT";
	rename -uid "ED5232CF-4A86-0AF8-83AB-C3BCEB96E063";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatNormalize -n "l_leg_twist_0_TWIST_NORM";
	rename -uid "ADA53762-4523-CC74-9ABC-AEBD3C8FD197";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_01_SLERP";
	rename -uid "B781C82A-4A6E-CD69-4FDA-E98D3D84C209";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.0";
createNode quatToEuler -n "l_leg_twist_0_01_QTE";
	rename -uid "358786BE-44E0-41DA-17D2-63B64F844168";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_02_SLERP";
	rename -uid "2F3BBF80-4419-82C5-F8EC-5AB94649C732";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.1";
createNode quatToEuler -n "l_leg_twist_0_02_QTE";
	rename -uid "BF316E0B-43D9-0CDB-D0E4-9EA20F57ED3E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode quatSlerp -n "l_leg_twist_0_03_SLERP";
	rename -uid "F75DE433-4CDD-19E2-1AB0-E38B87B3FAF7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.0.2";
createNode quatToEuler -n "l_leg_twist_0_03_QTE";
	rename -uid "CF035C3F-40A8-EB13-BD4A-25914C47CC7C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.0";
createNode multMatrix -n "l_leg_twist_1_REL_MMX";
	rename -uid "E4E3D3F7-4D5A-6466-E3B8-E6B817298BED";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "l_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"l_leg.deform.1|l_leg.deform.2\"],[\"targets\",\"l_leg.twist.1.0|l_leg.twist.1.1|l_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"left_foot\"],[\"startRole\",\"left_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "l_leg_twist_1_REL_DCM";
	rename -uid "0038ABBF-4BA1-ADED-493E-F2B064989B58";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode vectorProduct -n "l_leg_twist_1_TWIST_DOT";
	rename -uid "1EE03EE9-4DE3-1882-9628-4F930C47960D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multiplyDivide -n "l_leg_twist_1_TWIST_PROJECT";
	rename -uid "8CEEEF4A-43A2-0E87-E637-D3A7676B4AAC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatNormalize -n "l_leg_twist_1_TWIST_NORM";
	rename -uid "6D50570D-4738-5972-C1DA-1381BC356CED";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_01_SLERP";
	rename -uid "4C547CF4-4809-249E-A3B8-C197B06AAB69";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.0";
createNode quatToEuler -n "l_leg_twist_1_01_QTE";
	rename -uid "56AAADE8-4EB8-BBAE-1109-3EA52325A409";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_02_SLERP";
	rename -uid "76208711-43B2-3697-4391-36BEC0A75711";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.1";
createNode quatToEuler -n "l_leg_twist_1_02_QTE";
	rename -uid "D87ADF30-4011-FA85-4260-B6BF795157FE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode quatSlerp -n "l_leg_twist_1_03_SLERP";
	rename -uid "44F2D2C5-4300-100C-B0EF-C3A79EEBBADA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "l_leg.twist.1.2";
createNode quatToEuler -n "l_leg_twist_1_03_QTE";
	rename -uid "BCC54900-499B-2E71-5194-A3AE674458BA";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "l_leg.twist.1";
createNode multMatrix -n "r_arm_bendy_0_CV0_MMX";
	rename -uid "7FAAE02C-44C8-019E-953C-32A923EB9538";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV0_DCM";
	rename -uid "DC020E9A-4D14-7975-2985-559AB40F308B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV1_MMX";
	rename -uid "CBC22C46-4D9A-581F-A3AF-01A1DF7D9E11";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV1_DCM";
	rename -uid "8817B475-4E57-A075-6B4A-F9A775B0AB80";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV2_MMX";
	rename -uid "09E7EECC-48F5-CEAA-1452-88AD297E10F9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV2_DCM";
	rename -uid "2F1FF158-420B-B635-E52F-FEBC899C5138";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multMatrix -n "r_arm_bendy_0_CV3_MMX";
	rename -uid "0F08952D-4112-B36F-D69C-8994D5C69018";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode decomposeMatrix -n "r_arm_bendy_0_CV3_DCM";
	rename -uid "A5647DEA-4340-612C-35CF-33BFFDFEB68F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode curveInfo -n "r_arm_bendy_0_ARC_CIF";
	rename -uid "3E51BEC4-4592-5DD8-A6D1-3A9A2C3EF3CB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode distanceBetween -n "r_arm_bendy_0_CHORD_DST";
	rename -uid "569F1D32-4E1A-2600-0DA8-77AC4C9FF5EE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_STRETCH_DIV";
	rename -uid "38332E76-4C1C-D3AA-6A28-BE8ADE77AA77";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_EXP";
	rename -uid "3030F7BA-4971-AC05-7D4D-12B0189AAF32";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode multiplyDivide -n "r_arm_bendy_0_VOLUME_POW";
	rename -uid "ED99B92B-4651-710E-BD85-E487A00B2312";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.0";
createNode motionPath -n "r_arm_bendy_0_01_MOP";
	rename -uid "78F0420E-408B-ACFE-51F5-B4AF448AEC35";
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
	rename -uid "D2A34214-439D-ACEF-7788-719C0AE48354";
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
	rename -uid "CD912D6D-4D06-8C5D-BAFE-F3982C848B15";
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
	rename -uid "415DE60F-4B06-A9E9-CE7E-01A2A716233B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV0_DCM";
	rename -uid "433FE078-4908-E2CB-DE2D-A2AA5390FE8B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV1_MMX";
	rename -uid "1161880F-4EA3-649A-FE6E-38AA35AAFFCD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV1_DCM";
	rename -uid "9106BAF5-4DE8-DC93-0097-60ABD24FB20B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV2_MMX";
	rename -uid "407A6562-4A49-CDF0-31BC-068A1A828BE9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV2_DCM";
	rename -uid "5913E8E4-45ED-5E41-5353-30B25E024775";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multMatrix -n "r_arm_bendy_1_CV3_MMX";
	rename -uid "A936EFB9-48FD-8C18-7FAC-55BA89DC8B1B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode decomposeMatrix -n "r_arm_bendy_1_CV3_DCM";
	rename -uid "67D02CE0-4951-2EFE-F224-F099666F1F83";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode curveInfo -n "r_arm_bendy_1_ARC_CIF";
	rename -uid "15FB5574-418A-3154-61A4-25830AB8D57D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode distanceBetween -n "r_arm_bendy_1_CHORD_DST";
	rename -uid "3E05E68C-4A36-A6D9-AB09-269F8A797408";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_STRETCH_DIV";
	rename -uid "428EF40E-4CB8-1790-0C1D-1FBC94459D94";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_EXP";
	rename -uid "4C204B29-4227-D585-71EA-A1B03255B1DB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode multiplyDivide -n "r_arm_bendy_1_VOLUME_POW";
	rename -uid "53104CEF-4178-71E4-2146-718B3B988F92";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.bendy.1";
createNode motionPath -n "r_arm_bendy_1_01_MOP";
	rename -uid "96200333-478D-2388-C5BC-AC9F3688FCD7";
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
	rename -uid "A24E58E5-45A0-512C-3B8F-CDBDB6AE92BC";
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
	rename -uid "DEE36652-4D97-0A59-E8E8-8F8227D4698A";
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
	rename -uid "FC6B9240-4BF1-EEED-9FF3-FFBE854F0DFA";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.0|r_arm.ik_joint.0|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_0_CORRECT_CMP";
	rename -uid "087FBB99-484B-6F9F-6959-B5866AC6D5B5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_CORRECT_MMX";
	rename -uid "99BF5B36-4E78-8BAA-64C1-8CB9BB1DAFFD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode multMatrix -n "r_arm_blend_0_LOCAL_MMX";
	rename -uid "00110EE5-484A-A248-6D26-3AB0BE905C17";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.0";
createNode blendMatrix -n "r_arm_blend_1_BLM";
	rename -uid "E0E74C95-4421-C355-F172-7798676D19BB";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.1|r_arm.ik_joint.1|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_1_CORRECT_CMP";
	rename -uid "E0A994FD-4EA0-8874-0005-2AA56E82E6C3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_CORRECT_MMX";
	rename -uid "EC09418C-483C-6C52-7B47-0C98B98B03E1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode multMatrix -n "r_arm_blend_1_LOCAL_MMX";
	rename -uid "26E0CCB0-4AD4-3CA4-4CA6-99AE8505F531";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.1";
createNode blendMatrix -n "r_arm_blend_2_BLM";
	rename -uid "991C7989-4ECA-3745-5228-93A316A62852";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk_joint.2|r_arm.ik_joint.2|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_arm_blend_2_CORRECT_CMP";
	rename -uid "9C38DAA2-4F35-A7A8-C6D0-7CA1ACE78A7E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_CORRECT_MMX";
	rename -uid "039DA0F7-49A3-A732-389A-ADAA0629DA18";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_blend_2_LOCAL_MMX";
	rename -uid "CBCDB7DE-41CE-10C1-C5E6-E2BA68FE55A5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.blend.2";
createNode multMatrix -n "r_arm_drive_0_MMX";
	rename -uid "B279F956-4189-65C1-D821-1ABC4F849F1C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.0\"],[\"targets\",\"r_arm.fk_joint.0\"]]";
createNode multMatrix -n "r_arm_drive_1_MMX";
	rename -uid "29851292-4A1E-FDE5-9E01-DDB0266D1C17";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.1\"],[\"targets\",\"r_arm.fk_joint.1\"]]";
createNode multMatrix -n "r_arm_drive_2_MMX";
	rename -uid "1C7DF8D6-47F1-048A-771C-0A815FDAE304";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.fk.2\"],[\"targets\",\"r_arm.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion3";
	rename -uid "7A37230F-46A6-3AA1-86D6-4AB833C9DF0C";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_arm_space_CHOICE";
	rename -uid "6636468E-45FD-0518-88FA-CBA5D8B915D3";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_arm.ik.ctrl\"],[\"targets\",\"r_arm.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_arm_space_LOCAL_MMX";
	rename -uid "C75A91FD-4DEB-A4F9-9B47-518B30A7C6C1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE0_MMX";
	rename -uid "C5B86813-4D6C-C333-487C-DB8B002D6CCF";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_space_SPACE1_MMX";
	rename -uid "0846B093-42A9-45A4-9F59-8B87D7336C5D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.space";
createNode multMatrix -n "r_arm_twist_0_REL_MMX";
	rename -uid "4E564DCD-4B68-FE12-4A20-4680B79781D1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.0|r_arm.deform.1\"],[\"targets\",\"r_arm.twist.0.0|r_arm.twist.0.1|r_arm.twist.0.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_lower_arm\"],[\"startRole\",\"right_upper_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_0_REL_DCM";
	rename -uid "E92F872E-4C32-E449-D7E0-1CB7E20E07AC";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode vectorProduct -n "r_arm_twist_0_TWIST_DOT";
	rename -uid "F5FD8134-4445-BD77-243C-64B71080C87A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multiplyDivide -n "r_arm_twist_0_TWIST_PROJECT";
	rename -uid "E8690D63-4D89-65C3-A1BC-44A3B8FC0698";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatNormalize -n "r_arm_twist_0_TWIST_NORM";
	rename -uid "967CC5B4-4E21-885B-976E-99887C80EC68";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_01_SLERP";
	rename -uid "5C9A02C8-4CC9-EE8B-9CEA-2D9D5A187651";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.0";
createNode quatToEuler -n "r_arm_twist_0_01_QTE";
	rename -uid "7929BFE8-409A-6817-F527-5096B740F786";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_02_SLERP";
	rename -uid "70FEAC2B-42AF-E4FD-46DC-5082A984815B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.1";
createNode quatToEuler -n "r_arm_twist_0_02_QTE";
	rename -uid "CF872C2A-478D-176F-4A01-65ABE29A01FE";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode quatSlerp -n "r_arm_twist_0_03_SLERP";
	rename -uid "89627291-49D3-FD8F-35C7-CE93B9D58787";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.0.2";
createNode quatToEuler -n "r_arm_twist_0_03_QTE";
	rename -uid "D378FB75-4468-8A26-5F8A-F2B2125A2258";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.0";
createNode multMatrix -n "r_arm_twist_1_REL_MMX";
	rename -uid "7F65446F-4EAC-218F-39EB-2EBDEDBD28CF";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_arm";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_arm.deform.1|r_arm.deform.2\"],[\"targets\",\"r_arm.twist.1.0|r_arm.twist.1.1|r_arm.twist.1.2\"],[\"aimAxis\",\"-1,0,0\"],[\"endRole\",\"right_hand\"],[\"startRole\",\"right_lower_arm\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_arm_twist_1_REL_DCM";
	rename -uid "A800A981-4912-58B1-11BD-5C9196EEB69B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode vectorProduct -n "r_arm_twist_1_TWIST_DOT";
	rename -uid "1332F9D4-49BD-D437-77E8-1E8638DFC528";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multiplyDivide -n "r_arm_twist_1_TWIST_PROJECT";
	rename -uid "1E53E071-4D37-8CD5-9AAD-63AE4500EF3B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" -1 0 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatNormalize -n "r_arm_twist_1_TWIST_NORM";
	rename -uid "5910D6DF-4E3F-DAA3-C79E-2A894F498F52";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_01_SLERP";
	rename -uid "67E790FF-4F04-C9C2-B585-39920EFC58B5";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.0";
createNode quatToEuler -n "r_arm_twist_1_01_QTE";
	rename -uid "AE66989E-46DA-415E-CD69-C4A022478D7E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_02_SLERP";
	rename -uid "29954B8D-4F94-49D7-942E-DF80CD7EAA43";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.1";
createNode quatToEuler -n "r_arm_twist_1_02_QTE";
	rename -uid "AB712CD4-4163-0B34-526F-94B32D3CF020";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode quatSlerp -n "r_arm_twist_1_03_SLERP";
	rename -uid "A8E62D0B-49F3-BE28-48B8-FA9C49186451";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_arm.twist.1.2";
createNode quatToEuler -n "r_arm_twist_1_03_QTE";
	rename -uid "30EC7A9E-4B6B-2FA5-6972-BC9A64C2AE44";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_arm.twist.1";
createNode multMatrix -n "r_leg_bendy_0_CV0_MMX";
	rename -uid "1B8C7A4C-4BFE-248B-4C55-218FFAC9C47E";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV0_DCM";
	rename -uid "ED01E2C7-41D5-B063-E065-69B41533E47D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV1_MMX";
	rename -uid "F2B8BADC-4F95-A6E7-09DE-F4897E8E976D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV1_DCM";
	rename -uid "AF1D3768-4DB4-D77E-562E-A6813623E1BB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV2_MMX";
	rename -uid "10DFE948-479A-550E-F610-A99CF34F887A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV2_DCM";
	rename -uid "C22AC7B9-4B72-28F0-B937-E095E48C5A2B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multMatrix -n "r_leg_bendy_0_CV3_MMX";
	rename -uid "6C524152-41C4-A380-8E37-6EA18C6381E4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode decomposeMatrix -n "r_leg_bendy_0_CV3_DCM";
	rename -uid "9BEF011F-4FFE-E211-6720-27BB0A5736C3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode curveInfo -n "r_leg_bendy_0_ARC_CIF";
	rename -uid "83427485-464C-29DF-4E6D-77AFE2586C8D";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode distanceBetween -n "r_leg_bendy_0_CHORD_DST";
	rename -uid "3FBEFFE0-47C4-67F9-5ABC-3487469B0227";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_STRETCH_DIV";
	rename -uid "61BD5CD2-49C5-B97E-8A6E-E5AED41F8B54";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_EXP";
	rename -uid "F86D1358-4BFD-1192-BD78-A99211A7DDB7";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode multiplyDivide -n "r_leg_bendy_0_VOLUME_POW";
	rename -uid "043A3B06-47DB-0D2E-9812-3CA61877A09F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.0";
createNode motionPath -n "r_leg_bendy_0_01_MOP";
	rename -uid "95C6D322-40E0-7740-EEEC-A098EF933909";
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
	rename -uid "2FAE8649-4317-A635-6865-6086C560586D";
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
	rename -uid "C5830835-4D72-DFE2-58BE-7BB1643060C4";
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
	rename -uid "FD567D69-4F56-8DF4-D97E-BDB47BEC7D4B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV0_DCM";
	rename -uid "C16794C2-4560-724C-58E0-7AAD3A7A37C8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV1_MMX";
	rename -uid "5CDEB471-41A4-DD3F-FE86-F3A8C2C32419";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 1 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV1_DCM";
	rename -uid "A47B5F5F-4CC3-827C-16D3-83A57785D961";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV2_MMX";
	rename -uid "5C8CA374-4770-E1CF-24AE-7D9F8A915897";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 2 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV2_DCM";
	rename -uid "8A476744-44F7-5F0C-0599-6AA08FD88B31";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multMatrix -n "r_leg_bendy_1_CV3_MMX";
	rename -uid "04FB3154-4BC8-586D-F48C-E2B3AE56F57B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftBendySourceIndex" -ln "mayacraftBendySourceIndex"
		-dv 3 -at "long";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode decomposeMatrix -n "r_leg_bendy_1_CV3_DCM";
	rename -uid "00079F79-43A8-5FE4-48D1-17A845D39105";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode curveInfo -n "r_leg_bendy_1_ARC_CIF";
	rename -uid "2F773A46-42E8-E1AD-2EDB-59BF172C2EBB";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode distanceBetween -n "r_leg_bendy_1_CHORD_DST";
	rename -uid "F3DE64AD-4DF0-46CA-D95F-9C8D268B6257";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_STRETCH_DIV";
	rename -uid "3228FA32-43EE-AD24-639E-B4BE180D3170";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 2;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_EXP";
	rename -uid "2322F84A-446C-13B1-7C28-169EE9D2E917";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" -0.5 1 1 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode multiplyDivide -n "r_leg_bendy_1_VOLUME_POW";
	rename -uid "C5064631-4591-3605-7A9B-27AD8EA04324";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".op" 3;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.bendy.1";
createNode motionPath -n "r_leg_bendy_1_01_MOP";
	rename -uid "79F322A7-4ADA-E8BD-D664-35B4ADEC257E";
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
	rename -uid "2C14EDB8-4D00-D50C-4C77-BC9049F0DB76";
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
	rename -uid "5853BB90-4A4B-4FA6-C2C7-59B1A5180E01";
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
	rename -uid "0602CE1A-4D68-82FF-B2A6-0D865EFC074F";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.0|r_leg.ik_joint.0|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.0\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_0_CORRECT_CMP";
	rename -uid "E2EE304E-4E20-F383-E5D2-98A439459E04";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_CORRECT_MMX";
	rename -uid "F84C239B-475C-958F-BA0A-49BEE913750A";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode multMatrix -n "r_leg_blend_0_LOCAL_MMX";
	rename -uid "EC59AC53-4CB8-BC51-B2BB-858CF844B853";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.0";
createNode blendMatrix -n "r_leg_blend_1_BLM";
	rename -uid "7EC54127-4864-CD86-4442-6B8437F7B449";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.1|r_leg.ik_joint.1|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.1\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_1_CORRECT_CMP";
	rename -uid "499A67E3-46A9-A0B0-8402-0EA14AFC6AF4";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_CORRECT_MMX";
	rename -uid "29A66C8B-4573-496F-8794-1A8A13899392";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode multMatrix -n "r_leg_blend_1_LOCAL_MMX";
	rename -uid "639E2D39-4C4F-5F23-8822-BCA6FB0375E6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.1";
createNode blendMatrix -n "r_leg_blend_2_BLM";
	rename -uid "68D7F501-44BF-965B-49EF-FEB412C5DE8C";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk_joint.2|r_leg.ik_joint.2|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.deform.2\"],[\"weightAttribute\",\"ikFk\"]]";
createNode composeMatrix -n "r_leg_blend_2_CORRECT_CMP";
	rename -uid "336B892D-4DFC-472D-2074-FAA595CD86E8";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_CORRECT_MMX";
	rename -uid "6EB8761F-4CA3-325F-37D1-5BA875B2A17C";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_blend_2_LOCAL_MMX";
	rename -uid "62224CB7-46E3-11C6-923F-7EB2AD8D4D80";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.blend.2";
createNode multMatrix -n "r_leg_drive_0_MMX";
	rename -uid "27217AD9-4A65-D76E-EB90-9F80DB1BC1A1";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.0\"],[\"targets\",\"r_leg.fk_joint.0\"]]";
createNode multMatrix -n "r_leg_drive_1_MMX";
	rename -uid "19E58DAF-42EA-9B80-89A7-EE95049B3638";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.1\"],[\"targets\",\"r_leg.fk_joint.1\"]]";
createNode multMatrix -n "r_leg_drive_2_MMX";
	rename -uid "CBE69416-4D81-1B3C-ADC1-F0AFF7D6EE5E";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.fk.2\"],[\"targets\",\"r_leg.fk_joint.2\"]]";
createNode unitConversion -n "unitConversion4";
	rename -uid "FF50D567-485B-CFD4-D44D-47A7BF7D78BF";
	setAttr ".cf" 0.017453292519943295;
createNode choice -n "r_leg_space_CHOICE";
	rename -uid "E59F5F98-4DA6-A912-A67E-5B814133F3A7";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"rig.controls|spine.ctrl|r_leg.ik.ctrl\"],[\"targets\",\"r_leg.ik.space\"],[\"selectorAttribute\",\"space\"],[\"spaceLabels\",\"\\u5168\\u5c40|\\u80f8\\u53e3\"]]";
createNode multMatrix -n "r_leg_space_LOCAL_MMX";
	rename -uid "86EF00A6-4513-837B-77B8-8AB7BF3EE209";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE0_MMX";
	rename -uid "4CA9B980-4BCB-FFAB-3F36-21AC5D283818";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_space_SPACE1_MMX";
	rename -uid "67FA361E-4D92-27C8-AAF3-C286E28459AD";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr -s 2 ".i";
	setAttr ".i[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -17 0 1;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.space";
createNode multMatrix -n "r_leg_twist_0_REL_MMX";
	rename -uid "3ABE46B8-4A11-9339-3751-E484486CE40D";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.0|r_leg.deform.1\"],[\"targets\",\"r_leg.twist.0.0|r_leg.twist.0.1|r_leg.twist.0.2\"],[\"aimAxis\",\"0,-1,0\"],[\"endRole\",\"right_lower_leg\"],[\"startRole\",\"right_upper_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_0_REL_DCM";
	rename -uid "51D68158-42DD-F35F-D037-ECA6BFBE5741";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode vectorProduct -n "r_leg_twist_0_TWIST_DOT";
	rename -uid "92DEC85F-43A0-48B1-3B14-D7BB0C6F6C79";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multiplyDivide -n "r_leg_twist_0_TWIST_PROJECT";
	rename -uid "2542F39A-4999-F2DA-EB27-3CA48F8096B9";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -1 0 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatNormalize -n "r_leg_twist_0_TWIST_NORM";
	rename -uid "C2E26BDA-4DD3-C1E7-F9D8-87B9E3C716C6";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_01_SLERP";
	rename -uid "F7C4C9EB-47F2-27E3-27D0-DBB4A62EB19F";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.0";
createNode quatToEuler -n "r_leg_twist_0_01_QTE";
	rename -uid "4A46DEAB-46B2-0318-122E-B3BEFDD17987";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_02_SLERP";
	rename -uid "AA45E1C6-42B5-2834-E83F-8AA45D6112D0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.1";
createNode quatToEuler -n "r_leg_twist_0_02_QTE";
	rename -uid "5E13C43C-4877-410E-B5EB-30883CA09E83";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode quatSlerp -n "r_leg_twist_0_03_SLERP";
	rename -uid "DCED0F9C-4AD2-6C75-4F22-B19C150BE448";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.0.2";
createNode quatToEuler -n "r_leg_twist_0_03_QTE";
	rename -uid "2989103A-4A45-BF65-CCD9-2ABFAE933B69";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.0";
createNode multMatrix -n "r_leg_twist_1_REL_MMX";
	rename -uid "1EF9EEAC-4677-1F58-3CDE-24B7D0E68A30";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "r_leg";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"r_leg.deform.1|r_leg.deform.2\"],[\"targets\",\"r_leg.twist.1.0|r_leg.twist.1.1|r_leg.twist.1.2\"],[\"aimAxis\",\"0,-0.9701425,0.242535625\"],[\"endRole\",\"right_foot\"],[\"startRole\",\"right_lower_leg\"],[\"weights\",\"0.25|0.5|0.75\"]]";
createNode decomposeMatrix -n "r_leg_twist_1_REL_DCM";
	rename -uid "1AEB2084-4C9E-852D-FE5E-14AFA59969F1";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode vectorProduct -n "r_leg_twist_1_TWIST_DOT";
	rename -uid "60181380-4D66-609A-134F-F09FB6092D1B";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i2" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multiplyDivide -n "r_leg_twist_1_TWIST_PROJECT";
	rename -uid "3906B16A-440F-06CB-A7CE-43924CDA3D22";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".i1" -type "float3" 0 -0.97014248 0.24253562 ;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatNormalize -n "r_leg_twist_1_TWIST_NORM";
	rename -uid "7ED6FB7A-432D-7881-C18E-FAB96273C7E0";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_01_SLERP";
	rename -uid "CAE3DC9B-42EB-2E02-27A0-7AB2E598C4D3";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.25;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.0";
createNode quatToEuler -n "r_leg_twist_1_01_QTE";
	rename -uid "5E36DF7A-4AF1-223D-6F9D-E996FB6F8D64";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_02_SLERP";
	rename -uid "06F1E502-4F3B-D1CE-88A8-84A8AD62C837";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 1 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.5;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.1";
createNode quatToEuler -n "r_leg_twist_1_02_QTE";
	rename -uid "BF52E2FB-4415-8577-60FE-A0B6B3ACEC30";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode quatSlerp -n "r_leg_twist_1_03_SLERP";
	rename -uid "4CAE2AA5-4C0D-A397-7F6D-F9BD80B99473";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	addAttr -ci true -sn "mayacraftTwistIndex" -ln "mayacraftTwistIndex" -dv 2 -at "long";
	addAttr -ci true -sn "mayacraftTwistTarget" -ln "mayacraftTwistTarget" -dt "string";
	setAttr ".t" 0.75;
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
	setAttr ".mayacraftTwistTarget" -type "string" "r_leg.twist.1.2";
createNode quatToEuler -n "r_leg_twist_1_03_QTE";
	rename -uid "8C351CBF-4676-37F2-7CEB-2A8C136D5402";
	addAttr -ci true -sn "mayacraftRigBehaviorOwnerId" -ln "mayacraftRigBehaviorOwnerId"
		-dt "string";
	setAttr ".mayacraftRigBehaviorOwnerId" -type "string" "r_leg.twist.1";
createNode multMatrix -n "spine_drive_MMX";
	rename -uid "59DF4E49-4086-C200-CEB9-17B67269E6F4";
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
	setAttr ".mayacraftRigGraphId" -type "string" "demoTwistSculpt";
	setAttr ".mayacraftRigModuleId" -type "string" "spine";
	setAttr ".mayacraftRigBehaviorSignature" -type "string" "[[\"sources\",\"spine.ctrl\"],[\"targets\",\"spine.deform\"]]";
createNode animCurveTA -n "L_forearm_FK_CTRL_rotateX";
	rename -uid "D2FAE5AC-4557-593E-24B4-A6A33B798C44";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 0 12 90 24 -70;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "D1C82BB2-41DA-01AE-2C80-D892964ADD61";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "D1EB0AEC-48F9-C91B-8FCD-70BECFEE6EB2";
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
// End of mayacraft_twist_sculpt.ma
