clear all;
[VFINX_years, VFINX] = getDataFromFile('HW_1_data/VFINX.csv');
"VFINX loaded"
[VBMFX_years, VBMFX] = getDataFromFile('HW_1_data/VBMFX.csv');
"VBMFX loaded"
[VGSLX_years, VGSLX] = getDataFromFile('HW_1_data/VGSLX.csv');
"VGSLX loaded"

[VGTSX_years, VGTSX] = getDataFromFile('HW_1_data/VBLTX.csv');
"VGTSX loaded"
[VBLTX_years, VBLTX] = getDataFromFile('HW_1_data/VEIEX.csv');
"VBLTX loaded"
[VTIBX_years, VTIBX] = getDataFromFile('HW_1_data/V.csv');
"VTIBX loaded"

[INTC_years, INTC] = getDataFromFile('HW_1_data/VFINX.csv');
"Intel loaded"
[PG_years, PG] = getDataFromFile('HW_1_data/VFINX.csv');
"PG loaded"
[WFC_years, WFC] = getDataFromFile('HW_1_data/VFINX.csv');
"WFC loaded"

numYears = 13;
tradingDays = 252;
data_04 = zeros(tradingDays,8);
data_05 = zeros(tradingDays,8);
data_06 = zeros(tradingDays-1,8);
data_07 = zeros(tradingDays-1,8);
data_08 = zeros(tradingDays+1,8);
data_09 = zeros(tradingDays,8);
data_10 = zeros(tradingDays,8);
data_11 = zeros(tradingDays,8);
data_12 = zeros(tradingDays-2,8);
data_13 = zeros(tradingDays,8);
data_14 = zeros(tradingDays,8);
data_15 = zeros(tradingDays,8);
data_16 = zeros(tradingDays,8);
data_17 = zeros(tradingDays-1,8);
data_18 = zeros(tradingDays-1,8);

data_04(:,1) = getDataForYear(VFINX, VFINX_years, 2004);
data_04(:,2) = getDataForYear(VBMFX, VBMFX_years, 2004);
data_04(:,3) = getDataForYear(VGSLX, VGSLX_years, 2004);
data_04(:,4) = getDataForYear(VGTSX, VGTSX_years, 2004);
data_04(:,5) = getDataForYear(VBLTX, VBLTX_years, 2004);
data_04(:,6) = getDataForYear(INTC, INTC_years, 2004);
data_04(:,7) = getDataForYear(PG, PG_years, 2004);
data_04(:,8) = getDataForYear(WFC, WFC_years, 2004);

data_05(:,1) = getDataForYear(VFINX, VFINX_years, 2005);
data_05(:,2) = getDataForYear(VBMFX, VBMFX_years, 2005);
data_05(:,3) = getDataForYear(VGSLX, VGSLX_years, 2005);
data_05(:,4) = getDataForYear(VGTSX, VGTSX_years, 2005);
data_05(:,5) = getDataForYear(VBLTX, VBLTX_years, 2005);
data_05(:,6) = getDataForYear(INTC, INTC_years, 2005);
data_05(:,7) = getDataForYear(PG, PG_years, 2005);
data_05(:,8) = getDataForYear(WFC, WFC_years, 2005);

data_06(:,1) = getDataForYear(VFINX, VFINX_years, 2006);
data_06(:,2) = getDataForYear(VBMFX, VBMFX_years, 2006);
data_06(:,3) = getDataForYear(VGSLX, VGSLX_years, 2006);
data_06(:,4) = getDataForYear(VGTSX, VGTSX_years, 2006);
data_06(:,5) = getDataForYear(VBLTX, VBLTX_years, 2006);
data_06(:,6) = getDataForYear(INTC, INTC_years, 2006);
data_06(:,7) = getDataForYear(PG, PG_years, 2006);
data_06(:,8) = getDataForYear(WFC, WFC_years, 2006);

data_07(:,1) = getDataForYear(VFINX, VFINX_years, 2007);
data_07(:,2) = getDataForYear(VBMFX, VBMFX_years, 2007);
data_07(:,3) = getDataForYear(VGSLX, VGSLX_years, 2007);
data_07(:,4) = getDataForYear(VGTSX, VGTSX_years, 2007);
data_07(:,5) = getDataForYear(VBLTX, VBLTX_years, 2007);
data_07(:,6) = getDataForYear(INTC, INTC_years, 2007);
data_07(:,7) = getDataForYear(PG, PG_years, 2007);
data_07(:,8) = getDataForYear(WFC, WFC_years, 2007);

data_08(:,1) = getDataForYear(VFINX, VFINX_years, 2008);
data_08(:,2) = getDataForYear(VBMFX, VBMFX_years, 2008);
data_08(:,3) = getDataForYear(VGSLX, VGSLX_years, 2008);
data_08(:,4) = getDataForYear(VGTSX, VGTSX_years, 2008);
data_08(:,5) = getDataForYear(VBLTX, VBLTX_years, 2008);
data_08(:,6) = getDataForYear(INTC, INTC_years, 2008);
data_08(:,7) = getDataForYear(PG, PG_years, 2008);
data_08(:,8) = getDataForYear(WFC, WFC_years, 2008);

data_09(:,1) = getDataForYear(VFINX, VFINX_years, 2009);
data_09(:,2) = getDataForYear(VBMFX, VBMFX_years, 2009);
data_09(:,3) = getDataForYear(VGSLX, VGSLX_years, 2009);
data_09(:,4) = getDataForYear(VGTSX, VGTSX_years, 2009);
data_09(:,5) = getDataForYear(VBLTX, VBLTX_years, 2009);
data_09(:,6) = getDataForYear(INTC, INTC_years, 2009);
data_09(:,7) = getDataForYear(PG, PG_years, 2009);
data_09(:,8) = getDataForYear(WFC, WFC_years, 2009);

data_10(:,1) = getDataForYear(VFINX, VFINX_years, 2010);
data_10(:,2) = getDataForYear(VBMFX, VBMFX_years, 2010);
data_10(:,3) = getDataForYear(VGSLX, VGSLX_years, 2010);
data_10(:,4) = getDataForYear(VGTSX, VGTSX_years, 2010);
data_10(:,5) = getDataForYear(VBLTX, VBLTX_years, 2010);
data_10(:,6) = getDataForYear(INTC, INTC_years, 2010);
data_10(:,7) = getDataForYear(PG, PG_years, 2010);
data_10(:,8) = getDataForYear(WFC, WFC_years, 2010);

data_11(:,1) = getDataForYear(VFINX, VFINX_years, 2011);
data_11(:,2) = getDataForYear(VBMFX, VBMFX_years, 2011);
data_11(:,3) = getDataForYear(VGSLX, VGSLX_years, 2011);
data_11(:,4) = getDataForYear(VGTSX, VGTSX_years, 2011);
data_11(:,5) = getDataForYear(VBLTX, VBLTX_years, 2011);
data_11(:,6) = getDataForYear(INTC, INTC_years, 2011);
data_11(:,7) = getDataForYear(PG, PG_years, 2011);
data_11(:,8) = getDataForYear(WFC, WFC_years, 2011);

data_12(:,1) = getDataForYear(VFINX, VFINX_years, 2012);
data_12(:,2) = getDataForYear(VBMFX, VBMFX_years, 2012);
data_12(:,3) = getDataForYear(VGSLX, VGSLX_years, 2012);
data_12(:,4) = getDataForYear(VGTSX, VGTSX_years, 2012);
data_12(:,5) = getDataForYear(VBLTX, VBLTX_years, 2012);
data_12(:,6) = getDataForYear(INTC, INTC_years, 2012);
data_12(:,7) = getDataForYear(PG, PG_years, 2012);
data_12(:,8) = getDataForYear(WFC, WFC_years, 2012);

data_13(:,1) = getDataForYear(VFINX, VFINX_years, 2013);
data_13(:,2) = getDataForYear(VBMFX, VBMFX_years, 2013);
data_13(:,3) = getDataForYear(VGSLX, VGSLX_years, 2013);
data_13(:,4) = getDataForYear(VGTSX, VGTSX_years, 2013);
data_13(:,5) = getDataForYear(VBLTX, VBLTX_years, 2013);
data_13(:,6) = getDataForYear(INTC, INTC_years, 2013);
data_13(:,7) = getDataForYear(PG, PG_years, 2013);
data_13(:,8) = getDataForYear(WFC, WFC_years, 2013);

data_14(:,1) = getDataForYear(VFINX, VFINX_years, 2014);
data_14(:,2) = getDataForYear(VBMFX, VBMFX_years, 2014);
data_14(:,3) = getDataForYear(VGSLX, VGSLX_years, 2014);
data_14(:,4) = getDataForYear(VGTSX, VGTSX_years, 2014);
data_14(:,5) = getDataForYear(VBLTX, VBLTX_years, 2014);
%data_14(:,6) = getDataForYear(VTIBX, VTIBX_years, 2014);
data_14(:,6) = getDataForYear(INTC, INTC_years, 2014);
data_14(:,7) = getDataForYear(PG, PG_years, 2014);
data_14(:,8) = getDataForYear(WFC, WFC_years, 2014);

data_15(:,1) = getDataForYear(VFINX, VFINX_years, 2015);
data_15(:,2) = getDataForYear(VBMFX, VBMFX_years, 2015);
data_15(:,3) = getDataForYear(VGSLX, VGSLX_years, 2015);
data_15(:,4) = getDataForYear(VGTSX, VGTSX_years, 2015);
data_15(:,5) = getDataForYear(VBLTX, VBLTX_years, 2015);
%data_15(:,6) = getDataForYear(VTIBX, VTIBX_years, 2015);
data_15(:,6) = getDataForYear(INTC, INTC_years, 2015);
data_15(:,7) = getDataForYear(PG, PG_years, 2015);
data_15(:,8) = getDataForYear(WFC, WFC_years, 2015);

data_16(:,1) = getDataForYear(VFINX, VFINX_years, 2016);
data_16(:,2) = getDataForYear(VBMFX, VBMFX_years, 2016);
data_16(:,3) = getDataForYear(VGSLX, VGSLX_years, 2016);
data_16(:,4) = getDataForYear(VGTSX, VGTSX_years, 2016);
data_16(:,5) = getDataForYear(VBLTX, VBLTX_years, 2016);
%data_16(:,6) = getDataForYear(VTIBX, VTIBX_years, 2016);
data_16(:,6) = getDataForYear(INTC, INTC_years, 2016);
data_16(:,7) = getDataForYear(PG, PG_years, 2016);
data_16(:,8) = getDataForYear(WFC, WFC_years, 2016);

data_17(:,1) = getDataForYear(VFINX, VFINX_years, 2017);
data_17(:,2) = getDataForYear(VBMFX, VBMFX_years, 2017);
data_17(:,3) = getDataForYear(VGSLX, VGSLX_years, 2017);
data_17(:,4) = getDataForYear(VGTSX, VGTSX_years, 2017);
data_17(:,5) = getDataForYear(VBLTX, VBLTX_years, 2017);
%data_17(:,6) = getDataForYear(VTIBX, VTIBX_years, 2017);
data_17(:,6) = getDataForYear(INTC, INTC_years, 2017);
data_17(:,7) = getDataForYear(PG, PG_years, 2017);
data_17(:,8) = getDataForYear(WFC, WFC_years, 2017);

data_18(:,1) = getDataForYear(VFINX, VFINX_years, 2018);
data_18(:,2) = getDataForYear(VBMFX, VBMFX_years, 2018);
data_18(:,3) = getDataForYear(VGSLX, VGSLX_years, 2018);
data_18(:,4) = getDataForYear(VGTSX, VGTSX_years, 2018);
data_18(:,5) = getDataForYear(VBLTX, VBLTX_years, 2018);
%data_18(:,6) = getDataForYear(VTIBX, VTIBX_years, 2018);
data_18(:,6) = getDataForYear(INTC, INTC_years, 2018);
data_18(:,7) = getDataForYear(PG, PG_years, 2018);
data_18(:,8) = getDataForYear(WFC, WFC_years, 2018);
