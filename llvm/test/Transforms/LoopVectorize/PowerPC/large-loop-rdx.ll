; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=loop-vectorize -S | FileCheck %s

target datalayout = "e-m:e-i64:64-n32:64"
target triple = "powerpc64le-ibm-linux-gnu"

; We expect the loop with double reductions to be interleaved 8 times.
define void @QLA_F3_r_veq_norm2_V(ptr noalias %r, ptr noalias %a, i32 %n) {
; CHECK-LABEL: define void @QLA_F3_r_veq_norm2_V(
; CHECK-SAME: ptr noalias [[R:%.*]], ptr noalias [[A:%.*]], i32 [[N:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[CMP24:%.*]] = icmp sgt i32 [[N]], 0
; CHECK-NEXT:    br i1 [[CMP24]], label %[[FOR_COND1_PREHEADER_PREHEADER:.*]], label %[[FOR_END13:.*]]
; CHECK:       [[FOR_COND1_PREHEADER_PREHEADER]]:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP0]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 8
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <2 x double> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP69:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <2 x double> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP65:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <2 x double> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP66:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi <2 x double> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP67:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 6
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDEX]], i64 0, i32 0
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[TMP1]], i64 0, i32 0
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[TMP2]], i64 0, i32 0
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[TMP3]], i64 0, i32 0
; CHECK-NEXT:    [[WIDE_VEC35:%.*]] = load <12 x float>, ptr [[TMP13]], align 8
; CHECK-NEXT:    [[STRIDED_VEC36:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 0, i32 6>
; CHECK-NEXT:    [[STRIDED_VEC37:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 1, i32 7>
; CHECK-NEXT:    [[STRIDED_VEC38:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 2, i32 8>
; CHECK-NEXT:    [[STRIDED_VEC39:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 3, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC40:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 4, i32 10>
; CHECK-NEXT:    [[STRIDED_VEC41:%.*]] = shufflevector <12 x float> [[WIDE_VEC35]], <12 x float> poison, <2 x i32> <i32 5, i32 11>
; CHECK-NEXT:    [[WIDE_VEC42:%.*]] = load <12 x float>, ptr [[TMP14]], align 8
; CHECK-NEXT:    [[STRIDED_VEC43:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 0, i32 6>
; CHECK-NEXT:    [[STRIDED_VEC44:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 1, i32 7>
; CHECK-NEXT:    [[STRIDED_VEC45:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 2, i32 8>
; CHECK-NEXT:    [[STRIDED_VEC46:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 3, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC47:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 4, i32 10>
; CHECK-NEXT:    [[STRIDED_VEC48:%.*]] = shufflevector <12 x float> [[WIDE_VEC42]], <12 x float> poison, <2 x i32> <i32 5, i32 11>
; CHECK-NEXT:    [[WIDE_VEC49:%.*]] = load <12 x float>, ptr [[TMP15]], align 8
; CHECK-NEXT:    [[STRIDED_VEC50:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 0, i32 6>
; CHECK-NEXT:    [[STRIDED_VEC51:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 1, i32 7>
; CHECK-NEXT:    [[STRIDED_VEC52:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 2, i32 8>
; CHECK-NEXT:    [[STRIDED_VEC53:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 3, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC54:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 4, i32 10>
; CHECK-NEXT:    [[STRIDED_VEC55:%.*]] = shufflevector <12 x float> [[WIDE_VEC49]], <12 x float> poison, <2 x i32> <i32 5, i32 11>
; CHECK-NEXT:    [[WIDE_VEC56:%.*]] = load <12 x float>, ptr [[TMP16]], align 8
; CHECK-NEXT:    [[STRIDED_VEC57:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 0, i32 6>
; CHECK-NEXT:    [[STRIDED_VEC58:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 1, i32 7>
; CHECK-NEXT:    [[STRIDED_VEC59:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 2, i32 8>
; CHECK-NEXT:    [[STRIDED_VEC60:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 3, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC61:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 4, i32 10>
; CHECK-NEXT:    [[STRIDED_VEC62:%.*]] = shufflevector <12 x float> [[WIDE_VEC56]], <12 x float> poison, <2 x i32> <i32 5, i32 11>
; CHECK-NEXT:    [[TMP64:%.*]] = fmul fast <2 x float> [[STRIDED_VEC36]], [[STRIDED_VEC36]]
; CHECK-NEXT:    [[TMP97:%.*]] = fmul fast <2 x float> [[STRIDED_VEC43]], [[STRIDED_VEC43]]
; CHECK-NEXT:    [[TMP98:%.*]] = fmul fast <2 x float> [[STRIDED_VEC50]], [[STRIDED_VEC50]]
; CHECK-NEXT:    [[TMP99:%.*]] = fmul fast <2 x float> [[STRIDED_VEC57]], [[STRIDED_VEC57]]
; CHECK-NEXT:    [[TMP72:%.*]] = fmul fast <2 x float> [[STRIDED_VEC37]], [[STRIDED_VEC37]]
; CHECK-NEXT:    [[TMP105:%.*]] = fmul fast <2 x float> [[STRIDED_VEC44]], [[STRIDED_VEC44]]
; CHECK-NEXT:    [[TMP106:%.*]] = fmul fast <2 x float> [[STRIDED_VEC51]], [[STRIDED_VEC51]]
; CHECK-NEXT:    [[TMP107:%.*]] = fmul fast <2 x float> [[STRIDED_VEC58]], [[STRIDED_VEC58]]
; CHECK-NEXT:    [[TMP80:%.*]] = fadd fast <2 x float> [[TMP72]], [[TMP64]]
; CHECK-NEXT:    [[TMP113:%.*]] = fadd fast <2 x float> [[TMP105]], [[TMP97]]
; CHECK-NEXT:    [[TMP114:%.*]] = fadd fast <2 x float> [[TMP106]], [[TMP98]]
; CHECK-NEXT:    [[TMP115:%.*]] = fadd fast <2 x float> [[TMP107]], [[TMP99]]
; CHECK-NEXT:    [[TMP21:%.*]] = fpext <2 x float> [[TMP80]] to <2 x double>
; CHECK-NEXT:    [[TMP22:%.*]] = fpext <2 x float> [[TMP113]] to <2 x double>
; CHECK-NEXT:    [[TMP23:%.*]] = fpext <2 x float> [[TMP114]] to <2 x double>
; CHECK-NEXT:    [[TMP24:%.*]] = fpext <2 x float> [[TMP115]] to <2 x double>
; CHECK-NEXT:    [[TMP25:%.*]] = fadd fast <2 x double> [[TMP21]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP26:%.*]] = fadd fast <2 x double> [[TMP22]], [[VEC_PHI1]]
; CHECK-NEXT:    [[TMP27:%.*]] = fadd fast <2 x double> [[TMP23]], [[VEC_PHI2]]
; CHECK-NEXT:    [[TMP28:%.*]] = fadd fast <2 x double> [[TMP24]], [[VEC_PHI3]]
; CHECK-NEXT:    [[TMP100:%.*]] = fmul fast <2 x float> [[STRIDED_VEC38]], [[STRIDED_VEC38]]
; CHECK-NEXT:    [[TMP101:%.*]] = fmul fast <2 x float> [[STRIDED_VEC45]], [[STRIDED_VEC45]]
; CHECK-NEXT:    [[TMP102:%.*]] = fmul fast <2 x float> [[STRIDED_VEC52]], [[STRIDED_VEC52]]
; CHECK-NEXT:    [[TMP103:%.*]] = fmul fast <2 x float> [[STRIDED_VEC59]], [[STRIDED_VEC59]]
; CHECK-NEXT:    [[TMP108:%.*]] = fmul fast <2 x float> [[STRIDED_VEC39]], [[STRIDED_VEC39]]
; CHECK-NEXT:    [[TMP109:%.*]] = fmul fast <2 x float> [[STRIDED_VEC46]], [[STRIDED_VEC46]]
; CHECK-NEXT:    [[TMP110:%.*]] = fmul fast <2 x float> [[STRIDED_VEC53]], [[STRIDED_VEC53]]
; CHECK-NEXT:    [[TMP111:%.*]] = fmul fast <2 x float> [[STRIDED_VEC60]], [[STRIDED_VEC60]]
; CHECK-NEXT:    [[TMP116:%.*]] = fadd fast <2 x float> [[TMP108]], [[TMP100]]
; CHECK-NEXT:    [[TMP117:%.*]] = fadd fast <2 x float> [[TMP109]], [[TMP101]]
; CHECK-NEXT:    [[TMP118:%.*]] = fadd fast <2 x float> [[TMP110]], [[TMP102]]
; CHECK-NEXT:    [[TMP119:%.*]] = fadd fast <2 x float> [[TMP111]], [[TMP103]]
; CHECK-NEXT:    [[TMP41:%.*]] = fpext <2 x float> [[TMP116]] to <2 x double>
; CHECK-NEXT:    [[TMP42:%.*]] = fpext <2 x float> [[TMP117]] to <2 x double>
; CHECK-NEXT:    [[TMP43:%.*]] = fpext <2 x float> [[TMP118]] to <2 x double>
; CHECK-NEXT:    [[TMP44:%.*]] = fpext <2 x float> [[TMP119]] to <2 x double>
; CHECK-NEXT:    [[TMP45:%.*]] = fadd fast <2 x double> [[TMP41]], [[TMP25]]
; CHECK-NEXT:    [[TMP46:%.*]] = fadd fast <2 x double> [[TMP42]], [[TMP26]]
; CHECK-NEXT:    [[TMP47:%.*]] = fadd fast <2 x double> [[TMP43]], [[TMP27]]
; CHECK-NEXT:    [[TMP48:%.*]] = fadd fast <2 x double> [[TMP44]], [[TMP28]]
; CHECK-NEXT:    [[TMP104:%.*]] = fmul fast <2 x float> [[STRIDED_VEC40]], [[STRIDED_VEC40]]
; CHECK-NEXT:    [[TMP142:%.*]] = fmul fast <2 x float> [[STRIDED_VEC47]], [[STRIDED_VEC47]]
; CHECK-NEXT:    [[TMP147:%.*]] = fmul fast <2 x float> [[STRIDED_VEC54]], [[STRIDED_VEC54]]
; CHECK-NEXT:    [[TMP152:%.*]] = fmul fast <2 x float> [[STRIDED_VEC61]], [[STRIDED_VEC61]]
; CHECK-NEXT:    [[TMP112:%.*]] = fmul fast <2 x float> [[STRIDED_VEC41]], [[STRIDED_VEC41]]
; CHECK-NEXT:    [[TMP143:%.*]] = fmul fast <2 x float> [[STRIDED_VEC48]], [[STRIDED_VEC48]]
; CHECK-NEXT:    [[TMP148:%.*]] = fmul fast <2 x float> [[STRIDED_VEC55]], [[STRIDED_VEC55]]
; CHECK-NEXT:    [[TMP153:%.*]] = fmul fast <2 x float> [[STRIDED_VEC62]], [[STRIDED_VEC62]]
; CHECK-NEXT:    [[TMP120:%.*]] = fadd fast <2 x float> [[TMP112]], [[TMP104]]
; CHECK-NEXT:    [[TMP144:%.*]] = fadd fast <2 x float> [[TMP143]], [[TMP142]]
; CHECK-NEXT:    [[TMP149:%.*]] = fadd fast <2 x float> [[TMP148]], [[TMP147]]
; CHECK-NEXT:    [[TMP154:%.*]] = fadd fast <2 x float> [[TMP153]], [[TMP152]]
; CHECK-NEXT:    [[TMP61:%.*]] = fpext <2 x float> [[TMP120]] to <2 x double>
; CHECK-NEXT:    [[TMP62:%.*]] = fpext <2 x float> [[TMP144]] to <2 x double>
; CHECK-NEXT:    [[TMP63:%.*]] = fpext <2 x float> [[TMP149]] to <2 x double>
; CHECK-NEXT:    [[TMP155:%.*]] = fpext <2 x float> [[TMP154]] to <2 x double>
; CHECK-NEXT:    [[TMP69]] = fadd fast <2 x double> [[TMP61]], [[TMP45]]
; CHECK-NEXT:    [[TMP65]] = fadd fast <2 x double> [[TMP62]], [[TMP46]]
; CHECK-NEXT:    [[TMP66]] = fadd fast <2 x double> [[TMP63]], [[TMP47]]
; CHECK-NEXT:    [[TMP67]] = fadd fast <2 x double> [[TMP155]], [[TMP48]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP68:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP68]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd fast <2 x double> [[TMP65]], [[TMP69]]
; CHECK-NEXT:    [[BIN_RDX30:%.*]] = fadd fast <2 x double> [[TMP66]], [[BIN_RDX]]
; CHECK-NEXT:    [[TMP156:%.*]] = fadd fast <2 x double> [[TMP67]], [[BIN_RDX30]]
; CHECK-NEXT:    [[TMP158:%.*]] = call fast double @llvm.vector.reduce.fadd.v2f64(double 0.000000e+00, <2 x double> [[TMP156]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label %[[FOR_COND_FOR_END13_CRIT_EDGE:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[FOR_COND1_PREHEADER_PREHEADER]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi double [ [[TMP158]], %[[MIDDLE_BLOCK]] ], [ 0.000000e+00, %[[FOR_COND1_PREHEADER_PREHEADER]] ]
; CHECK-NEXT:    br label %[[FOR_COND1_PREHEADER:.*]]
; CHECK:       [[FOR_COND1_PREHEADER]]:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], %[[FOR_COND1_PREHEADER]] ], [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[SUM_026:%.*]] = phi double [ [[ADD10_2:%.*]], %[[FOR_COND1_PREHEADER]] ], [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX5_REALP:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 0, i32 0
; CHECK-NEXT:    [[ARRAYIDX5_REAL:%.*]] = load float, ptr [[ARRAYIDX5_REALP]], align 8
; CHECK-NEXT:    [[ARRAYIDX5_IMAGP:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 0, i32 1
; CHECK-NEXT:    [[ARRAYIDX5_IMAG:%.*]] = load float, ptr [[ARRAYIDX5_IMAGP]], align 8
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast float [[ARRAYIDX5_REAL]], [[ARRAYIDX5_REAL]]
; CHECK-NEXT:    [[MUL9:%.*]] = fmul fast float [[ARRAYIDX5_IMAG]], [[ARRAYIDX5_IMAG]]
; CHECK-NEXT:    [[ADD:%.*]] = fadd fast float [[MUL9]], [[MUL]]
; CHECK-NEXT:    [[CONV:%.*]] = fpext float [[ADD]] to double
; CHECK-NEXT:    [[ADD10:%.*]] = fadd fast double [[CONV]], [[SUM_026]]
; CHECK-NEXT:    [[ARRAYIDX5_REALP_1:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 1, i32 0
; CHECK-NEXT:    [[ARRAYIDX5_REAL_1:%.*]] = load float, ptr [[ARRAYIDX5_REALP_1]], align 8
; CHECK-NEXT:    [[ARRAYIDX5_IMAGP_1:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 1, i32 1
; CHECK-NEXT:    [[ARRAYIDX5_IMAG_1:%.*]] = load float, ptr [[ARRAYIDX5_IMAGP_1]], align 8
; CHECK-NEXT:    [[MUL_1:%.*]] = fmul fast float [[ARRAYIDX5_REAL_1]], [[ARRAYIDX5_REAL_1]]
; CHECK-NEXT:    [[MUL9_1:%.*]] = fmul fast float [[ARRAYIDX5_IMAG_1]], [[ARRAYIDX5_IMAG_1]]
; CHECK-NEXT:    [[ADD_1:%.*]] = fadd fast float [[MUL9_1]], [[MUL_1]]
; CHECK-NEXT:    [[CONV_1:%.*]] = fpext float [[ADD_1]] to double
; CHECK-NEXT:    [[ADD10_1:%.*]] = fadd fast double [[CONV_1]], [[ADD10]]
; CHECK-NEXT:    [[ARRAYIDX5_REALP_2:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 2, i32 0
; CHECK-NEXT:    [[ARRAYIDX5_REAL_2:%.*]] = load float, ptr [[ARRAYIDX5_REALP_2]], align 8
; CHECK-NEXT:    [[ARRAYIDX5_IMAGP_2:%.*]] = getelementptr inbounds [3 x { float, float }], ptr [[A]], i64 [[INDVARS_IV]], i64 2, i32 1
; CHECK-NEXT:    [[ARRAYIDX5_IMAG_2:%.*]] = load float, ptr [[ARRAYIDX5_IMAGP_2]], align 8
; CHECK-NEXT:    [[MUL_2:%.*]] = fmul fast float [[ARRAYIDX5_REAL_2]], [[ARRAYIDX5_REAL_2]]
; CHECK-NEXT:    [[MUL9_2:%.*]] = fmul fast float [[ARRAYIDX5_IMAG_2]], [[ARRAYIDX5_IMAG_2]]
; CHECK-NEXT:    [[ADD_2:%.*]] = fadd fast float [[MUL9_2]], [[MUL_2]]
; CHECK-NEXT:    [[CONV_2:%.*]] = fpext float [[ADD_2]] to double
; CHECK-NEXT:    [[ADD10_2]] = fadd fast double [[CONV_2]], [[ADD10_1]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[LFTR_WIDEIV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_COND_FOR_END13_CRIT_EDGE]], label %[[FOR_COND1_PREHEADER]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[FOR_COND_FOR_END13_CRIT_EDGE]]:
; CHECK-NEXT:    [[ADD10_2_LCSSA:%.*]] = phi double [ [[ADD10_2]], %[[FOR_COND1_PREHEADER]] ], [ [[TMP158]], %[[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[PHITMP:%.*]] = fptrunc double [[ADD10_2_LCSSA]] to float
; CHECK-NEXT:    br label %[[FOR_END13]]
; CHECK:       [[FOR_END13]]:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi float [ [[PHITMP]], %[[FOR_COND_FOR_END13_CRIT_EDGE]] ], [ 0.000000e+00, %[[ENTRY]] ]
; CHECK-NEXT:    store float [[SUM_0_LCSSA]], ptr [[R]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %cmp24 = icmp sgt i32 %n, 0
  br i1 %cmp24, label %for.cond1.preheader.preheader, label %for.end13

for.cond1.preheader.preheader:                    ; preds = %entry
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond1.preheader.preheader, %for.cond1.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.cond1.preheader ], [ 0, %for.cond1.preheader.preheader ]
  %sum.026 = phi double [ %add10.2, %for.cond1.preheader ], [ 0.000000e+00, %for.cond1.preheader.preheader ]
  %arrayidx5.realp = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 0, i32 0
  %arrayidx5.real = load float, ptr %arrayidx5.realp, align 8
  %arrayidx5.imagp = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 0, i32 1
  %arrayidx5.imag = load float, ptr %arrayidx5.imagp, align 8
  %mul = fmul fast float %arrayidx5.real, %arrayidx5.real
  %mul9 = fmul fast float %arrayidx5.imag, %arrayidx5.imag
  %add = fadd fast float %mul9, %mul
  %conv = fpext float %add to double
  %add10 = fadd fast double %conv, %sum.026
  %arrayidx5.realp.1 = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 1, i32 0
  %arrayidx5.real.1 = load float, ptr %arrayidx5.realp.1, align 8
  %arrayidx5.imagp.1 = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 1, i32 1
  %arrayidx5.imag.1 = load float, ptr %arrayidx5.imagp.1, align 8
  %mul.1 = fmul fast float %arrayidx5.real.1, %arrayidx5.real.1
  %mul9.1 = fmul fast float %arrayidx5.imag.1, %arrayidx5.imag.1
  %add.1 = fadd fast float %mul9.1, %mul.1
  %conv.1 = fpext float %add.1 to double
  %add10.1 = fadd fast double %conv.1, %add10
  %arrayidx5.realp.2 = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 2, i32 0
  %arrayidx5.real.2 = load float, ptr %arrayidx5.realp.2, align 8
  %arrayidx5.imagp.2 = getelementptr inbounds [3 x { float, float }], ptr %a, i64 %indvars.iv, i64 2, i32 1
  %arrayidx5.imag.2 = load float, ptr %arrayidx5.imagp.2, align 8
  %mul.2 = fmul fast float %arrayidx5.real.2, %arrayidx5.real.2
  %mul9.2 = fmul fast float %arrayidx5.imag.2, %arrayidx5.imag.2
  %add.2 = fadd fast float %mul9.2, %mul.2
  %conv.2 = fpext float %add.2 to double
  %add10.2 = fadd fast double %conv.2, %add10.1
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.cond.for.end13_crit_edge, label %for.cond1.preheader

for.cond.for.end13_crit_edge:                     ; preds = %for.cond1.preheader
  %add10.2.lcssa = phi double [ %add10.2, %for.cond1.preheader ]
  %phitmp = fptrunc double %add10.2.lcssa to float
  br label %for.end13

for.end13:                                        ; preds = %for.cond.for.end13_crit_edge, %entry
  %sum.0.lcssa = phi float [ %phitmp, %for.cond.for.end13_crit_edge ], [ 0.000000e+00, %entry ]
  store float %sum.0.lcssa, ptr %r, align 4
  ret void
}

;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.
