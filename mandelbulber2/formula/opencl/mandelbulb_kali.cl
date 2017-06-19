/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mandelbulb Kali modification
 * @reference http://www.fractalforums.com/theory/mandelbulb-variant/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 MandelbulbKaliIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}

	float th0 = acos(native_divide(z.z, aux->r)) + fractal->bulb.betaAngleOffset
							+ 1e-030f; // MUST keep exception catch
	float ph0 = atan(native_divide(z.y, z.x)) + fractal->bulb.alphaAngleOffset;
	th0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleA1;
	float sinth = native_sin(th0);
	z = aux->r * (float4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0f};

	th0 = acos(native_divide(z.z, aux->r)) + fractal->transformCommon.betaAngleOffset
				+ 1e-030f; // MUST keep exception catch ??;
	ph0 = atan(native_divide(z.y, z.x));
	ph0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleB1;
	float zp = native_powr(aux->r, fractal->transformCommon.pwr8);
	sinth = native_sin(th0);
	z = zp * (float4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0f};

	if (fractal->analyticDE.enabledFalse)
	{ // analytic log DE adjustment
		aux->r_dz = mad(native_powr(aux->r, fractal->transformCommon.pwr8 - fractal->analyticDE.offset1)
											* aux->r_dz * fractal->transformCommon.pwr8,
			fractal->analyticDE.scale1, fractal->analyticDE.offset2);
	}
	else // default, i.e. scale1 & offset1 & offset2 = 1.0f
	{
		aux->r_dz =
			mad(native_powr(aux->r, fractal->transformCommon.pwr8 - 1.0f) * fractal->transformCommon.pwr8,
				aux->r_dz, 1.0f);
	}
	return z;
}
#else
double4 MandelbulbKaliIteration(double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}

	double th0 = acos(native_divide(z.z, aux->r)) + fractal->bulb.betaAngleOffset
							 + 1e-061; // MUST keep exception catch
	double ph0 = atan(native_divide(z.y, z.x)) + fractal->bulb.alphaAngleOffset;
	th0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleA1;
	double sinth = native_sin(th0);
	z = aux->r * (double4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0};

	th0 = acos(native_divide(z.z, aux->r)) + fractal->transformCommon.betaAngleOffset
				+ 1e-061; // MUST keep exception catch ??;
	ph0 = atan(native_divide(z.y, z.x));
	ph0 *= fractal->transformCommon.pwr8 * fractal->transformCommon.scaleB1;
	double zp = native_powr(aux->r, fractal->transformCommon.pwr8);
	sinth = native_sin(th0);
	z = zp * (double4){sinth * native_cos(ph0), native_sin(ph0) * sinth, native_cos(th0), 0.0};

	if (fractal->analyticDE.enabledFalse)
	{ // analytic log DE adjustment
		aux->r_dz = mad(native_powr(aux->r, fractal->transformCommon.pwr8 - fractal->analyticDE.offset1)
											* aux->r_dz * fractal->transformCommon.pwr8,
			fractal->analyticDE.scale1, fractal->analyticDE.offset2);
	}
	else // default, i.e. scale1 & offset1 & offset2 = 1.0
	{
		aux->r_dz = native_powr(aux->r, fractal->transformCommon.pwr8 - 1.0)
									* fractal->transformCommon.pwr8 * aux->r_dz
								+ 1.0;
	}
	return z;
}
#endif
