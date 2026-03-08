(module
 (type $0 (func (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32 i32 i64)))
 (type $3 (func))
 (type $4 (func (param i32) (result i32)))
 (global $assembly/index/gridWidth (mut i32) (i32.const 0))
 (global $assembly/index/gridHeight (mut i32) (i32.const 0))
 (global $assembly/index/tapeSize (mut i32) (i32.const 0))
 (global $assembly/index/numPrograms (mut i32) (i32.const 0))
 (global $assembly/index/programsPtr (mut i32) (i32.const 0))
 (global $assembly/index/neighborsPtr (mut i32) (i32.const 0))
 (global $assembly/index/nCountsPtr (mut i32) (i32.const 0))
 (global $assembly/index/orderPtr (mut i32) (i32.const 0))
 (global $assembly/index/proposalsPtr (mut i32) (i32.const 0))
 (global $assembly/index/pairsPtr (mut i32) (i32.const 0))
 (global $assembly/index/takenPtr (mut i32) (i32.const 0))
 (global $assembly/index/tapePtr (mut i32) (i32.const 0))
 (global $assembly/index/pixelsPtr (mut i32) (i32.const 0))
 (global $assembly/index/colorLutPtr (mut i32) (i32.const 0))
 (global $assembly/index/rngS0 (mut i64) (i64.const 0))
 (global $assembly/index/rngS1 (mut i64) (i64.const 0))
 (memory $0 0)
 (export "init" (func $assembly/index/init))
 (export "getPixelsPtr" (func $assembly/index/getPixelsPtr))
 (export "getPixelsLen" (func $assembly/index/getPixelsLen))
 (export "getProgramsPtr" (func $assembly/index/getProgramsPtr))
 (export "renderPixels" (func $assembly/index/renderPixels))
 (export "step" (func $assembly/index/step))
 (export "opcodeCount" (func $assembly/index/opcodeCount))
 (export "totalCells" (func $assembly/index/totalCells))
 (export "memory" (memory $0))
 (func $assembly/index/init (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  local.get $0
  global.set $assembly/index/gridWidth
  local.get $1
  global.set $assembly/index/gridHeight
  local.get $2
  global.set $assembly/index/tapeSize
  local.get $0
  local.get $1
  i32.mul
  global.set $assembly/index/numPrograms
  local.get $3
  i64.const 7046029254386353131
  i64.sub
  local.tee $3
  local.get $3
  i64.const 30
  i64.shr_u
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $3
  local.get $3
  i64.const 27
  i64.shr_u
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $3
  local.get $3
  i64.const 31
  i64.shr_u
  i64.xor
  global.set $assembly/index/rngS0
  global.get $assembly/index/rngS0
  i64.const 7046029254386353131
  i64.sub
  local.tee $3
  local.get $3
  i64.const 30
  i64.shr_u
  i64.xor
  i64.const -4658895280553007687
  i64.mul
  local.tee $3
  local.get $3
  i64.const 27
  i64.shr_u
  i64.xor
  i64.const -7723592293110705685
  i64.mul
  local.tee $3
  local.get $3
  i64.const 31
  i64.shr_u
  i64.xor
  global.set $assembly/index/rngS1
  i32.const 1024
  global.set $assembly/index/programsPtr
  global.get $assembly/index/numPrograms
  global.get $assembly/index/tapeSize
  i32.mul
  i32.const 1024
  i32.add
  local.tee $0
  global.set $assembly/index/neighborsPtr
  local.get $0
  global.get $assembly/index/numPrograms
  i32.const 96
  i32.mul
  i32.add
  local.tee $0
  global.set $assembly/index/nCountsPtr
  local.get $0
  global.get $assembly/index/numPrograms
  i32.const 2
  i32.shl
  local.tee $1
  i32.add
  local.tee $0
  global.set $assembly/index/orderPtr
  local.get $0
  local.get $1
  i32.add
  local.tee $0
  global.set $assembly/index/proposalsPtr
  local.get $0
  local.get $1
  i32.add
  local.tee $0
  global.set $assembly/index/pairsPtr
  local.get $0
  global.get $assembly/index/numPrograms
  i32.const 3
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly/index/takenPtr
  local.get $0
  global.get $assembly/index/numPrograms
  i32.add
  local.tee $0
  global.set $assembly/index/tapePtr
  local.get $0
  global.get $assembly/index/tapeSize
  i32.const 1
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly/index/pixelsPtr
  local.get $0
  global.get $assembly/index/gridHeight
  global.get $assembly/index/gridWidth
  i32.const 3
  i32.shl
  i32.mul
  i32.const 5
  i32.shl
  i32.add
  local.tee $0
  global.set $assembly/index/colorLutPtr
  local.get $0
  i32.const 66559
  i32.add
  i32.const 16
  i32.shr_u
  local.tee $1
  memory.size
  local.tee $0
  i32.gt_s
  if
   local.get $1
   local.get $0
   i32.sub
   memory.grow
   drop
  end
  i32.const 0
  local.set $0
  loop $for-loop|0
   local.get $0
   global.get $assembly/index/numPrograms
   global.get $assembly/index/tapeSize
   i32.mul
   i32.lt_s
   if
    global.get $assembly/index/rngS0
    local.set $3
    global.get $assembly/index/rngS1
    local.tee $8
    global.set $assembly/index/rngS0
    local.get $8
    local.get $3
    local.get $3
    i64.const 23
    i64.shl
    i64.xor
    local.tee $3
    local.get $3
    i64.const 17
    i64.shr_u
    i64.xor
    i64.xor
    local.get $8
    i64.const 26
    i64.shr_u
    i64.xor
    global.set $assembly/index/rngS1
    global.get $assembly/index/programsPtr
    local.get $0
    i32.add
    global.get $assembly/index/rngS0
    global.get $assembly/index/rngS1
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
  loop $for-loop|1
   local.get $11
   global.get $assembly/index/gridWidth
   i32.lt_s
   if
    local.get $11
    i32.const 2
    i32.sub
    local.tee $5
    i32.const 0
    i32.lt_s
    if
     i32.const 0
     local.set $5
    end
    local.get $11
    i32.const 3
    i32.add
    local.tee $7
    global.get $assembly/index/gridWidth
    i32.gt_s
    if
     global.get $assembly/index/gridWidth
     local.set $7
    end
    i32.const 0
    local.set $12
    loop $for-loop|2
     local.get $12
     global.get $assembly/index/gridHeight
     i32.lt_s
     if
      local.get $12
      i32.const 2
      i32.sub
      local.tee $4
      i32.const 0
      i32.lt_s
      if
       i32.const 0
       local.set $4
      end
      local.get $12
      i32.const 3
      i32.add
      local.tee $6
      global.get $assembly/index/gridHeight
      i32.gt_s
      if
       global.get $assembly/index/gridHeight
       local.set $6
      end
      local.get $11
      global.get $assembly/index/gridHeight
      i32.mul
      local.get $12
      i32.add
      local.set $10
      i32.const 0
      local.set $2
      local.get $5
      local.set $0
      loop $for-loop|3
       local.get $0
       local.get $7
       i32.lt_s
       if
        local.get $0
        global.get $assembly/index/gridHeight
        i32.mul
        local.set $9
        local.get $4
        local.set $1
        loop $for-loop|4
         local.get $1
         local.get $6
         i32.lt_s
         if
          local.get $1
          local.get $12
          i32.eq
          local.get $0
          local.get $11
          i32.eq
          i32.and
          i32.eqz
          if
           global.get $assembly/index/neighborsPtr
           local.get $10
           i32.const 24
           i32.mul
           local.get $2
           i32.add
           i32.const 2
           i32.shl
           i32.add
           local.get $1
           local.get $9
           i32.add
           i32.store
           local.get $2
           i32.const 1
           i32.add
           local.set $2
          end
          local.get $1
          i32.const 1
          i32.add
          local.set $1
          br $for-loop|4
         end
        end
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        br $for-loop|3
       end
      end
      global.get $assembly/index/nCountsPtr
      local.get $10
      i32.const 2
      i32.shl
      i32.add
      local.get $2
      i32.store
      local.get $12
      i32.const 1
      i32.add
      local.set $12
      br $for-loop|2
     end
    end
    local.get $11
    i32.const 1
    i32.add
    local.set $11
    br $for-loop|1
   end
  end
  i32.const 0
  local.set $0
  loop $for-loop|5
   local.get $0
   i32.const 256
   i32.lt_s
   if
    global.get $assembly/index/colorLutPtr
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
    br $for-loop|5
   end
  end
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
  global.get $assembly/index/colorLutPtr
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
 )
 (func $assembly/index/getPixelsPtr (result i32)
  global.get $assembly/index/pixelsPtr
 )
 (func $assembly/index/getPixelsLen (result i32)
  global.get $assembly/index/gridHeight
  global.get $assembly/index/gridWidth
  i32.const 3
  i32.shl
  i32.mul
  i32.const 5
  i32.shl
 )
 (func $assembly/index/getProgramsPtr (result i32)
  global.get $assembly/index/programsPtr
 )
 (func $assembly/index/renderPixels
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  global.get $assembly/index/gridWidth
  i32.const 3
  i32.shl
  local.set $5
  loop $for-loop|0
   local.get $4
   global.get $assembly/index/gridWidth
   i32.lt_s
   if
    i32.const 0
    local.set $1
    loop $for-loop|1
     local.get $1
     global.get $assembly/index/gridHeight
     i32.lt_s
     if
      global.get $assembly/index/programsPtr
      global.get $assembly/index/tapeSize
      local.get $4
      global.get $assembly/index/gridHeight
      i32.mul
      local.get $1
      i32.add
      i32.mul
      i32.add
      local.set $6
      i32.const 0
      local.set $2
      loop $for-loop|2
       local.get $2
       i32.const 8
       i32.lt_s
       if
        i32.const 0
        local.set $3
        loop $for-loop|3
         local.get $3
         i32.const 8
         i32.lt_s
         if
          global.get $assembly/index/pixelsPtr
          local.get $4
          i32.const 3
          i32.shl
          local.get $3
          i32.add
          local.get $1
          i32.const 3
          i32.shl
          local.get $2
          i32.add
          local.get $5
          i32.mul
          i32.add
          i32.const 2
          i32.shl
          i32.add
          global.get $assembly/index/colorLutPtr
          local.get $6
          local.get $2
          i32.const 3
          i32.shl
          local.get $3
          i32.add
          i32.add
          i32.load8_u
          local.tee $0
          i32.const 255
          local.get $0
          i32.const 62
          i32.eq
          local.get $0
          i32.const 60
          i32.eq
          i32.or
          local.get $0
          i32.const 123
          i32.eq
          i32.or
          local.get $0
          i32.const 125
          i32.eq
          i32.or
          local.get $0
          i32.const 45
          i32.eq
          i32.or
          local.get $0
          i32.const 43
          i32.eq
          i32.or
          local.get $0
          i32.const 46
          i32.eq
          i32.or
          local.get $0
          i32.const 44
          i32.eq
          i32.or
          local.get $0
          i32.const 91
          i32.eq
          i32.or
          local.get $0
          i32.const 93
          i32.eq
          i32.or
          select
          i32.const 255
          i32.and
          i32.const 2
          i32.shl
          i32.add
          i32.load
          i32.store
          local.get $3
          i32.const 1
          i32.add
          local.set $3
          br $for-loop|3
         end
        end
        local.get $2
        i32.const 1
        i32.add
        local.set $2
        br $for-loop|2
       end
      end
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|1
     end
    end
    local.get $4
    i32.const 1
    i32.add
    local.set $4
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/rngBounded (param $0 i32) (result i32)
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
  global.get $assembly/index/rngS0
  local.set $1
  global.get $assembly/index/rngS1
  local.tee $4
  global.set $assembly/index/rngS0
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
  global.set $assembly/index/rngS1
  global.get $assembly/index/rngS0
  global.get $assembly/index/rngS1
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
    global.get $assembly/index/rngS0
    local.set $1
    global.get $assembly/index/rngS1
    local.tee $4
    global.set $assembly/index/rngS0
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
    global.set $assembly/index/rngS1
    global.get $assembly/index/rngS0
    global.get $assembly/index/rngS1
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
 (func $assembly/index/runTape (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  loop $for-loop|0
   local.get $6
   i32.const 8192
   i32.lt_s
   local.get $1
   local.get $5
   i32.gt_u
   i32.and
   if
    local.get $0
    local.get $5
    i32.add
    i32.load8_u
    local.tee $4
    i32.const 60
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
     i32.const 62
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
      i32.const 123
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
       i32.const 125
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
        i32.const 45
        i32.eq
        if
         local.get $0
         local.get $2
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
          local.get $2
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
           local.get $3
           i32.add
           local.get $0
           local.get $2
           i32.add
           i32.load8_u
           i32.store8
          else
           local.get $4
           i32.const 44
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
            i32.const 91
            i32.eq
            if
             local.get $0
             local.get $2
             i32.add
             i32.load8_u
             i32.eqz
             if
              i32.const 1
              local.set $4
              local.get $5
              i32.const 1
              i32.add
              local.set $5
              loop $while-continue|1
               local.get $4
               i32.const 0
               i32.gt_s
               local.get $1
               local.get $5
               i32.gt_s
               i32.and
               if
                local.get $5
                i32.const 1
                i32.add
                local.get $5
                local.get $0
                local.get $5
                i32.add
                i32.load8_u
                local.tee $5
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
                 local.get $5
                 i32.const 93
                 i32.eq
                 select
                end
                local.tee $4
                i32.const 0
                i32.gt_s
                select
                local.set $5
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
              local.get $2
              i32.add
              i32.load8_u
              if
               i32.const 1
               local.set $4
               local.get $5
               i32.const 1
               i32.sub
               local.set $5
               loop $while-continue|2
                local.get $4
                i32.const 0
                i32.gt_s
                local.get $5
                i32.const 0
                i32.ge_s
                i32.and
                if
                 local.get $5
                 i32.const 1
                 i32.sub
                 local.get $5
                 local.get $0
                 local.get $5
                 i32.add
                 i32.load8_u
                 local.tee $5
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
                  local.get $5
                  i32.const 91
                  i32.eq
                  select
                 end
                 local.tee $4
                 i32.const 0
                 i32.gt_s
                 select
                 local.set $5
                 br $while-continue|2
                end
               end
               local.get $4
               if
                return
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
    local.get $5
    i32.const 1
    i32.add
    local.set $5
    local.get $6
    i32.const 1
    i32.add
    local.set $6
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/step (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i64)
  loop $for-loop|0
   local.get $2
   global.get $assembly/index/numPrograms
   i32.lt_s
   if
    global.get $assembly/index/orderPtr
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
  global.get $assembly/index/numPrograms
  i32.const 1
  i32.sub
  local.set $2
  loop $for-loop|1
   local.get $2
   i32.const 0
   i32.gt_s
   if
    local.get $2
    i32.const 1
    i32.add
    call $assembly/index/rngBounded
    local.set $10
    global.get $assembly/index/orderPtr
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    local.tee $9
    i32.load
    local.set $11
    local.get $9
    global.get $assembly/index/orderPtr
    local.get $10
    i32.const 2
    i32.shl
    i32.add
    local.tee $9
    i32.load
    i32.store
    local.get $9
    local.get $11
    i32.store
    local.get $2
    i32.const 1
    i32.sub
    local.set $2
    br $for-loop|1
   end
  end
  loop $for-loop|00
   local.get $3
   global.get $assembly/index/numPrograms
   i32.lt_s
   if
    local.get $3
    i32.const 2
    i32.shl
    local.tee $2
    global.get $assembly/index/nCountsPtr
    i32.add
    i32.load
    local.tee $9
    i32.const 0
    i32.gt_s
    if
     local.get $9
     call $assembly/index/rngBounded
     local.set $9
     global.get $assembly/index/proposalsPtr
     local.get $2
     i32.add
     global.get $assembly/index/neighborsPtr
     local.get $3
     i32.const 24
     i32.mul
     local.get $9
     i32.add
     i32.const 2
     i32.shl
     i32.add
     i32.load
     i32.store
    else
     global.get $assembly/index/proposalsPtr
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
    br $for-loop|00
   end
  end
  global.get $assembly/index/takenPtr
  i32.const 0
  global.get $assembly/index/numPrograms
  memory.fill
  loop $for-loop|01
   local.get $4
   global.get $assembly/index/numPrograms
   i32.lt_s
   if
    block $for-continue|0
     global.get $assembly/index/proposalsPtr
     global.get $assembly/index/orderPtr
     local.get $4
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
     global.get $assembly/index/takenPtr
     local.get $2
     i32.add
     local.tee $9
     i32.load8_u
     br_if $for-continue|0
     global.get $assembly/index/takenPtr
     local.get $3
     i32.add
     local.tee $10
     i32.load8_u
     br_if $for-continue|0
     local.get $9
     i32.const 1
     i32.store8
     local.get $10
     i32.const 1
     i32.store8
     local.get $5
     i32.const 3
     i32.shl
     local.tee $9
     global.get $assembly/index/pairsPtr
     i32.add
     local.get $2
     i32.store
     global.get $assembly/index/pairsPtr
     local.get $9
     i32.const 4
     i32.add
     i32.add
     local.get $3
     i32.store
     local.get $5
     i32.const 1
     i32.add
     local.set $5
    end
    local.get $4
    i32.const 1
    i32.add
    local.set $4
    br $for-loop|01
   end
  end
  global.get $assembly/index/tapeSize
  i32.const 1
  i32.shl
  local.set $2
  loop $for-loop|02
   local.get $5
   local.get $7
   i32.gt_s
   if
    global.get $assembly/index/programsPtr
    global.get $assembly/index/tapeSize
    local.get $7
    i32.const 3
    i32.shl
    local.tee $3
    global.get $assembly/index/pairsPtr
    i32.add
    i32.load
    i32.mul
    i32.add
    local.set $4
    global.get $assembly/index/programsPtr
    global.get $assembly/index/tapeSize
    global.get $assembly/index/pairsPtr
    local.get $3
    i32.const 4
    i32.add
    i32.add
    i32.load
    i32.mul
    i32.add
    local.set $3
    global.get $assembly/index/tapePtr
    local.get $4
    global.get $assembly/index/tapeSize
    memory.copy
    global.get $assembly/index/tapePtr
    global.get $assembly/index/tapeSize
    i32.add
    local.get $3
    global.get $assembly/index/tapeSize
    memory.copy
    global.get $assembly/index/tapePtr
    local.get $2
    call $assembly/index/runTape
    local.get $4
    global.get $assembly/index/tapePtr
    global.get $assembly/index/tapeSize
    memory.copy
    local.get $3
    global.get $assembly/index/tapePtr
    global.get $assembly/index/tapeSize
    i32.add
    global.get $assembly/index/tapeSize
    memory.copy
    local.get $7
    i32.const 1
    i32.add
    local.set $7
    br $for-loop|02
   end
  end
  local.get $0
  i32.const 0
  i32.gt_s
  if
   global.get $assembly/index/numPrograms
   global.get $assembly/index/tapeSize
   i32.mul
   local.set $2
   loop $for-loop|03
    local.get $2
    local.get $8
    i32.gt_s
    if
     local.get $1
     call $assembly/index/rngBounded
     local.get $0
     i32.lt_s
     if
      global.get $assembly/index/rngS0
      local.set $12
      global.get $assembly/index/rngS1
      local.tee $6
      global.set $assembly/index/rngS0
      local.get $12
      local.get $12
      i64.const 23
      i64.shl
      i64.xor
      local.tee $12
      i64.const 17
      i64.shr_u
      local.get $12
      i64.xor
      local.get $6
      i64.xor
      local.get $6
      i64.const 26
      i64.shr_u
      i64.xor
      global.set $assembly/index/rngS1
      global.get $assembly/index/programsPtr
      local.get $8
      i32.add
      global.get $assembly/index/rngS0
      global.get $assembly/index/rngS1
      i64.add
      i64.const 32
      i64.shr_u
      i64.store8
     end
     local.get $8
     i32.const 1
     i32.add
     local.set $8
     br $for-loop|03
    end
   end
  end
 )
 (func $assembly/index/opcodeCount (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  global.get $assembly/index/numPrograms
  global.get $assembly/index/tapeSize
  i32.mul
  local.set $2
  loop $for-loop|0
   local.get $1
   local.get $2
   i32.lt_s
   if
    local.get $0
    i32.const 1
    i32.add
    local.get $0
    global.get $assembly/index/programsPtr
    local.get $1
    i32.add
    i32.load8_u
    local.tee $0
    i32.const 62
    i32.eq
    local.get $0
    i32.const 60
    i32.eq
    i32.or
    local.get $0
    i32.const 123
    i32.eq
    i32.or
    local.get $0
    i32.const 125
    i32.eq
    i32.or
    local.get $0
    i32.const 45
    i32.eq
    i32.or
    local.get $0
    i32.const 43
    i32.eq
    i32.or
    local.get $0
    i32.const 46
    i32.eq
    i32.or
    local.get $0
    i32.const 44
    i32.eq
    i32.or
    local.get $0
    i32.const 91
    i32.eq
    i32.or
    local.get $0
    i32.const 93
    i32.eq
    i32.or
    select
    local.set $0
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $for-loop|0
   end
  end
  local.get $0
 )
 (func $assembly/index/totalCells (result i32)
  global.get $assembly/index/numPrograms
  global.get $assembly/index/tapeSize
  i32.mul
 )
)
