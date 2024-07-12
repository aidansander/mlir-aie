#include "aie_api/aie.hpp"

alignas(aie::vector_decl_align) extern int16 exp_ilut_ab[512];
alignas(aie::vector_decl_align) extern int16 exp_ilut_cd[512];
alignas(aie::vector_decl_align) extern int16 exp_flut_ab[512];
alignas(aie::vector_decl_align) extern int16 exp_flut_cd[512];
alignas(aie::vector_decl_align) extern unsigned char m_inv_lut[128];

void dut(bfloat16 *restrict v1, bfloat16 *restrict v2) {
  size_t v3 = 0;
  size_t v4 = 1024;
  size_t v5 = 16;
  bfloat16 __aie_dm_resource_a *ilut_ab =
      (bfloat16 __aie_dm_resource_a *)exp_ilut_ab;
  bfloat16 __aie_dm_resource_b *ilut_cd =
      (bfloat16 __aie_dm_resource_b *)exp_ilut_cd;
  bfloat16 __aie_dm_resource_a *flut_ab =
      (bfloat16 __aie_dm_resource_a *)exp_flut_ab;
  bfloat16 __aie_dm_resource_b *flut_cd =
      (bfloat16 __aie_dm_resource_b *)exp_flut_cd;

  using lut_type = aie::lut<4, bfloat16, bfloat16>;
  const int LUT_elems = 256;
  const int step_i = 8;
  const int step_f = 0;

  lut_type lut_i(LUT_elems, ilut_ab, ilut_cd);
  lut_type lut_f(LUT_elems, flut_ab, flut_cd);
  aie::parallel_lookup<uint16, lut_type, aie::lut_oor_policy::truncate>
      lookup_i(lut_i, step_i);
  aie::parallel_lookup<uint16, lut_type, aie::lut_oor_policy::truncate>
      lookup_f(lut_f, step_f);

  aie::vector<bfloat16, 16> I_val_vec, F_val_vec, I_val_vec_roll, F_val_vec_roll;
  aie::accum<accfloat, 16> exp_val;

  v16accfloat v8;
  v16bfloat16 v9;
  aie::vector<int16, 16> input;
  
  //prolog 0

  v16bfloat16 v7_roll = *(v16bfloat16 *)(v1 + v3);
  //prolog 1

  v16bfloat16 v7 = v7_roll;

  v7_roll = *(v16bfloat16 *)(v1 + v3 + v5);

  aie::vector<bfloat16, 16> input_bf16 = v7;
  aie::vector<int16, 32> input0 = v32int16(bfloat16_to_int(input_bf16, 8));
  aie::vector<int16, 16> input_roll = aie::filter_even(input0);

  //prolog 2
  v7=v7_roll;

  v7_roll = *(v16bfloat16 *)(v1 + v3 + v5*2);

  input = input_roll;

  input_bf16 = v7;
  input0 = v32int16(bfloat16_to_int(input_bf16, 8));
  input_roll = aie::filter_even(input0);

  auto input_casted = input.cast_to<uint16>();

  I_val_vec_roll = lookup_i.fetch(input_casted);
  F_val_vec_roll = lookup_f.fetch(input_casted);


#pragma unroll
  for (size_t v6 = v3; v6 < v4 - v5*3; v6 += v5){
      I_val_vec = I_val_vec_roll;
      F_val_vec = F_val_vec_roll;
      input = input_roll;
      input_casted = input.cast_to<uint16>();
      v7 = v7_roll;
      v7_roll = *(v16bfloat16 *)(v1 + v6 + v5*3);
      input_bf16 = v7;
      // position of output decimal point = 8, making input become 8 bits, and for
      // LUT_elems = 256 lookup. aie::vector<int16, 16>
      // input=aie::to_fixed<int16>(input_bf16,8);
      input0 = v32int16(bfloat16_to_int(input_bf16, 8));
      input_roll = aie::filter_even(input0);

      I_val_vec_roll = lookup_i.fetch(input_casted);
      F_val_vec_roll = lookup_f.fetch(input_casted);
      exp_val = aie::mul(I_val_vec, F_val_vec);
      v8 = v16accfloat(exp_val);
      v9 = to_v16bfloat16(v8);
      *(v16bfloat16 *)(v2 + v6) = v9;
  }
  //epilog 0

  I_val_vec = I_val_vec_roll;
  F_val_vec = F_val_vec_roll;
  input = input_roll;
  input_casted = input.cast_to<uint16>();
  v7 = v7_roll;
  
  input_bf16 = v7;
  input0 = v32int16(bfloat16_to_int(input_bf16, 8));
  input_roll = aie::filter_even(input0);

  I_val_vec_roll = lookup_i.fetch(input_casted);
  F_val_vec_roll = lookup_f.fetch(input_casted);
  exp_val = aie::mul(I_val_vec, F_val_vec);
  v8 = v16accfloat(exp_val);
  v9 = to_v16bfloat16(v8);
  *(v16bfloat16 *)(v2+ v4 - v5 * 3) = v9;

  //epilog 1
  
  I_val_vec = I_val_vec_roll;
  F_val_vec = F_val_vec_roll;
  input = input_roll;
  input_casted = input.cast_to<uint16>();

  I_val_vec_roll = lookup_i.fetch(input_casted);
  F_val_vec_roll = lookup_f.fetch(input_casted);
  exp_val = aie::mul(I_val_vec, F_val_vec);
  v8 = v16accfloat(exp_val);
  v9 = to_v16bfloat16(v8);
  *(v16bfloat16 *)(v2 + v4 - v5*2) = v9;

  //epilog 2


  I_val_vec = lookup_i.fetch(input.cast_to<uint16>());
  F_val_vec = lookup_f.fetch(input.cast_to<uint16>());
  exp_val = aie::mul(I_val_vec, F_val_vec);
  v8 = v16accfloat(exp_val);
  v9 = to_v16bfloat16(v8);
  *(v16bfloat16 *)(v2 + v4 - v5) = v9;

  return;
}
