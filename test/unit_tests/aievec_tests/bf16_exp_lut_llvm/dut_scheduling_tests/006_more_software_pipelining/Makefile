all: dut_inlined.ll dut.ll dut_no_opt_inlined.ll

after-vector.mlir: bf16_exp_lut_llvm.mlir
	aie-opt bf16_exp_lut_llvm.mlir -affine-super-vectorize="virtual-vector-size=16" --convert-vector-to-aievec="aie-target=aieml target-backend=llvmir" -lower-affine -o after-vector.mlir

dut_inlined.ll: dut_inlined.cc
	clang $(CL_ARGS) -O3 dut_inlined.cc -o dut_inlined.ll

dut.ll: dut.cc
	clang -I ~/staff/mlir-aie/aie_runtime_lib/AIE2/ $(CL_ARGS) -O3 dut.cc -o dut.ll

dut_no_opt_inlined.ll: dut_no_opt_inlined.cc
	clang -I ~/staff/mlir-aie/aie_runtime_lib/AIE2/ $(CL_ARGS) -O3 dut_no_opt_inlined.cc -o dut_no_opt_inlined.ll
