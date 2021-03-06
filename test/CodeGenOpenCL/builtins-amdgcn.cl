// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -triple amdgcn-unknown-unknown -S -emit-llvm -o - %s | FileCheck %s

#pragma OPENCL EXTENSION cl_khr_fp64 : enable

typedef unsigned long ulong;

// CHECK-LABEL: @test_div_scale_f64
// CHECK: call { double, i1 } @llvm.amdgcn.div.scale.f64(double %a, double %b, i1 true)
// CHECK-DAG: [[FLAG:%.+]] = extractvalue { double, i1 } %{{.+}}, 1
// CHECK-DAG: [[VAL:%.+]] = extractvalue { double, i1 } %{{.+}}, 0
// CHECK: [[FLAGEXT:%.+]] = zext i1 [[FLAG]] to i32
// CHECK: store i32 [[FLAGEXT]]
void test_div_scale_f64(global double* out, global int* flagout, double a, double b)
{
  bool flag;
  *out = __builtin_amdgcn_div_scale(a, b, true, &flag);
  *flagout = flag;
}

// CHECK-LABEL: @test_div_scale_f32
// CHECK: call { float, i1 } @llvm.amdgcn.div.scale.f32(float %a, float %b, i1 true)
// CHECK-DAG: [[FLAG:%.+]] = extractvalue { float, i1 } %{{.+}}, 1
// CHECK-DAG: [[VAL:%.+]] = extractvalue { float, i1 } %{{.+}}, 0
// CHECK: [[FLAGEXT:%.+]] = zext i1 [[FLAG]] to i32
// CHECK: store i32 [[FLAGEXT]]
void test_div_scale_f32(global float* out, global int* flagout, float a, float b)
{
  bool flag;
  *out = __builtin_amdgcn_div_scalef(a, b, true, &flag);
  *flagout = flag;
}

// CHECK-LABEL: @test_div_fmas_f32
// CHECK: call float @llvm.amdgcn.div.fmas.f32
void test_div_fmas_f32(global float* out, float a, float b, float c, int d)
{
  *out = __builtin_amdgcn_div_fmasf(a, b, c, d);
}

// CHECK-LABEL: @test_div_fmas_f64
// CHECK: call double @llvm.amdgcn.div.fmas.f64
void test_div_fmas_f64(global double* out, double a, double b, double c, int d)
{
  *out = __builtin_amdgcn_div_fmas(a, b, c, d);
}

// CHECK-LABEL: @test_div_fixup_f32
// CHECK: call float @llvm.amdgcn.div.fixup.f32
void test_div_fixup_f32(global float* out, float a, float b, float c)
{
  *out = __builtin_amdgcn_div_fixupf(a, b, c);
}

// CHECK-LABEL: @test_div_fixup_f64
// CHECK: call double @llvm.amdgcn.div.fixup.f64
void test_div_fixup_f64(global double* out, double a, double b, double c)
{
  *out = __builtin_amdgcn_div_fixup(a, b, c);
}

// CHECK-LABEL: @test_trig_preop_f32
// CHECK: call float @llvm.amdgcn.trig.preop.f32
void test_trig_preop_f32(global float* out, float a, int b)
{
  *out = __builtin_amdgcn_trig_preopf(a, b);
}

// CHECK-LABEL: @test_trig_preop_f64
// CHECK: call double @llvm.amdgcn.trig.preop.f64
void test_trig_preop_f64(global double* out, double a, int b)
{
  *out = __builtin_amdgcn_trig_preop(a, b);
}

// CHECK-LABEL: @test_rcp_f32
// CHECK: call float @llvm.amdgcn.rcp.f32
void test_rcp_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_rcpf(a);
}

// CHECK-LABEL: @test_rcp_f64
// CHECK: call double @llvm.amdgcn.rcp.f64
void test_rcp_f64(global double* out, double a)
{
  *out = __builtin_amdgcn_rcp(a);
}

// CHECK-LABEL: @test_rsq_f32
// CHECK: call float @llvm.amdgcn.rsq.f32
void test_rsq_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_rsqf(a);
}

// CHECK-LABEL: @test_rsq_f64
// CHECK: call double @llvm.amdgcn.rsq.f64
void test_rsq_f64(global double* out, double a)
{
  *out = __builtin_amdgcn_rsq(a);
}

// CHECK-LABEL: @test_rsq_clamp_f32
// CHECK: call float @llvm.amdgcn.rsq.clamp.f32
void test_rsq_clamp_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_rsq_clampf(a);
}

// CHECK-LABEL: @test_rsq_clamp_f64
// CHECK: call double @llvm.amdgcn.rsq.clamp.f64
void test_rsq_clamp_f64(global double* out, double a)
{
  *out = __builtin_amdgcn_rsq_clamp(a);
}

// CHECK-LABEL: @test_sin_f32
// CHECK: call float @llvm.amdgcn.sin.f32
void test_sin_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_sinf(a);
}

// CHECK-LABEL: @test_cos_f32
// CHECK: call float @llvm.amdgcn.cos.f32
void test_cos_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_cosf(a);
}

// CHECK-LABEL: @test_log_clamp_f32
// CHECK: call float @llvm.amdgcn.log.clamp.f32
void test_log_clamp_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_log_clampf(a);
}

// CHECK-LABEL: @test_ldexp_f32
// CHECK: call float @llvm.amdgcn.ldexp.f32
void test_ldexp_f32(global float* out, float a, int b)
{
  *out = __builtin_amdgcn_ldexpf(a, b);
}

// CHECK-LABEL: @test_ldexp_f64
// CHECK: call double @llvm.amdgcn.ldexp.f64
void test_ldexp_f64(global double* out, double a, int b)
{
  *out = __builtin_amdgcn_ldexp(a, b);
}

// CHECK-LABEL: @test_frexp_mant_f32
// CHECK: call float @llvm.amdgcn.frexp.mant.f32
void test_frexp_mant_f32(global float* out, float a)
{
  *out = __builtin_amdgcn_frexp_mantf(a);
}

// CHECK-LABEL: @test_frexp_mant_f64
// CHECK: call double @llvm.amdgcn.frexp.mant.f64
void test_frexp_mant_f64(global double* out, double a)
{
  *out = __builtin_amdgcn_frexp_mant(a);
}

// CHECK-LABEL: @test_frexp_exp_f32
// CHECK: call i32 @llvm.amdgcn.frexp.exp.f32
void test_frexp_exp_f32(global int* out, float a)
{
  *out = __builtin_amdgcn_frexp_expf(a);
}

// CHECK-LABEL: @test_frexp_exp_f64
// CHECK: call i32 @llvm.amdgcn.frexp.exp.f64
void test_frexp_exp_f64(global int* out, double a)
{
  *out = __builtin_amdgcn_frexp_exp(a);
}

// CHECK-LABEL: @test_fract_f32
// CHECK: call float @llvm.amdgcn.fract.f32
void test_fract_f32(global int* out, float a)
{
  *out = __builtin_amdgcn_fractf(a);
}

// CHECK-LABEL: @test_fract_f64
// CHECK: call double @llvm.amdgcn.fract.f64
void test_fract_f64(global int* out, double a)
{
  *out = __builtin_amdgcn_fract(a);
}

// CHECK-LABEL: @test_class_f32
// CHECK: call i1 @llvm.amdgcn.class.f32
void test_class_f32(global float* out, float a, int b)
{
  *out = __builtin_amdgcn_classf(a, b);
}

// CHECK-LABEL: @test_class_f64
// CHECK: call i1 @llvm.amdgcn.class.f64
void test_class_f64(global double* out, double a, int b)
{
  *out = __builtin_amdgcn_class(a, b);
}

// CHECK-LABEL: @test_s_barrier
// CHECK: call void @llvm.amdgcn.s.barrier(
void test_s_barrier()
{
  __builtin_amdgcn_s_barrier();
}

// CHECK-LABEL: @test_s_memtime
// CHECK: call i64 @llvm.amdgcn.s.memtime()
void test_s_memtime(global ulong* out)
{
  *out = __builtin_amdgcn_s_memtime();
}

// CHECK-LABEL: @test_s_sleep
// CHECK: call void @llvm.amdgcn.s.sleep(i32 1)
// CHECK: call void @llvm.amdgcn.s.sleep(i32 15)
void test_s_sleep()
{
  __builtin_amdgcn_s_sleep(1);
  __builtin_amdgcn_s_sleep(15);
}

// CHECK-LABEL: @test_cubeid(
// CHECK: call float @llvm.amdgcn.cubeid(float %a, float %b, float %c)
void test_cubeid(global float* out, float a, float b, float c) {
  *out = __builtin_amdgcn_cubeid(a, b, c);
}

// CHECK-LABEL: @test_cubesc(
// CHECK: call float @llvm.amdgcn.cubesc(float %a, float %b, float %c)
void test_cubesc(global float* out, float a, float b, float c) {
  *out = __builtin_amdgcn_cubesc(a, b, c);
}

// CHECK-LABEL: @test_cubetc(
// CHECK: call float @llvm.amdgcn.cubetc(float %a, float %b, float %c)
void test_cubetc(global float* out, float a, float b, float c) {
  *out = __builtin_amdgcn_cubetc(a, b, c);
}

// CHECK-LABEL: @test_cubema(
// CHECK: call float @llvm.amdgcn.cubema(float %a, float %b, float %c)
void test_cubema(global float* out, float a, float b, float c) {
  *out = __builtin_amdgcn_cubema(a, b, c);
}

// CHECK-LABEL: @test_read_exec(
// CHECK: call i64 @llvm.read_register.i64(metadata ![[EXEC:[0-9]+]]) #[[READ_EXEC_ATTRS:[0-9]+]]
void test_read_exec(global ulong* out) {
  *out = __builtin_amdgcn_read_exec();
}

// CHECK: declare i64 @llvm.read_register.i64(metadata) #[[NOUNWIND_READONLY:[0-9]+]]

// Legacy intrinsics with AMDGPU prefix

// CHECK-LABEL: @test_legacy_rsq_f32
// CHECK: call float @llvm.amdgcn.rsq.f32
void test_legacy_rsq_f32(global float* out, float a)
{
  *out = __builtin_amdgpu_rsqf(a);
}

// CHECK-LABEL: @test_legacy_rsq_f64
// CHECK: call double @llvm.amdgcn.rsq.f64
void test_legacy_rsq_f64(global double* out, double a)
{
  *out = __builtin_amdgpu_rsq(a);
}

// CHECK-LABEL: @test_legacy_ldexp_f32
// CHECK: call float @llvm.amdgcn.ldexp.f32
void test_legacy_ldexp_f32(global float* out, float a, int b)
{
  *out = __builtin_amdgpu_ldexpf(a, b);
}

// CHECK-LABEL: @test_legacy_ldexp_f64
// CHECK: call double @llvm.amdgcn.ldexp.f64
void test_legacy_ldexp_f64(global double* out, double a, int b)
{
  *out = __builtin_amdgpu_ldexp(a, b);
}

// CHECK-DAG: attributes #[[NOUNWIND_READONLY:[0-9]+]] = { nounwind readonly }
// CHECK-DAG: attributes #[[READ_EXEC_ATTRS]] = { convergent }
// CHECK: ![[EXEC]] = !{!"exec"}
