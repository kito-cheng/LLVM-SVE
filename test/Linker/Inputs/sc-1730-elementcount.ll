%struct.bar = type { i32, float }

define void @foo2(<n x 2 x %struct.bar*> %arg) {
  ret void
}

