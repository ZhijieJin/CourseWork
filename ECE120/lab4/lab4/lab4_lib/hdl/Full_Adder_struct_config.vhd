-- Generation properties:
--   Format              : hierarchical
--   Generic mappings    : exclude
--   Leaf-level entities : direct binding
--   Regular libraries   : use library name
--   View name           : include
--   
LIBRARY lab4_lib;
CONFIGURATION Full_Adder_struct_config OF Full_Adder IS
   FOR struct
      FOR ALL : my_xor
         USE CONFIGURATION lab4_lib.my_xor_struct_config;
      END FOR;
   END FOR;
END Full_Adder_struct_config;
