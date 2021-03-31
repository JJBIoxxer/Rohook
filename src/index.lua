local Rohook = {}
Rohook.__index = Rohook

--> Require all the utility functions needed for this module.
local _Unpack = require(script.Parent.util.Unpack)

--> Load all the constructors using the "Unpack" utility function.
_Unpack(script.Parent.constructors, Rohook)

--> Create a watermark in the console.
print("Rohook (V0.2.1.BETA) by JJBIoxxer has loaded successfully.")

--> Return the module data.
return Rohook