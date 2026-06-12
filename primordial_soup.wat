(module
 (type $0 (func (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32)))
 (type $3 (func (param i32) (result i32)))
 (type $4 (func (param f64) (result f64)))
 (type $5 (func (param i64)))
 (type $6 (func (param i32)))
 (type $7 (func (param i64) (result i32)))
 (type $8 (func (param i32 i32 i32 i64)))
 (global $assembly_index/gridWidth (mut i32) (i32.const 0))
 (global $assembly_index/gridHeight (mut i32) (i32.const 0))
 (global $assembly_index/tapeSize (mut i32) (i32.const 0))
 (global $assembly_index/numPrograms (mut i32) (i32.const 0))
 (global $assembly_index/langVersion (mut i32) (i32.const 1))
 (global $assembly_index/couplingMode (mut i32) (i32.const 0))
 (global $assembly_index/sweepCounter (mut i32) (i32.const 0))
 (global $assembly_index/substrateOn (mut i32) (i32.const 0))
 (global $assembly_index/substrateStrength (mut i32) (i32.const 60))
 (global $assembly_index/programsPtr (mut i32) (i32.const 0))
 (global $assembly_index/neighborsPtr (mut i32) (i32.const 0))
 (global $assembly_index/nCountsPtr (mut i32) (i32.const 0))
 (global $assembly_index/orderPtr (mut i32) (i32.const 0))
 (global $assembly_index/proposalsPtr (mut i32) (i32.const 0))
 (global $assembly_index/pairsPtr (mut i32) (i32.const 0))
 (global $assembly_index/takenPtr (mut i32) (i32.const 0))
 (global $assembly_index/tapePtr (mut i32) (i32.const 0))
 (global $assembly_index/pixelsPtr (mut i32) (i32.const 0))
 (global $assembly_index/colorLutPtr (mut i32) (i32.const 0))
 (global $assembly_index/histogramPtr (mut i32) (i32.const 0))
 (global $assembly_index/substratePtr (mut i32) (i32.const 0))
 (global $assembly_index/rngS0 (mut i64) (i64.const 0))
 (global $assembly_index/rngS1 (mut i64) (i64.const 0))
 (global $~lib/math/rempio2_y0 (mut f64) (f64.const 0))
 (global $~lib/math/rempio2_y1 (mut f64) (f64.const 0))
 (global $~lib/math/res128_hi (mut i64) (i64.const 0))
 (memory $0 1)
 (data $0 (i32.const 1024) "n\83\f9\a2\00\00\00\00\d1W\'\fc)\15DN\99\95b\db\c0\dd4\f5\abcQ\feA\90C<:n$\b7a\c5\bb\de\ea.I\06\e0\d2MB\1c\eb\1d\fe\1c\92\d1\t\f55\82\e8>\a7)\b1&p\9c\e9\84D\bb.9\d6\919A~_\b4\8b_\84\9c\f49S\83\ff\97\f8\1f;(\f9\bd\8b\11/\ef\0f\98\05\de\cf~6m\1fm\nZf?FO\b7\t\cb\'\c7\ba\'u-\ea_\9e\f79\07={\f1\e5\eb\b1_\fbk\ea\92R\8aF0\03V\08]\8d\1f \bc\cf\f0\abk{\fca\91\e3\a9\1d6\f4\9a_\85\99e\08\1b\e6^\80\d8\ff\8d@h\a0\14W\15\06\061\'sM")
 (export "setLangVersion" (func $assembly_index/setLangVersion))
 (export "getLangVersion" (func $assembly_index/getLangVersion))
 (export "init" (func $assembly_index/init))
 (export "getPixelsPtr" (func $assembly_index/getPixelsPtr))
 (export "getPixelsLen" (func $assembly_index/getPixelsLen))
 (export "getProgramsPtr" (func $assembly_index/getProgramsPtr))
 (export "setCoupling" (func $assembly_index/setCoupling))
 (export "getCoupling" (func $assembly_index/getCoupling))
 (export "setSubstrate" (func $assembly_index/setSubstrate))
 (export "regenSubstrate" (func $assembly_index/regenSubstrate))
 (export "getSubstratePtr" (func $assembly_index/getSubstratePtr))
 (export "getSubstrateLen" (func $assembly_index/getSubstrateLen))
 (export "renderPixels" (func $assembly_index/renderPixels))
 (export "step" (func $assembly_index/step))
 (export "opcodeCount" (func $assembly_index/opcodeCount))
 (export "totalCells" (func $assembly_index/totalCells))
 (export "getHistogramPtr" (func $assembly_index/getHistogramPtr))
 (export "computeHistogram" (func $assembly_index/computeHistogram))
 (export "memory" (memory $0))
 (func $assembly_index/rngBounded (param $0 i32) (result i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  local.get $0
  i32.const 1
  i32.le_u
  if
   i32.const 0
   return
  end
  global.get $assembly_index/rngS0
  local.set $1
  global.get $assembly_index/rngS1
  local.tee $4
  global.set $assembly_index/rngS0
  local.get $1
  local.get $1
  i64.const 23
  i64.shl
  i64.xor
  local.tee $1
  i64.const 17
  i64.shr_u
  local.get $1
  i64.xor
  local.get $4
  i64.xor
  local.get $4
  i64.const 26
  i64.shr_u
  i64.xor
  global.set $assembly_index/rngS1
  global.get $assembly_index/rngS0
  global.get $assembly_index/rngS1
  i64.add
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.set $2
  local.get $0
  i32.const -1
  i32.xor
  i32.const 1
  i32.add
  local.get $0
  i32.rem_u
  local.set $3
  loop $while-continue|0
   local.get $2
   local.get $3
   i32.lt_u
   if
    global.get $assembly_index/rngS0
    local.set $1
    global.get $assembly_index/rngS1
    local.tee $4
    global.set $assembly_index/rngS0
    local.get $1
    local.get $1
    i64.const 23
    i64.shl
    i64.xor
    local.tee $1
    i64.const 17
    i64.shr_u
    local.get $1
    i64.xor
    local.get $4
    i64.xor
    local.get $4
    i64.const 26
    i64.shr_u
    i64.xor
    global.set $assembly_index/rngS1
    global.get $assembly_index/rngS0
    global.get $assembly_index/rngS1
    i64.add
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    local.set $2
    br $while-continue|0
   end
  end
  local.get $2
  local.get $0
  i32.rem_u
 )
 (func $~lib/math/pio2_large_quot (param $0 i64) (result i32)
  (local $1 i64)
  (local $2 i64)
  (local $3 i64)
  (local $4 i32)
  (local $5 f64)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local $9 i64)
  (local $10 i64)
  (local $11 i64)
  (local $12 i64)
  local.get $0
  i64.const 9223372036854775807
  i64.and
  i64.const 52
  i64.shr_u
  i64.const 1045
  i64.sub
  local.tee $1
  i64.const 63
  i64.and
  local.set $6
  local.get $1
  i64.const 6
  i64.shr_s
  i32.wrap_i64
  i32.const 3
  i32.shl
  i32.const 1024
  i32.add
  local.tee $4
  i64.load
  local.set $3
  local.get $4
  i64.load offset=8
  local.set $2
  local.get $4
  i64.load offset=16
  local.set $1
  local.get $6
  i64.const 0
  i64.ne
  if
   local.get $3
   local.get $6
   i64.shl
   local.get $2
   i64.const 64
   local.get $6
   i64.sub
   local.tee $7
   i64.shr_u
   i64.or
   local.set $3
   local.get $2
   local.get $6
   i64.shl
   local.get $1
   local.get $7
   i64.shr_u
   i64.or
   local.set $2
   local.get $1
   local.get $6
   i64.shl
   local.get $4
   i64.load offset=24
   local.get $7
   i64.shr_u
   i64.or
   local.set $1
  end
  local.get $0
  i64.const 4503599627370495
  i64.and
  i64.const 4503599627370496
  i64.or
  local.tee $6
  i64.const 4294967295
  i64.and
  local.set $7
  local.get $2
  i64.const 4294967295
  i64.and
  local.tee $8
  local.get $6
  i64.const 32
  i64.shr_u
  local.tee $9
  i64.mul
  local.get $2
  i64.const 32
  i64.shr_u
  local.tee $2
  local.get $7
  i64.mul
  local.get $7
  local.get $8
  i64.mul
  local.tee $7
  i64.const 32
  i64.shr_u
  i64.add
  local.tee $8
  i64.const 4294967295
  i64.and
  i64.add
  local.set $10
  local.get $2
  local.get $9
  i64.mul
  local.get $8
  i64.const 32
  i64.shr_u
  i64.add
  local.get $10
  i64.const 32
  i64.shr_u
  i64.add
  global.set $~lib/math/res128_hi
  local.get $9
  local.get $1
  i64.const 32
  i64.shr_u
  i64.mul
  local.tee $1
  local.get $7
  i64.const 4294967295
  i64.and
  local.get $10
  i64.const 32
  i64.shl
  i64.add
  i64.add
  local.tee $2
  local.get $1
  i64.lt_u
  i64.extend_i32_u
  global.get $~lib/math/res128_hi
  local.get $3
  local.get $6
  i64.mul
  i64.add
  i64.add
  local.tee $3
  i64.const 2
  i64.shl
  local.get $2
  i64.const 62
  i64.shr_u
  i64.or
  local.tee $6
  i64.const 63
  i64.shr_s
  local.tee $7
  local.get $2
  i64.const 2
  i64.shl
  i64.xor
  local.set $2
  local.get $6
  local.get $7
  i64.const 1
  i64.shr_s
  i64.xor
  local.tee $1
  i64.clz
  local.set $8
  local.get $1
  local.get $8
  i64.shl
  local.get $2
  i64.const 64
  local.get $8
  i64.sub
  i64.shr_u
  i64.or
  local.tee $9
  i64.const 4294967295
  i64.and
  local.set $1
  local.get $9
  i64.const 32
  i64.shr_u
  local.tee $10
  i64.const 560513588
  i64.mul
  local.get $1
  i64.const 3373259426
  i64.mul
  local.get $1
  i64.const 560513588
  i64.mul
  local.tee $11
  i64.const 32
  i64.shr_u
  i64.add
  local.tee $12
  i64.const 4294967295
  i64.and
  i64.add
  local.set $1
  local.get $10
  i64.const 3373259426
  i64.mul
  local.get $12
  i64.const 32
  i64.shr_u
  i64.add
  local.get $1
  i64.const 32
  i64.shr_u
  i64.add
  global.set $~lib/math/res128_hi
  local.get $9
  f64.convert_i64_u
  f64.const 3.753184150245214e-04
  f64.mul
  local.get $2
  local.get $8
  i64.shl
  f64.convert_i64_u
  f64.const 3.834951969714103e-04
  f64.mul
  f64.add
  i64.trunc_sat_f64_u
  local.tee $2
  local.get $11
  i64.const 4294967295
  i64.and
  local.get $1
  i64.const 32
  i64.shl
  i64.add
  local.tee $1
  i64.gt_u
  i64.extend_i32_u
  global.get $~lib/math/res128_hi
  local.tee $9
  i64.const 11
  i64.shr_u
  i64.add
  f64.convert_i64_u
  global.set $~lib/math/rempio2_y0
  local.get $9
  i64.const 53
  i64.shl
  local.get $1
  i64.const 11
  i64.shr_u
  i64.or
  local.get $2
  i64.add
  f64.convert_i64_u
  f64.const 5.421010862427522e-20
  f64.mul
  global.set $~lib/math/rempio2_y1
  global.get $~lib/math/rempio2_y0
  i64.const 4372995238176751616
  local.get $8
  i64.const 52
  i64.shl
  i64.sub
  local.get $0
  local.get $6
  i64.xor
  i64.const -9223372036854775808
  i64.and
  i64.or
  f64.reinterpret_i64
  local.tee $5
  f64.mul
  global.set $~lib/math/rempio2_y0
  global.get $~lib/math/rempio2_y1
  local.get $5
  f64.mul
  global.set $~lib/math/rempio2_y1
  local.get $3
  i64.const 62
  i64.shr_s
  local.get $7
  i64.sub
  i32.wrap_i64
 )
 (func $~lib/math/NativeMath.sin (param $0 f64) (result f64)
  (local $1 f64)
  (local $2 f64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 f64)
  (local $8 f64)
  (local $9 f64)
  local.get $0
  i64.reinterpret_f64
  local.tee $5
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.tee $3
  i32.const 31
  i32.shr_u
  local.set $6
  local.get $3
  i32.const 2147483647
  i32.and
  local.tee $3
  i32.const 1072243195
  i32.le_u
  if
   local.get $3
   i32.const 1045430272
   i32.lt_u
   if
    local.get $0
    return
   end
   local.get $0
   local.get $0
   local.get $0
   f64.mul
   local.tee $1
   local.get $0
   f64.mul
   local.get $1
   local.get $1
   local.get $1
   f64.const 2.7557313707070068e-06
   f64.mul
   f64.const -1.984126982985795e-04
   f64.add
   f64.mul
   f64.const 0.00833333333332249
   f64.add
   local.get $1
   local.get $1
   local.get $1
   f64.mul
   f64.mul
   local.get $1
   f64.const 1.58969099521155e-10
   f64.mul
   f64.const -2.5050760253406863e-08
   f64.add
   f64.mul
   f64.add
   f64.mul
   f64.const -0.16666666666666632
   f64.add
   f64.mul
   f64.add
   return
  end
  local.get $3
  i32.const 2146435072
  i32.ge_u
  if
   local.get $0
   local.get $0
   f64.sub
   return
  end
  block $~lib/math/rempio2|inlined.0 (result i32)
   local.get $5
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   i32.const 2147483647
   i32.and
   local.tee $4
   i32.const 1073928572
   i32.lt_u
   if
    i32.const 1
    local.set $3
    local.get $6
    if (result f64)
     local.get $0
     f64.const 1.5707963267341256
     f64.add
     local.set $0
     i32.const -1
     local.set $3
     local.get $4
     i32.const 1073291771
     i32.ne
     if (result f64)
      local.get $0
      local.get $0
      f64.const 6.077100506506192e-11
      f64.add
      local.tee $0
      f64.sub
      f64.const 6.077100506506192e-11
      f64.add
     else
      local.get $0
      f64.const 6.077100506303966e-11
      f64.add
      local.tee $1
      f64.const 2.0222662487959506e-21
      f64.add
      local.set $0
      local.get $1
      local.get $0
      f64.sub
      f64.const 2.0222662487959506e-21
      f64.add
     end
    else
     local.get $0
     f64.const -1.5707963267341256
     f64.add
     local.set $0
     local.get $4
     i32.const 1073291771
     i32.ne
     if (result f64)
      local.get $0
      local.get $0
      f64.const -6.077100506506192e-11
      f64.add
      local.tee $0
      f64.sub
      f64.const -6.077100506506192e-11
      f64.add
     else
      local.get $0
      f64.const -6.077100506303966e-11
      f64.add
      local.tee $1
      f64.const -2.0222662487959506e-21
      f64.add
      local.set $0
      local.get $1
      local.get $0
      f64.sub
      f64.const -2.0222662487959506e-21
      f64.add
     end
    end
    local.get $0
    global.set $~lib/math/rempio2_y0
    global.set $~lib/math/rempio2_y1
    local.get $3
    br $~lib/math/rempio2|inlined.0
   end
   local.get $4
   i32.const 1094263291
   i32.lt_u
   if
    local.get $4
    i32.const 20
    i32.shr_u
    local.tee $3
    local.get $0
    local.get $0
    f64.const 0.6366197723675814
    f64.mul
    f64.nearest
    local.tee $7
    f64.const 1.5707963267341256
    f64.mul
    f64.sub
    local.tee $0
    local.get $7
    f64.const 6.077100506506192e-11
    f64.mul
    local.tee $2
    f64.sub
    local.tee $1
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 20
    i32.shr_u
    i32.const 2047
    i32.and
    i32.sub
    i32.const 16
    i32.gt_u
    if
     local.get $7
     f64.const 2.0222662487959506e-21
     f64.mul
     local.get $0
     local.get $0
     local.get $7
     f64.const 6.077100506303966e-11
     f64.mul
     local.tee $1
     f64.sub
     local.tee $0
     f64.sub
     local.get $1
     f64.sub
     f64.sub
     local.set $2
     local.get $3
     local.get $0
     local.get $2
     f64.sub
     local.tee $1
     i64.reinterpret_f64
     i64.const 32
     i64.shr_u
     i32.wrap_i64
     i32.const 20
     i32.shr_u
     i32.const 2047
     i32.and
     i32.sub
     i32.const 49
     i32.gt_u
     if
      local.get $7
      f64.const 8.4784276603689e-32
      f64.mul
      local.get $0
      local.get $0
      local.get $7
      f64.const 2.0222662487111665e-21
      f64.mul
      local.tee $1
      f64.sub
      local.tee $0
      f64.sub
      local.get $1
      f64.sub
      f64.sub
      local.set $2
      local.get $0
      local.get $2
      f64.sub
      local.set $1
     end
    end
    local.get $1
    global.set $~lib/math/rempio2_y0
    local.get $0
    local.get $1
    f64.sub
    local.get $2
    f64.sub
    global.set $~lib/math/rempio2_y1
    local.get $7
    i32.trunc_sat_f64_s
    br $~lib/math/rempio2|inlined.0
   end
   i32.const 0
   local.get $5
   call $~lib/math/pio2_large_quot
   local.tee $3
   i32.sub
   local.get $3
   local.get $6
   select
  end
  local.set $3
  global.get $~lib/math/rempio2_y0
  local.set $2
  global.get $~lib/math/rempio2_y1
  local.set $7
  local.get $3
  i32.const 1
  i32.and
  if (result f64)
   local.get $2
   local.get $2
   f64.mul
   local.tee $0
   local.get $0
   f64.mul
   local.set $1
   f64.const 1
   local.get $0
   f64.const 0.5
   f64.mul
   local.tee $8
   f64.sub
   local.tee $9
   f64.const 1
   local.get $9
   f64.sub
   local.get $8
   f64.sub
   local.get $0
   local.get $0
   local.get $0
   local.get $0
   f64.const 2.480158728947673e-05
   f64.mul
   f64.const -0.001388888888887411
   f64.add
   f64.mul
   f64.const 0.0416666666666666
   f64.add
   f64.mul
   local.get $1
   local.get $1
   f64.mul
   local.get $0
   local.get $0
   f64.const -1.1359647557788195e-11
   f64.mul
   f64.const 2.087572321298175e-09
   f64.add
   f64.mul
   f64.const -2.7557314351390663e-07
   f64.add
   f64.mul
   f64.add
   f64.mul
   local.get $2
   local.get $7
   f64.mul
   f64.sub
   f64.add
   f64.add
  else
   local.get $2
   local.get $2
   f64.mul
   local.tee $0
   local.get $2
   f64.mul
   local.set $1
   local.get $2
   local.get $0
   local.get $7
   f64.const 0.5
   f64.mul
   local.get $1
   local.get $0
   local.get $0
   f64.const 2.7557313707070068e-06
   f64.mul
   f64.const -1.984126982985795e-04
   f64.add
   f64.mul
   f64.const 0.00833333333332249
   f64.add
   local.get $0
   local.get $0
   local.get $0
   f64.mul
   f64.mul
   local.get $0
   f64.const 1.58969099521155e-10
   f64.mul
   f64.const -2.5050760253406863e-08
   f64.add
   f64.mul
   f64.add
   f64.mul
   f64.sub
   f64.mul
   local.get $7
   f64.sub
   local.get $1
   f64.const -0.16666666666666632
   f64.mul
   f64.sub
   f64.sub
  end
  local.tee $0
  f64.neg
  local.get $0
  local.get $3
  i32.const 2
  i32.and
  select
 )
 (func $~lib/math/NativeMath.cos (param $0 f64) (result f64)
  (local $1 f64)
  (local $2 f64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 f64)
  (local $8 f64)
  (local $9 f64)
  local.get $0
  i64.reinterpret_f64
  local.tee $5
  i64.const 32
  i64.shr_u
  i32.wrap_i64
  local.tee $3
  i32.const 31
  i32.shr_u
  local.set $6
  local.get $3
  i32.const 2147483647
  i32.and
  local.tee $3
  i32.const 1072243195
  i32.le_u
  if
   local.get $3
   i32.const 1044816030
   i32.lt_u
   if
    f64.const 1
    return
   end
   local.get $0
   local.get $0
   f64.mul
   local.tee $1
   local.get $1
   f64.mul
   local.set $2
   f64.const 1
   local.get $1
   f64.const 0.5
   f64.mul
   local.tee $7
   f64.sub
   local.tee $8
   f64.const 1
   local.get $8
   f64.sub
   local.get $7
   f64.sub
   local.get $1
   local.get $1
   local.get $1
   local.get $1
   f64.const 2.480158728947673e-05
   f64.mul
   f64.const -0.001388888888887411
   f64.add
   f64.mul
   f64.const 0.0416666666666666
   f64.add
   f64.mul
   local.get $2
   local.get $2
   f64.mul
   local.get $1
   local.get $1
   f64.const -1.1359647557788195e-11
   f64.mul
   f64.const 2.087572321298175e-09
   f64.add
   f64.mul
   f64.const -2.7557314351390663e-07
   f64.add
   f64.mul
   f64.add
   f64.mul
   local.get $0
   f64.const 0
   f64.mul
   f64.sub
   f64.add
   f64.add
   return
  end
  local.get $3
  i32.const 2146435072
  i32.ge_u
  if
   local.get $0
   local.get $0
   f64.sub
   return
  end
  block $~lib/math/rempio2|inlined.1 (result i32)
   local.get $5
   i64.const 32
   i64.shr_u
   i32.wrap_i64
   i32.const 2147483647
   i32.and
   local.tee $4
   i32.const 1073928572
   i32.lt_u
   if
    i32.const 1
    local.set $3
    local.get $6
    if (result f64)
     local.get $0
     f64.const 1.5707963267341256
     f64.add
     local.set $0
     i32.const -1
     local.set $3
     local.get $4
     i32.const 1073291771
     i32.ne
     if (result f64)
      local.get $0
      local.get $0
      f64.const 6.077100506506192e-11
      f64.add
      local.tee $0
      f64.sub
      f64.const 6.077100506506192e-11
      f64.add
     else
      local.get $0
      f64.const 6.077100506303966e-11
      f64.add
      local.tee $1
      f64.const 2.0222662487959506e-21
      f64.add
      local.set $0
      local.get $1
      local.get $0
      f64.sub
      f64.const 2.0222662487959506e-21
      f64.add
     end
    else
     local.get $0
     f64.const -1.5707963267341256
     f64.add
     local.set $0
     local.get $4
     i32.const 1073291771
     i32.ne
     if (result f64)
      local.get $0
      local.get $0
      f64.const -6.077100506506192e-11
      f64.add
      local.tee $0
      f64.sub
      f64.const -6.077100506506192e-11
      f64.add
     else
      local.get $0
      f64.const -6.077100506303966e-11
      f64.add
      local.tee $1
      f64.const -2.0222662487959506e-21
      f64.add
      local.set $0
      local.get $1
      local.get $0
      f64.sub
      f64.const -2.0222662487959506e-21
      f64.add
     end
    end
    local.get $0
    global.set $~lib/math/rempio2_y0
    global.set $~lib/math/rempio2_y1
    local.get $3
    br $~lib/math/rempio2|inlined.1
   end
   local.get $4
   i32.const 1094263291
   i32.lt_u
   if
    local.get $4
    i32.const 20
    i32.shr_u
    local.tee $3
    local.get $0
    local.get $0
    f64.const 0.6366197723675814
    f64.mul
    f64.nearest
    local.tee $7
    f64.const 1.5707963267341256
    f64.mul
    f64.sub
    local.tee $0
    local.get $7
    f64.const 6.077100506506192e-11
    f64.mul
    local.tee $2
    f64.sub
    local.tee $1
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 20
    i32.shr_u
    i32.const 2047
    i32.and
    i32.sub
    i32.const 16
    i32.gt_u
    if
     local.get $7
     f64.const 2.0222662487959506e-21
     f64.mul
     local.get $0
     local.get $0
     local.get $7
     f64.const 6.077100506303966e-11
     f64.mul
     local.tee $1
     f64.sub
     local.tee $0
     f64.sub
     local.get $1
     f64.sub
     f64.sub
     local.set $2
     local.get $3
     local.get $0
     local.get $2
     f64.sub
     local.tee $1
     i64.reinterpret_f64
     i64.const 32
     i64.shr_u
     i32.wrap_i64
     i32.const 20
     i32.shr_u
     i32.const 2047
     i32.and
     i32.sub
     i32.const 49
     i32.gt_u
     if
      local.get $7
      f64.const 8.4784276603689e-32
      f64.mul
      local.get $0
      local.get $0
      local.get $7
      f64.const 2.0222662487111665e-21
      f64.mul
      local.tee $1
      f64.sub
      local.tee $0
      f64.sub
      local.get $1
      f64.sub
      f64.sub
      local.set $2
      local.get $0
      local.get $2
      f64.sub
      local.set $1
     end
    end
    local.get $1
    global.set $~lib/math/rempio2_y0
    local.get $0
    local.get $1
    f64.sub
    local.get $2
    f64.sub
    global.set $~lib/math/rempio2_y1
    local.get $7
    i32.trunc_sat_f64_s
    br $~lib/math/rempio2|inlined.1
   end
   i32.const 0
   local.get $5
   call $~lib/math/pio2_large_quot
   local.tee $3
   i32.sub
   local.get $3
   local.get $6
   select
  end
  local.set $3
  global.get $~lib/math/rempio2_y0
  local.set $1
  global.get $~lib/math/rempio2_y1
  local.set $2
  local.get $3
  i32.const 1
  i32.and
  if (result f64)
   local.get $1
   local.get $1
   f64.mul
   local.tee $0
   local.get $1
   f64.mul
   local.set $7
   local.get $1
   local.get $0
   local.get $2
   f64.const 0.5
   f64.mul
   local.get $7
   local.get $0
   local.get $0
   f64.const 2.7557313707070068e-06
   f64.mul
   f64.const -1.984126982985795e-04
   f64.add
   f64.mul
   f64.const 0.00833333333332249
   f64.add
   local.get $0
   local.get $0
   local.get $0
   f64.mul
   f64.mul
   local.get $0
   f64.const 1.58969099521155e-10
   f64.mul
   f64.const -2.5050760253406863e-08
   f64.add
   f64.mul
   f64.add
   f64.mul
   f64.sub
   f64.mul
   local.get $2
   f64.sub
   local.get $7
   f64.const -0.16666666666666632
   f64.mul
   f64.sub
   f64.sub
  else
   local.get $1
   local.get $1
   f64.mul
   local.tee $7
   local.get $7
   f64.mul
   local.set $8
   f64.const 1
   local.get $7
   f64.const 0.5
   f64.mul
   local.tee $0
   f64.sub
   local.tee $9
   f64.const 1
   local.get $9
   f64.sub
   local.get $0
   f64.sub
   local.get $7
   local.get $7
   local.get $7
   local.get $7
   f64.const 2.480158728947673e-05
   f64.mul
   f64.const -0.001388888888887411
   f64.add
   f64.mul
   f64.const 0.0416666666666666
   f64.add
   f64.mul
   local.get $8
   local.get $8
   f64.mul
   local.get $7
   local.get $7
   f64.const -1.1359647557788195e-11
   f64.mul
   f64.const 2.087572321298175e-09
   f64.add
   f64.mul
   f64.const -2.7557314351390663e-07
   f64.add
   f64.mul
   f64.add
   f64.mul
   local.get $1
   local.get $2
   f64.mul
   f64.sub
   f64.add
   f64.add
  end
  local.tee $0
  f64.neg
  local.get $0
  local.get $3
  i32.const 1
  i32.add
  i32.const 2
  i32.and
  select
 )
 (func $assembly_index/isOpcode (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 255
  i32.and
  local.tee $1
  i32.const 62
  i32.eq
  local.get $1
  i32.const 60
  i32.eq
  i32.or
  local.get $1
  i32.const 123
  i32.eq
  i32.or
  local.get $1
  i32.const 125
  i32.eq
  i32.or
  local.get $1
  i32.const 45
  i32.eq
  i32.or
  local.get $1
  i32.const 43
  i32.eq
  i32.or
  local.get $1
  i32.const 46
  i32.eq
  i32.or
  local.get $1
  i32.const 44
  i32.eq
  i32.or
  local.get $1
  i32.const 91
  i32.eq
  i32.or
  local.get $1
  i32.const 93
  i32.eq
  i32.or
  if
   i32.const 1
   return
  end
  global.get $assembly_index/langVersion
  i32.const 2
  i32.ge_s
  if (result i32)
   local.get $0
   i32.const 255
   i32.and
   local.tee $1
   i32.const 118
   i32.eq
   local.get $1
   i32.const 94
   i32.eq
   i32.or
   local.get $1
   i32.const 40
   i32.eq
   i32.or
   local.get $1
   i32.const 41
   i32.eq
   i32.or
  else
   i32.const 0
  end
  if
   i32.const 1
   return
  end
  global.get $assembly_index/langVersion
  i32.const 3
  i32.ge_s
  if (result i32)
   local.get $0
   i32.const 255
   i32.and
   local.tee $0
   i32.const 64
   i32.eq
   local.get $0
   i32.const 48
   i32.eq
   i32.or
   local.get $0
   i32.const 33
   i32.eq
   i32.or
   local.get $0
   i32.const 63
   i32.eq
   i32.or
  else
   i32.const 0
  end
  if
   i32.const 1
   return
  end
  i32.const 0
 )
 (func $assembly_index/generateSubstrate (param $0 i64)
  (local $1 f64)
  (local $2 i32)
  (local $3 i32)
  (local $4 f64)
  (local $5 f64)
  (local $6 f64)
  (local $7 f64)
  (local $8 f64)
  (local $9 f64)
  (local $10 f64)
  (local $11 f64)
  (local $12 f64)
  (local $13 f64)
  (local $14 f64)
  (local $15 f64)
  local.get $0
  i64.const -3335678366873096957
  i64.xor
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 3
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1
  f64.add
  local.set $4
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 3
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1
  f64.add
  local.set $5
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 6283
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1e3
  f64.div
  local.set $6
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 6283
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1e3
  f64.div
  local.set $7
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 3
  i64.and
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 2
  f64.add
  local.set $8
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 3
  i64.and
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 2
  f64.add
  local.set $9
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  local.tee $0
  i64.const 6283
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1e3
  f64.div
  local.set $10
  local.get $0
  i64.const 7046029254386353131
  i64.sub
  local.tee $0
  i64.const 30
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $0
  i64.const 27
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $0
  i64.const 31
  i64.shr_u
  local.get $0
  i64.xor
  i64.const 6283
  i64.rem_u
  i32.wrap_i64
  f64.convert_i32_s
  f64.const 1e3
  f64.div
  local.set $11
  global.get $assembly_index/gridWidth
  i32.const 1
  i32.sub
  f64.convert_i32_s
  f64.const 1
  global.get $assembly_index/gridWidth
  i32.const 1
  i32.gt_s
  select
  local.set $12
  global.get $assembly_index/gridHeight
  i32.const 1
  i32.sub
  f64.convert_i32_s
  f64.const 1
  global.get $assembly_index/gridHeight
  i32.const 1
  i32.gt_s
  select
  local.set $13
  loop $for-loop|0
   local.get $3
   global.get $assembly_index/gridWidth
   i32.lt_s
   if
    local.get $3
    f64.convert_i32_s
    local.get $12
    f64.div
    local.set $14
    i32.const 0
    local.set $2
    loop $for-loop|1
     local.get $2
     global.get $assembly_index/gridHeight
     i32.lt_s
     if
      local.get $14
      f64.const 6.283185307179586
      f64.mul
      local.tee $1
      local.get $4
      f64.mul
      local.get $6
      f64.add
      call $~lib/math/NativeMath.sin
      local.get $2
      f64.convert_i32_s
      local.get $13
      f64.div
      f64.const 6.283185307179586
      f64.mul
      local.tee $15
      local.get $5
      f64.mul
      local.get $7
      f64.add
      call $~lib/math/NativeMath.cos
      f64.mul
      local.get $1
      local.get $8
      f64.mul
      local.get $10
      f64.add
      call $~lib/math/NativeMath.sin
      f64.const 0.5
      f64.mul
      local.get $15
      local.get $9
      f64.mul
      local.get $11
      f64.add
      call $~lib/math/NativeMath.cos
      f64.mul
      f64.add
      f64.const 1.5
      f64.div
      f64.const 1
      f64.add
      f64.const 0.5
      f64.mul
      local.tee $1
      f64.const 0
      f64.lt
      if
       f64.const 0
       local.set $1
      end
      global.get $assembly_index/substratePtr
      local.get $3
      global.get $assembly_index/gridHeight
      i32.mul
      local.get $2
      i32.add
      i32.add
      f64.const 1
      local.get $1
      local.get $1
      f64.const 1
      f64.gt
      select
      f64.const 255
      f64.mul
      i32.trunc_sat_f64_u
      i32.store8
      local.get $2
      i32.const 1
      i32.add
      local.set $2
      br $for-loop|1
     end
    end
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $assembly_index/buildNeighborhood
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  global.get $assembly_index/couplingMode
  if
   loop $for-loop|4
    local.get $3
    global.get $assembly_index/gridWidth
    i32.lt_s
    if
     i32.const 0
     local.set $6
     loop $for-loop|5
      local.get $6
      global.get $assembly_index/gridHeight
      i32.lt_s
      if
       local.get $3
       global.get $assembly_index/gridHeight
       i32.mul
       local.get $6
       i32.add
       local.set $2
       local.get $3
       i32.const 1
       i32.sub
       local.tee $0
       i32.const 0
       i32.ge_s
       if (result i32)
        global.get $assembly_index/neighborsPtr
        local.get $2
        i32.const 96
        i32.mul
        i32.add
        local.get $0
        global.get $assembly_index/gridHeight
        i32.mul
        local.get $6
        i32.add
        i32.store
        i32.const 1
       else
        i32.const 0
       end
       local.set $0
       local.get $3
       i32.const 1
       i32.add
       local.tee $1
       global.get $assembly_index/gridWidth
       i32.lt_s
       if
        global.get $assembly_index/neighborsPtr
        local.get $2
        i32.const 24
        i32.mul
        local.get $0
        i32.add
        i32.const 2
        i32.shl
        i32.add
        local.get $1
        global.get $assembly_index/gridHeight
        i32.mul
        local.get $6
        i32.add
        i32.store
        local.get $0
        i32.const 1
        i32.add
        local.set $0
       end
       local.get $6
       i32.const 1
       i32.sub
       local.tee $1
       i32.const 0
       i32.ge_s
       if
        global.get $assembly_index/neighborsPtr
        local.get $2
        i32.const 24
        i32.mul
        local.get $0
        i32.add
        i32.const 2
        i32.shl
        i32.add
        local.get $3
        global.get $assembly_index/gridHeight
        i32.mul
        local.get $1
        i32.add
        i32.store
        local.get $0
        i32.const 1
        i32.add
        local.set $0
       end
       global.get $assembly_index/nCountsPtr
       local.get $2
       i32.const 2
       i32.shl
       i32.add
       local.get $6
       i32.const 1
       i32.add
       local.tee $1
       global.get $assembly_index/gridHeight
       i32.lt_s
       if (result i32)
        global.get $assembly_index/neighborsPtr
        local.get $2
        i32.const 24
        i32.mul
        local.get $0
        i32.add
        i32.const 2
        i32.shl
        i32.add
        local.get $3
        global.get $assembly_index/gridHeight
        i32.mul
        local.get $1
        i32.add
        i32.store
        local.get $0
        i32.const 1
        i32.add
       else
        local.get $0
       end
       i32.store
       local.get $6
       i32.const 1
       i32.add
       local.set $6
       br $for-loop|5
      end
     end
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|4
    end
   end
  else
   loop $for-loop|0
    local.get $9
    global.get $assembly_index/gridWidth
    i32.lt_s
    if
     local.get $9
     i32.const 2
     i32.sub
     local.tee $2
     i32.const 0
     i32.lt_s
     if
      i32.const 0
      local.set $2
     end
     local.get $9
     i32.const 3
     i32.add
     local.tee $4
     global.get $assembly_index/gridWidth
     i32.gt_s
     if
      global.get $assembly_index/gridWidth
      local.set $4
     end
     i32.const 0
     local.set $8
     loop $for-loop|1
      local.get $8
      global.get $assembly_index/gridHeight
      i32.lt_s
      if
       local.get $8
       i32.const 2
       i32.sub
       local.tee $1
       i32.const 0
       i32.lt_s
       if
        i32.const 0
        local.set $1
       end
       local.get $8
       i32.const 3
       i32.add
       local.tee $3
       global.get $assembly_index/gridHeight
       i32.gt_s
       if
        global.get $assembly_index/gridHeight
        local.set $3
       end
       local.get $9
       global.get $assembly_index/gridHeight
       i32.mul
       local.get $8
       i32.add
       local.set $10
       i32.const 0
       local.set $0
       local.get $2
       local.set $5
       loop $for-loop|2
        local.get $4
        local.get $5
        i32.gt_s
        if
         local.get $5
         global.get $assembly_index/gridHeight
         i32.mul
         local.set $7
         local.get $1
         local.set $6
         loop $for-loop|3
          local.get $3
          local.get $6
          i32.gt_s
          if
           local.get $6
           local.get $8
           i32.eq
           local.get $5
           local.get $9
           i32.eq
           i32.and
           i32.eqz
           if
            global.get $assembly_index/neighborsPtr
            local.get $10
            i32.const 24
            i32.mul
            local.get $0
            i32.add
            i32.const 2
            i32.shl
            i32.add
            local.get $6
            local.get $7
            i32.add
            i32.store
            local.get $0
            i32.const 1
            i32.add
            local.set $0
           end
           local.get $6
           i32.const 1
           i32.add
           local.set $6
           br $for-loop|3
          end
         end
         local.get $5
         i32.const 1
         i32.add
         local.set $5
         br $for-loop|2
        end
       end
       global.get $assembly_index/nCountsPtr
       local.get $10
       i32.const 2
       i32.shl
       i32.add
       local.get $0
       i32.store
       local.get $8
       i32.const 1
       i32.add
       local.set $8
       br $for-loop|1
      end
     end
     local.get $9
     i32.const 1
     i32.add
     local.set $9
     br $for-loop|0
    end
   end
  end
 )
 (func $assembly_index/totalCells (result i32)
  global.get $assembly_index/numPrograms
  global.get $assembly_index/tapeSize
  i32.mul
 )
 (func $assembly_index/step (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i64)
  loop $for-loop|0
   local.get $2
   global.get $assembly_index/numPrograms
   i32.lt_s
   if
    global.get $assembly_index/orderPtr
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    local.get $2
    i32.store
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
  global.get $assembly_index/numPrograms
  i32.const 1
  i32.sub
  local.set $2
  loop $for-loop|1
   local.get $2
   i32.const 0
   i32.gt_s
   if
    global.get $assembly_index/orderPtr
    local.get $2
    i32.const 1
    i32.add
    call $assembly_index/rngBounded
    i32.const 2
    i32.shl
    i32.add
    local.set $11
    global.get $assembly_index/orderPtr
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    local.tee $10
    i32.load
    local.set $12
    local.get $10
    local.get $11
    i32.load
    i32.store
    local.get $11
    local.get $12
    i32.store
    local.get $2
    i32.const 1
    i32.sub
    local.set $2
    br $for-loop|1
   end
  end
  block $__inlined_func$assembly_index/generateProposals$12
   global.get $assembly_index/couplingMode
   i32.const 2
   i32.eq
   if
    global.get $assembly_index/sweepCounter
    i32.const 1
    i32.and
    local.set $10
    loop $for-loop|00
     local.get $4
     global.get $assembly_index/numPrograms
     i32.lt_s
     if
      local.get $4
      global.get $assembly_index/gridHeight
      i32.div_s
      local.set $2
      local.get $4
      global.get $assembly_index/gridHeight
      i32.rem_s
      local.set $3
      i32.const 1
      i32.const -1
      i32.const 2
      call $assembly_index/rngBounded
      select
      local.set $11
      local.get $10
      if
       local.get $3
       local.get $11
       i32.add
       local.set $3
      else
       local.get $2
       local.get $11
       i32.add
       local.set $2
      end
      local.get $2
      i32.const 0
      i32.lt_s
      local.get $2
      global.get $assembly_index/gridWidth
      i32.ge_s
      i32.or
      local.get $3
      i32.const 0
      i32.lt_s
      i32.or
      local.get $3
      global.get $assembly_index/gridHeight
      i32.ge_s
      i32.or
      if
       global.get $assembly_index/proposalsPtr
       local.get $4
       i32.const 2
       i32.shl
       i32.add
       i32.const -1
       i32.store
      else
       global.get $assembly_index/proposalsPtr
       local.get $4
       i32.const 2
       i32.shl
       i32.add
       local.get $2
       global.get $assembly_index/gridHeight
       i32.mul
       local.get $3
       i32.add
       i32.store
      end
      local.get $4
      i32.const 1
      i32.add
      local.set $4
      br $for-loop|00
     end
    end
    br $__inlined_func$assembly_index/generateProposals$12
   end
   loop $for-loop|11
    local.get $3
    global.get $assembly_index/numPrograms
    i32.lt_s
    if
     local.get $3
     i32.const 2
     i32.shl
     local.tee $2
     global.get $assembly_index/nCountsPtr
     i32.add
     i32.load
     local.tee $4
     i32.const 0
     i32.gt_s
     if
      global.get $assembly_index/proposalsPtr
      local.get $2
      i32.add
      global.get $assembly_index/neighborsPtr
      local.get $4
      call $assembly_index/rngBounded
      local.get $3
      i32.const 24
      i32.mul
      i32.add
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.store
     else
      global.get $assembly_index/proposalsPtr
      local.get $3
      i32.const 2
      i32.shl
      i32.add
      i32.const -1
      i32.store
     end
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|11
    end
   end
  end
  global.get $assembly_index/takenPtr
  i32.const 0
  global.get $assembly_index/numPrograms
  memory.fill
  loop $for-loop|02
   local.get $7
   global.get $assembly_index/numPrograms
   i32.lt_s
   if
    block $for-continue|0
     global.get $assembly_index/proposalsPtr
     global.get $assembly_index/orderPtr
     local.get $7
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $3
     i32.const 0
     i32.lt_s
     br_if $for-continue|0
     global.get $assembly_index/takenPtr
     local.get $2
     i32.add
     local.tee $4
     i32.load8_u
     br_if $for-continue|0
     global.get $assembly_index/takenPtr
     local.get $3
     i32.add
     local.tee $10
     i32.load8_u
     br_if $for-continue|0
     local.get $4
     i32.const 1
     i32.store8
     local.get $10
     i32.const 1
     i32.store8
     local.get $8
     i32.const 3
     i32.shl
     local.tee $4
     global.get $assembly_index/pairsPtr
     i32.add
     local.get $2
     i32.store
     global.get $assembly_index/pairsPtr
     local.get $4
     i32.const 4
     i32.add
     i32.add
     local.get $3
     i32.store
     local.get $8
     i32.const 1
     i32.add
     local.set $8
    end
    local.get $7
    i32.const 1
    i32.add
    local.set $7
    br $for-loop|02
   end
  end
  global.get $assembly_index/tapeSize
  i32.const 1
  i32.shl
  local.set $2
  loop $for-loop|03
   local.get $8
   local.get $9
   i32.gt_s
   if
    global.get $assembly_index/programsPtr
    global.get $assembly_index/tapeSize
    local.get $9
    i32.const 3
    i32.shl
    local.tee $3
    global.get $assembly_index/pairsPtr
    i32.add
    i32.load
    i32.mul
    i32.add
    local.set $4
    global.get $assembly_index/programsPtr
    global.get $assembly_index/tapeSize
    global.get $assembly_index/pairsPtr
    local.get $3
    i32.const 4
    i32.add
    i32.add
    i32.load
    i32.mul
    i32.add
    local.set $3
    global.get $assembly_index/tapePtr
    local.get $4
    global.get $assembly_index/tapeSize
    memory.copy
    global.get $assembly_index/tapePtr
    global.get $assembly_index/tapeSize
    i32.add
    local.tee $7
    local.get $3
    global.get $assembly_index/tapeSize
    memory.copy
    global.get $assembly_index/tapePtr
    local.get $2
    call $assembly_index/runTape
    local.get $4
    global.get $assembly_index/tapePtr
    global.get $assembly_index/tapeSize
    memory.copy
    local.get $3
    local.get $7
    global.get $assembly_index/tapeSize
    memory.copy
    local.get $9
    i32.const 1
    i32.add
    local.set $9
    br $for-loop|03
   end
  end
  block $__inlined_func$assembly_index/applyMutation$15
   local.get $0
   i32.const 0
   i32.le_s
   br_if $__inlined_func$assembly_index/applyMutation$15
   global.get $assembly_index/substrateOn
   i32.eqz
   if
    global.get $assembly_index/numPrograms
    global.get $assembly_index/tapeSize
    i32.mul
    local.set $2
    loop $for-loop|04
     local.get $2
     local.get $6
     i32.gt_s
     if
      local.get $1
      call $assembly_index/rngBounded
      local.get $0
      i32.lt_s
      if
       global.get $assembly_index/rngS0
       local.set $5
       global.get $assembly_index/rngS1
       local.tee $13
       global.set $assembly_index/rngS0
       local.get $5
       local.get $5
       i64.const 23
       i64.shl
       i64.xor
       local.tee $5
       i64.const 17
       i64.shr_u
       local.get $5
       i64.xor
       local.get $13
       i64.xor
       local.get $13
       i64.const 26
       i64.shr_u
       i64.xor
       global.set $assembly_index/rngS1
       global.get $assembly_index/programsPtr
       local.get $6
       i32.add
       global.get $assembly_index/rngS0
       global.get $assembly_index/rngS1
       i64.add
       i64.const 32
       i64.shr_u
       i64.store8
      end
      local.get $6
      i32.const 1
      i32.add
      local.set $6
      br $for-loop|04
     end
    end
    br $__inlined_func$assembly_index/applyMutation$15
   end
   global.get $assembly_index/substrateStrength
   local.set $3
   loop $for-loop|15
    local.get $6
    global.get $assembly_index/numPrograms
    i32.lt_s
    if
     local.get $0
     i32.const 100
     local.get $3
     i32.sub
     global.get $assembly_index/substratePtr
     local.get $6
     i32.add
     i32.load8_u
     i32.const 200
     i32.mul
     i32.const 255
     i32.div_u
     local.get $3
     i32.mul
     i32.const 100
     i32.div_s
     i32.add
     i32.mul
     i32.const 100
     i32.div_s
     local.tee $4
     i32.const 0
     i32.gt_s
     if
      global.get $assembly_index/programsPtr
      local.get $6
      global.get $assembly_index/tapeSize
      i32.mul
      i32.add
      local.set $7
      i32.const 0
      local.set $2
      loop $for-loop|2
       local.get $2
       global.get $assembly_index/tapeSize
       i32.lt_s
       if
        local.get $1
        call $assembly_index/rngBounded
        local.get $4
        i32.lt_s
        if
         global.get $assembly_index/rngS0
         local.set $5
         global.get $assembly_index/rngS1
         local.tee $13
         global.set $assembly_index/rngS0
         local.get $5
         local.get $5
         i64.const 23
         i64.shl
         i64.xor
         local.tee $5
         i64.const 17
         i64.shr_u
         local.get $5
         i64.xor
         local.get $13
         i64.xor
         local.get $13
         i64.const 26
         i64.shr_u
         i64.xor
         global.set $assembly_index/rngS1
         local.get $2
         local.get $7
         i32.add
         global.get $assembly_index/rngS0
         global.get $assembly_index/rngS1
         i64.add
         i64.const 32
         i64.shr_u
         i64.store8
        end
        local.get $2
        i32.const 1
        i32.add
        local.set $2
        br $for-loop|2
       end
      end
     end
     local.get $6
     i32.const 1
     i32.add
     local.set $6
     br $for-loop|15
    end
   end
  end
  global.get $assembly_index/sweepCounter
  i32.const 1
  i32.add
  global.set $assembly_index/sweepCounter
 )
 (func $assembly_index/setSubstrate (param $0 i32) (param $1 i32)
  local.get $0
  i32.const 0
  i32.ne
  global.set $assembly_index/substrateOn
  local.get $1
  i32.const 0
  local.get $1
  i32.const 0
  i32.ge_s
  select
  local.tee $0
  i32.const 100
  i32.gt_s
  if (result i32)
   i32.const 100
  else
   local.get $0
  end
  global.set $assembly_index/substrateStrength
 )
 (func $assembly_index/setLangVersion (param $0 i32)
  i32.const 1
  local.get $0
  local.get $0
  i32.const 0
  i32.le_s
  select
  local.tee $0
  i32.const 3
  i32.gt_s
  if (result i32)
   i32.const 3
  else
   local.get $0
  end
  global.set $assembly_index/langVersion
 )
 (func $assembly_index/setCoupling (param $0 i32)
  local.get $0
  i32.const 0
  local.get $0
  i32.const 0
  i32.ge_s
  select
  local.tee $0
  i32.const 2
  i32.gt_s
  if (result i32)
   i32.const 2
  else
   local.get $0
  end
  global.set $assembly_index/couplingMode
  call $assembly_index/buildNeighborhood
 )
 (func $assembly_index/runTape (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i64)
  global.get $assembly_index/langVersion
  local.set $7
  loop $for-loop|0
   local.get $6
   i32.const 8192
   i32.lt_s
   local.get $1
   local.get $8
   i32.gt_u
   i32.and
   if
    local.get $0
    local.get $8
    i32.add
    i32.load8_u
    local.tee $4
    i32.const 60
    i32.eq
    if
     local.get $3
     i32.const 1
     i32.sub
     local.tee $3
     i32.const 0
     i32.lt_s
     if
      local.get $1
      local.get $3
      i32.add
      local.set $3
     end
    else
     local.get $4
     i32.const 62
     i32.eq
     if
      local.get $3
      i32.const 1
      i32.add
      local.tee $3
      local.get $1
      i32.ge_s
      if
       local.get $3
       local.get $1
       i32.sub
       local.set $3
      end
     else
      local.get $4
      i32.const 123
      i32.eq
      if
       local.get $2
       i32.const 1
       i32.sub
       local.tee $2
       i32.const 0
       i32.lt_s
       if
        local.get $1
        local.get $2
        i32.add
        local.set $2
       end
      else
       local.get $4
       i32.const 125
       i32.eq
       if
        local.get $2
        i32.const 1
        i32.add
        local.tee $2
        local.get $1
        i32.ge_s
        if
         local.get $2
         local.get $1
         i32.sub
         local.set $2
        end
       else
        local.get $4
        i32.const 45
        i32.eq
        if
         local.get $0
         local.get $3
         i32.add
         local.tee $4
         local.get $4
         i32.load8_u
         i32.const 1
         i32.sub
         i32.store8
        else
         local.get $4
         i32.const 43
         i32.eq
         if
          local.get $0
          local.get $3
          i32.add
          local.tee $4
          local.get $4
          i32.load8_u
          i32.const 1
          i32.add
          i32.store8
         else
          local.get $4
          i32.const 46
          i32.eq
          if
           local.get $0
           local.get $2
           i32.add
           local.get $0
           local.get $3
           i32.add
           i32.load8_u
           i32.store8
          else
           local.get $4
           i32.const 44
           i32.eq
           if
            local.get $0
            local.get $3
            i32.add
            local.get $0
            local.get $2
            i32.add
            i32.load8_u
            i32.store8
           else
            local.get $4
            i32.const 91
            i32.eq
            if
             local.get $0
             local.get $3
             i32.add
             i32.load8_u
             i32.eqz
             if
              i32.const 1
              local.set $4
              local.get $8
              i32.const 1
              i32.add
              local.set $8
              loop $while-continue|1
               local.get $4
               i32.const 0
               i32.gt_s
               local.get $1
               local.get $8
               i32.gt_s
               i32.and
               if
                local.get $8
                i32.const 1
                i32.add
                local.get $8
                local.get $0
                local.get $8
                i32.add
                i32.load8_u
                local.tee $8
                i32.const 91
                i32.eq
                if (result i32)
                 local.get $4
                 i32.const 1
                 i32.add
                else
                 local.get $4
                 i32.const 1
                 i32.sub
                 local.get $4
                 local.get $8
                 i32.const 93
                 i32.eq
                 select
                end
                local.tee $4
                i32.const 0
                i32.gt_s
                select
                local.set $8
                br $while-continue|1
               end
              end
              local.get $4
              if
               return
              end
             end
            else
             local.get $4
             i32.const 93
             i32.eq
             if
              local.get $0
              local.get $3
              i32.add
              i32.load8_u
              if
               i32.const 1
               local.set $4
               local.get $8
               i32.const 1
               i32.sub
               local.set $8
               loop $while-continue|2
                local.get $4
                i32.const 0
                i32.gt_s
                local.get $8
                i32.const 0
                i32.ge_s
                i32.and
                if
                 local.get $8
                 i32.const 1
                 i32.sub
                 local.get $8
                 local.get $0
                 local.get $8
                 i32.add
                 i32.load8_u
                 local.tee $8
                 i32.const 93
                 i32.eq
                 if (result i32)
                  local.get $4
                  i32.const 1
                  i32.add
                 else
                  local.get $4
                  i32.const 1
                  i32.sub
                  local.get $4
                  local.get $8
                  i32.const 91
                  i32.eq
                  select
                 end
                 local.tee $4
                 i32.const 0
                 i32.gt_s
                 select
                 local.set $8
                 br $while-continue|2
                end
               end
               local.get $4
               if
                return
               end
              end
             else
              local.get $7
              i32.const 2
              i32.ge_s
              if
               local.get $4
               i32.const 94
               i32.eq
               if
                local.get $3
                i32.const 8
                i32.sub
                local.tee $3
                i32.const 0
                i32.lt_s
                if
                 local.get $1
                 local.get $3
                 i32.add
                 local.set $3
                end
               else
                local.get $4
                i32.const 118
                i32.eq
                if
                 local.get $3
                 i32.const 8
                 i32.add
                 local.tee $3
                 local.get $1
                 i32.ge_s
                 if
                  local.get $3
                  local.get $1
                  i32.sub
                  local.set $3
                 end
                else
                 local.get $4
                 i32.const 40
                 i32.eq
                 if
                  local.get $2
                  i32.const 8
                  i32.sub
                  local.tee $2
                  i32.const 0
                  i32.lt_s
                  if
                   local.get $1
                   local.get $2
                   i32.add
                   local.set $2
                  end
                 else
                  local.get $4
                  i32.const 41
                  i32.eq
                  if
                   local.get $2
                   i32.const 8
                   i32.add
                   local.tee $2
                   local.get $1
                   i32.ge_s
                   if
                    local.get $2
                    local.get $1
                    i32.sub
                    local.set $2
                   end
                  else
                   local.get $7
                   i32.const 3
                   i32.ge_s
                   if
                    local.get $4
                    i32.const 48
                    i32.eq
                    if
                     local.get $0
                     local.get $3
                     i32.add
                     i32.const 0
                     i32.store8
                    else
                     local.get $4
                     i32.const 64
                     i32.eq
                     if
                      local.get $3
                      local.get $2
                      local.set $3
                      local.set $2
                     else
                      local.get $4
                      i32.const 33
                      i32.eq
                      if
                       local.get $0
                       local.get $3
                       i32.add
                       local.tee $4
                       i32.load8_u
                       local.set $9
                       local.get $4
                       local.get $0
                       local.get $2
                       i32.add
                       local.tee $4
                       i32.load8_u
                       i32.store8
                       local.get $4
                       local.get $9
                       i32.store8
                      else
                       local.get $4
                       i32.const 63
                       i32.eq
                       if
                        global.get $assembly_index/rngS0
                        local.set $10
                        global.get $assembly_index/rngS1
                        local.tee $5
                        global.set $assembly_index/rngS0
                        local.get $5
                        local.get $10
                        local.get $10
                        i64.const 23
                        i64.shl
                        i64.xor
                        local.tee $10
                        local.get $10
                        i64.const 17
                        i64.shr_u
                        i64.xor
                        i64.xor
                        local.get $5
                        i64.const 26
                        i64.shr_u
                        i64.xor
                        global.set $assembly_index/rngS1
                        local.get $0
                        local.get $3
                        i32.add
                        global.get $assembly_index/rngS0
                        global.get $assembly_index/rngS1
                        i64.add
                        i64.const 32
                        i64.shr_u
                        i64.store8
                       end
                      end
                     end
                    end
                   end
                  end
                 end
                end
               end
              end
             end
            end
           end
          end
         end
        end
       end
      end
     end
    end
    local.get $8
    i32.const 1
    i32.add
    local.set $8
    local.get $6
    i32.const 1
    i32.add
    local.set $6
    br $for-loop|0
   end
  end
 )
 (func $assembly_index/renderPixels
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  global.get $assembly_index/gridWidth
  i32.const 3
  i32.shl
  local.set $4
  loop $for-loop|0
   local.get $3
   global.get $assembly_index/gridWidth
   i32.lt_s
   if
    i32.const 0
    local.set $0
    loop $for-loop|1
     local.get $0
     global.get $assembly_index/gridHeight
     i32.lt_s
     if
      global.get $assembly_index/programsPtr
      global.get $assembly_index/tapeSize
      local.get $3
      global.get $assembly_index/gridHeight
      i32.mul
      local.get $0
      i32.add
      i32.mul
      i32.add
      local.set $5
      i32.const 0
      local.set $1
      loop $for-loop|2
       local.get $1
       i32.const 8
       i32.lt_s
       if
        i32.const 0
        local.set $2
        loop $for-loop|3
         local.get $2
         i32.const 8
         i32.lt_s
         if
          global.get $assembly_index/pixelsPtr
          local.get $3
          i32.const 3
          i32.shl
          local.get $2
          i32.add
          local.get $0
          i32.const 3
          i32.shl
          local.get $1
          i32.add
          local.get $4
          i32.mul
          i32.add
          i32.const 2
          i32.shl
          i32.add
          global.get $assembly_index/colorLutPtr
          local.get $5
          local.get $1
          i32.const 3
          i32.shl
          local.get $2
          i32.add
          i32.add
          i32.load8_u
          local.tee $6
          i32.const 255
          local.get $6
          call $assembly_index/isOpcode
          select
          i32.const 255
          i32.and
          i32.const 2
          i32.shl
          i32.add
          i32.load
          i32.store
          local.get $2
          i32.const 1
          i32.add
          local.set $2
          br $for-loop|3
         end
        end
        local.get $1
        i32.const 1
        i32.add
        local.set $1
        br $for-loop|2
       end
      end
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|1
     end
    end
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $assembly_index/regenSubstrate (param $0 i64)
  local.get $0
  call $assembly_index/generateSubstrate
 )
 (func $assembly_index/opcodeCount (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  global.get $assembly_index/numPrograms
  global.get $assembly_index/tapeSize
  i32.mul
  local.set $2
  loop $for-loop|0
   local.get $0
   local.get $2
   i32.lt_s
   if
    local.get $1
    i32.const 1
    i32.add
    local.get $1
    global.get $assembly_index/programsPtr
    local.get $0
    i32.add
    i32.load8_u
    call $assembly_index/isOpcode
    select
    local.set $1
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  local.get $1
 )
 (func $assembly_index/init (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i64)
  (local $4 i64)
  (local $5 i64)
  local.get $0
  global.set $assembly_index/gridWidth
  local.get $1
  global.set $assembly_index/gridHeight
  local.get $2
  global.set $assembly_index/tapeSize
  local.get $0
  local.get $1
  i32.mul
  global.set $assembly_index/numPrograms
  local.get $3
  i64.const 7046029254386353131
  i64.sub
  local.tee $4
  local.get $4
  i64.const 30
  i64.shr_u
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $4
  local.get $4
  i64.const 27
  i64.shr_u
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $4
  local.get $4
  i64.const 31
  i64.shr_u
  i64.xor
  global.set $assembly_index/rngS0
  global.get $assembly_index/rngS0
  i64.const 7046029254386353131
  i64.sub
  local.tee $4
  local.get $4
  i64.const 30
  i64.shr_u
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $4
  local.get $4
  i64.const 27
  i64.shr_u
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $4
  local.get $4
  i64.const 31
  i64.shr_u
  i64.xor
  global.set $assembly_index/rngS1
  i32.const 1216
  global.set $assembly_index/programsPtr
  global.get $assembly_index/numPrograms
  global.get $assembly_index/tapeSize
  i32.mul
  i32.const 1216
  i32.add
  local.tee $0
  global.set $assembly_index/neighborsPtr
  local.get $0
  global.get $assembly_index/numPrograms
  i32.const 96
  i32.mul
  i32.add
  local.tee $0
  global.set $assembly_index/nCountsPtr
  local.get $0
  global.get $assembly_index/numPrograms
  i32.const 2
  i32.shl
  local.tee $0
  i32.add
  local.tee $1
  global.set $assembly_index/orderPtr
  local.get $0
  local.get $1
  i32.add
  local.tee $1
  global.set $assembly_index/proposalsPtr
  local.get $0
  local.get $1
  i32.add
  local.tee $0
  global.set $assembly_index/pairsPtr
  local.get $0
  global.get $assembly_index/numPrograms
  i32.const 3
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly_index/takenPtr
  local.get $0
  global.get $assembly_index/numPrograms
  i32.add
  local.tee $0
  global.set $assembly_index/tapePtr
  local.get $0
  global.get $assembly_index/tapeSize
  i32.const 1
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly_index/pixelsPtr
  local.get $0
  global.get $assembly_index/gridHeight
  global.get $assembly_index/gridWidth
  i32.const 3
  i32.shl
  i32.mul
  i32.const 5
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly_index/colorLutPtr
  local.get $0
  i32.const 1024
  i32.add
  local.tee $0
  global.set $assembly_index/histogramPtr
  local.get $0
  i32.const 1024
  i32.add
  local.tee $0
  global.set $assembly_index/substratePtr
  local.get $0
  global.get $assembly_index/numPrograms
  i32.add
  i32.const 65535
  i32.add
  i32.const 16
  i32.shr_u
  local.tee $0
  memory.size
  local.tee $1
  i32.gt_s
  if
   local.get $0
   local.get $1
   i32.sub
   memory.grow
   drop
  end
  i32.const 0
  local.set $0
  loop $for-loop|0
   local.get $0
   global.get $assembly_index/numPrograms
   global.get $assembly_index/tapeSize
   i32.mul
   i32.lt_s
   if
    global.get $assembly_index/rngS0
    local.set $5
    global.get $assembly_index/rngS1
    local.tee $4
    global.set $assembly_index/rngS0
    local.get $4
    local.get $5
    local.get $5
    i64.const 23
    i64.shl
    i64.xor
    local.tee $5
    local.get $5
    i64.const 17
    i64.shr_u
    i64.xor
    i64.xor
    local.get $4
    i64.const 26
    i64.shr_u
    i64.xor
    global.set $assembly_index/rngS1
    global.get $assembly_index/programsPtr
    local.get $0
    i32.add
    global.get $assembly_index/rngS0
    global.get $assembly_index/rngS1
    i64.add
    i64.const 32
    i64.shr_u
    i64.store8
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  call $assembly_index/buildNeighborhood
  local.get $3
  call $assembly_index/generateSubstrate
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   i32.const 256
   i32.lt_s
   if
    global.get $assembly_index/colorLutPtr
    local.get $0
    i32.const 2
    i32.shl
    i32.add
    local.tee $1
    i32.const 20
    i32.store8
    local.get $1
    i32.const 20
    i32.store8 offset=1
    local.get $1
    i32.const 20
    i32.store8 offset=2
    local.get $1
    i32.const 255
    i32.store8 offset=3
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 240
  i32.add
  i32.const 239
  i32.store8
  local.get $0
  i32.const 71
  i32.store8 offset=241
  local.get $0
  i32.const 111
  i32.store8 offset=242
  local.get $0
  i32.const 255
  i32.store8 offset=243
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 248
  i32.add
  i32.const 255
  i32.store8
  local.get $0
  i32.const 209
  i32.store8 offset=249
  local.get $0
  i32.const 102
  i32.store8 offset=250
  local.get $0
  i32.const 255
  i32.store8 offset=251
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 492
  i32.add
  i32.const 6
  i32.store8
  local.get $0
  i32.const 214
  i32.store8 offset=493
  local.get $0
  i32.const 160
  i32.store8 offset=494
  local.get $0
  i32.const 255
  i32.store8 offset=495
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 500
  i32.add
  i32.const 17
  i32.store8
  local.get $0
  i32.const 138
  i32.store8 offset=501
  local.get $0
  i32.const 178
  i32.store8 offset=502
  local.get $0
  i32.const 255
  i32.store8 offset=503
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 180
  i32.add
  i32.const 255
  i32.store8
  local.get $0
  i32.const 127
  i32.store8 offset=181
  local.get $0
  i32.const 80
  i32.store8 offset=182
  local.get $0
  i32.const 255
  i32.store8 offset=183
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 172
  i32.add
  i32.const 131
  i32.store8
  local.get $0
  i32.const 56
  i32.store8 offset=173
  local.get $0
  i32.const 236
  i32.store8 offset=174
  local.get $0
  i32.const 255
  i32.store8 offset=175
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 184
  i32.add
  i32.const 58
  i32.store8
  local.get $0
  i32.const 134
  i32.store8 offset=185
  local.get $0
  i32.const 255
  i32.store8 offset=186
  local.get $0
  i32.const 255
  i32.store8 offset=187
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 176
  i32.add
  i32.const 255
  i32.store8
  local.get $0
  i32.const 190
  i32.store8 offset=177
  local.get $0
  i32.const 11
  i32.store8 offset=178
  local.get $0
  i32.const 255
  i32.store8 offset=179
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 364
  i32.add
  i32.const 139
  i32.store8
  local.get $0
  i32.const 201
  i32.store8 offset=365
  local.get $0
  i32.const 38
  i32.store8 offset=366
  local.get $0
  i32.const 255
  i32.store8 offset=367
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 372
  i32.add
  i32.const 255
  i32.store8
  local.get $0
  i32.const 89
  i32.store8 offset=373
  local.get $0
  i32.const 94
  i32.store8 offset=374
  local.get $0
  i32.const 255
  i32.store8 offset=375
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 376
  i32.add
  i32.const 0
  i32.store8
  local.get $0
  i32.const 245
  i32.store8 offset=377
  local.get $0
  i32.const 212
  i32.store8 offset=378
  local.get $0
  i32.const 255
  i32.store8 offset=379
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 472
  i32.add
  i32.const 241
  i32.store8
  local.get $0
  i32.const 91
  i32.store8 offset=473
  local.get $0
  i32.const 181
  i32.store8 offset=474
  local.get $0
  i32.const 255
  i32.store8 offset=475
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 160
  i32.add
  i32.const 155
  i32.store8
  local.get $0
  i32.const 93
  i32.store8 offset=161
  local.get $0
  i32.const 229
  i32.store8 offset=162
  local.get $0
  i32.const 255
  i32.store8 offset=163
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 164
  i32.add
  i32.const 0
  i32.store8
  local.get $0
  i32.const 187
  i32.store8 offset=165
  local.get $0
  i32.const 249
  i32.store8 offset=166
  local.get $0
  i32.const 255
  i32.store8 offset=167
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 192
  i32.add
  i32.const 235
  i32.store8
  local.get $0
  i32.const 235
  i32.store8 offset=193
  local.get $0
  i32.const 235
  i32.store8 offset=194
  local.get $0
  i32.const 255
  i32.store8 offset=195
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 256
  i32.add
  i32.const 251
  i32.store8
  local.get $0
  i32.const 86
  i32.store8 offset=257
  local.get $0
  i32.const 7
  i32.store8 offset=258
  local.get $0
  i32.const 255
  i32.store8 offset=259
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 132
  i32.add
  i32.const 255
  i32.store8
  local.get $0
  i32.const 0
  i32.store8 offset=133
  local.get $0
  i32.const 110
  i32.store8 offset=134
  local.get $0
  i32.const 255
  i32.store8 offset=135
  global.get $assembly_index/colorLutPtr
  local.tee $0
  i32.const 252
  i32.add
  i32.const 202
  i32.store8
  local.get $0
  i32.const 255
  i32.store8 offset=253
  local.get $0
  i32.const 191
  i32.store8 offset=254
  local.get $0
  i32.const 255
  i32.store8 offset=255
 )
 (func $assembly_index/getSubstratePtr (result i32)
  global.get $assembly_index/substratePtr
 )
 (func $assembly_index/getSubstrateLen (result i32)
  global.get $assembly_index/numPrograms
 )
 (func $assembly_index/getProgramsPtr (result i32)
  global.get $assembly_index/programsPtr
 )
 (func $assembly_index/getPixelsPtr (result i32)
  global.get $assembly_index/pixelsPtr
 )
 (func $assembly_index/getPixelsLen (result i32)
  global.get $assembly_index/gridHeight
  global.get $assembly_index/gridWidth
  i32.const 3
  i32.shl
  i32.mul
  i32.const 5
  i32.shl
 )
 (func $assembly_index/getLangVersion (result i32)
  global.get $assembly_index/langVersion
 )
 (func $assembly_index/getHistogramPtr (result i32)
  global.get $assembly_index/histogramPtr
 )
 (func $assembly_index/getCoupling (result i32)
  global.get $assembly_index/couplingMode
 )
 (func $assembly_index/computeHistogram
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  global.get $assembly_index/histogramPtr
  i32.const 0
  i32.const 1024
  memory.fill
  global.get $assembly_index/numPrograms
  global.get $assembly_index/tapeSize
  i32.mul
  local.set $1
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.lt_s
   if
    global.get $assembly_index/histogramPtr
    global.get $assembly_index/programsPtr
    local.get $0
    i32.add
    i32.load8_u
    i32.const 2
    i32.shl
    i32.add
    local.tee $2
    local.get $2
    i32.load
    i32.const 1
    i32.add
    i32.store
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
 )
)
