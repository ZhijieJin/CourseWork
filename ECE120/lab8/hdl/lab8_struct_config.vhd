-- Generation properties:
--   Format              : hierarchical
--   Generic mappings    : exclude
--   Leaf-level entities : direct binding
--   Regular libraries   : use library name
--   View name           : include
--   
LIBRARY lab8_lib;
CONFIGURATION lab8_struct_config OF lab8 IS
   FOR struct
      FOR ALL : Control_Logic
         USE CONFIGURATION lab8_lib.Control_Logic_struct_config;
      END FOR;
      FOR ALL : Next_State_Logic
         USE CONFIGURATION lab8_lib.Next_State_Logic_struct_config;
      END FOR;
   END FOR;
END lab8_struct_config;
