// FIXME: Solve why this macro is not defined

// Static assertions for checks inside SV packages. If the conditions is not true, this will
// trigger an error during elaboration.
`define ASSERT_STATIC_IN_PACKAGE(__name, __prop)              \
  function automatic bit assert_static_in_package_``__name(); \
    bit unused_bit [((__prop) ? 1 : -1)];                     \
    unused_bit = '{default: 1'b0};                            \
    return unused_bit[0];                                     \
  endfunction
