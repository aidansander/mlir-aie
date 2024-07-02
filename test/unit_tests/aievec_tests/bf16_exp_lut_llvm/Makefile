after-vector.mlir: bf16_exp_lut_llvm.mlir
	aie-opt bf16_exp_lut_llvm.mlir -affine-super-vectorize="virtual-vector-size=16" --convert-vector-to-aievec="aie-target=aieml target-backend=llvmir" -lower-affine -o after-vector.mlir
