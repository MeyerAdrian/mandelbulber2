/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * abs add conditional2.

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfAbsAddConditional2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAbsAddConditional2Iteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 Offset = fractal->transformCommon.offset111;
	REAL4 OffsetA = fractal->transformCommon.offsetA111;

	if (fractal->transformCommon.functionEnabled) OffsetA = Offset;

	if (fractal->transformCommon.functionEnabledx)
	{
		if (z.x < OffsetA.x) z.x = (fabs(z.x) - Offset.x) + Offset.x;
	}
	if (fractal->transformCommon.functionEnabledy)
	{
		if (z.y < OffsetA.y) z.y = (fabs(z.y) - Offset.y) + Offset.y;
	}
	if (fractal->transformCommon.functionEnabledz)
	{
		if (z.z < OffsetA.z) z.z = (fabs(z.z) - Offset.z) + Offset.z;
	}

	aux->DE *= fractal->analyticDE.scale1; // DE tweak
	return z;
}