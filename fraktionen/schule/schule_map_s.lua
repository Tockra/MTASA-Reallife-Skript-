﻿local Klassenzimmer = {
createObject ( 8231, 1658.515625, -1384.5302734375, 46.93367767334, 0, 0, 90 ),
createObject ( 8231, 1658.5477294922, -1373.3217773438, 46.914482116699, 0, 0, 270 ),
createObject ( 2911, 1650.3912353516, -1375.5921630859, 45.209465026855 ),
createObject ( 2173, 1652.4874267578, -1376.1149902344, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1652.2459716797, -1378.6011962891, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1654.2434082031, -1378.6920166016, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1654.3045654297, -1376.1514892578, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1656.7028808594, -1376.2696533203, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1656.7237548828, -1378.7364501953, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1659.3212890625, -1378.7847900391, 45.23055267334, 0, 0, 270 ),
createObject ( 2173, 1659.4201660156, -1376.2836914062, 45.23055267334, 0, 0, 270 ),
createObject ( 1720, 1652.0700683594, -1376.6496582031, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1653.8695068359, -1376.6694335938, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1656.3530273438, -1376.7723388672, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1659.0700683594, -1376.7322998047, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1658.818359375, -1379.2713623047, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1656.4267578125, -1379.2376708984, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1653.9616699219, -1379.2037353516, 45.120178222656, 0, 0, 90 ),
createObject ( 1720, 1651.669921875, -1379.1877441406, 45.120178222656, 0, 0, 90 ),
createObject ( 3077, 1665.8811035156, -1377.1622314453, 44.976760864258, 0, 0, 270 ),
createObject ( 2169, 1662.4769287109, -1379.7630615234, 45.23055267334, 0, 0, 90 ),
createObject ( 1806, 1663.2532958984, -1379.2238769531, 45.163368225098, 0, 0, 90 ),
createObject ( 2289, 1657.9016113281, -1375.6423339844, 47.373775482178 ),
createObject ( 3077, 1665.8702392578, -1380.6435546875, 44.976760864258, 0, 0, 270 ),
createObject ( 2287, 1653.1202392578, -1376.1085205078, 47.032207489014 ),
createObject ( 1893, 1663.5551757812, -1378.5163574219, 48.829273223877, 0, 0, 268 ),
createObject ( 1893, 1661.0123291016, -1378.5847167969, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 1893, 1659.0126953125, -1378.62890625, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 1893, 1657.2635498047, -1378.6682128906, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 1893, 1656.0133056641, -1378.6960449219, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 1893, 1654.5134277344, -1378.7290039062, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 1893, 1653.2633056641, -1378.7565917969, 48.829273223877, 0, 0, 267.99499511719 ),
createObject ( 2970, 1650.0771484375, -1380.5570068359, 45.23055267334 ),
createObject ( 3077, 1658.3857421875, -1382.2521972656, 44.976760864258, 0, 0, 180 ),
createObject ( 14632, 1659.3173828125, -1383.48046875, 45.050453186035 ),
createObject ( 3077, 1665.9013671875, -1383.8529052734, 44.976760864258, 0, 0, 270 ),
createObject ( 3077, 1665.8547363281, -1373.8760986328, 44.976760864258, 0, 0, 270 )
}

for i,v in pairs(Klassenzimmer) do
	setElementInterior(v,3)
	setElementDimension(v,5)
end