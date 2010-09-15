tiles =
{
{type="tunnel", define_as="EMPTY_STREET",
[[#######]],
[[=======]],
[[       ]],
[[-------]],
[[       ]],
[[=======]],
[[#######]],
},
{type="tunnel", base="EMPTY_STREET", rotation="90"},

{type="tunnel", define_as="INTERSECTION",
[[#= | =#]],
[[== | ==]],
[[   |   ]],
[[---+---]],
[[   |   ]],
[[== | ==]],
[[#= | =#]],
},

{type="tunnel", define_as="T_INTERSECTION",
[[#= | =#]],
[[== | =#]],
[[   | =#]],
[[---+ =#]],
[[   | =#]],
[[== | =#]],
[[#= | =#]],
},
{type="tunnel", base="T_INTERSECTION", rotation="90"},
{type="tunnel", base="T_INTERSECTION", rotation="180"},
{type="tunnel", base="T_INTERSECTION", rotation="270"},

{type="tunnel", define_as="CORNER_STREET",
[[#= | =#]],
[[== | =#]],
[[   | =#]],
[[---+ =#]],
[[     =#]],
[[======#]],
[[#######]],
},
{type="room", base="CORNER_STREET", rotation="90"},
{type="room", base="CORNER_STREET", rotation="180"},
{type="room", base="CORNER_STREET", rotation="270"},

{type="tunnel", define_as="BUILDING",
[[#######]],
[[#######]],
[[#######]],
[[#######]],
[[#######]],
[[#######]],
[[#######]],
},
{type="tunnel", define_as="BUILDING2",
[[##############]],
[[#____________#]],
[[#____________#]],
[[#____________#]],
[[#____________#]],
[[#____________#]],
[[##############]],
},
}