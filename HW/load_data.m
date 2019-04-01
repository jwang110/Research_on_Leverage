% clear all;
% [VFINX_years, VFINX] = getDataFromFile('HW_1_data/VFINX.csv');
% disp('VFINX loaded');
% [VBMFX_years, VBMFX] = getDataFromFile('HW_1_data/VBMFX.csv');
% disp('VBMFX loaded');
% [VGSLX_years, VGSLX] = getDataFromFile('HW_1_data/VGSLX.csv');
% disp('VGSLX loaded');
% 
% [VBLTX_years, VBLTX] = getDataFromFile('HW_1_data/VBLTX.csv');
% disp('VBLTX loaded');
% [VEIEX_years, VEIEX] = getDataFromFile('HW_1_data/VEIEX.csv');
% disp('VEIEX loaded');
% [VIMSX_years, VIMSX] = getDataFromFile('HW_1_data/VIMSX.csv');
% disp('VIMSX loaded');
% 
% [MSFT_years, MSFT] = getDataFromFile('HW_1_data/MSFT.csv');
% disp('Microsoft loaded');
% [WFC_years, WFC] = getDataFromFile('HW_1_data/WFC.csv');
% disp('Wells Fargo loaded');
% [UPS_years, UPS] = getDataFromFile('HW_1_data/UPS.csv');
% disp('UPS loaded');

numYears = 13;
tradingDays = 252;

data_14 = zeros(tradingDays,9);
data_15 = zeros(tradingDays,9);
data_16 = zeros(tradingDays,9);
data_17 = zeros(tradingDays-1,9);
data_18 = zeros(tradingDays-1,9);

getDataForYear(MSFT, MSFT_years,2018)


data_14(:,1) = getDataForYear(VFINX, VFINX_years, 2014);
data_14(:,2) = getDataForYear(VBMFX, VBMFX_years, 2014);
data_14(:,3) = getDataForYear(VGSLX, VGSLX_years, 2014);
data_14(:,4) = getDataForYear(VBLTX, VBLTX_years, 2014);
data_14(:,5) = getDataForYear(VEIEX, VEIEX_years, 2014);
data_14(:,6) = getDataForYear(MSFT, MSFT_years, 2014);
data_14(:,8) = getDataForYear(WFC, WFC_years, 2014);
data_14(:,9) = getDataForYear(UPS, UPS_years, 2014);

data_15(:,1) = getDataForYear(VFINX, VFINX_years, 2015);
data_15(:,2) = getDataForYear(VBMFX, VBMFX_years, 2015);
data_15(:,3) = getDataForYear(VGSLX, VGSLX_years, 2015);
data_15(:,4) = getDataForYear(VBLTX, VBLTX_years, 2015);
data_15(:,5) = getDataForYear(VEIEX, VEIEX_years, 2015);
data_15(:,6) = getDataForYear(MSFT, MSFT_years, 2015);
data_15(:,8) = getDataForYear(WFC, WFC_years, 2015);
data_15(:,9) = getDataForYear(UPS, UPS_years, 2015);

data_16(:,1) = getDataForYear(VFINX, VFINX_years, 2016);
data_16(:,2) = getDataForYear(VBMFX, VBMFX_years, 2016);
data_16(:,3) = getDataForYear(VGSLX, VGSLX_years, 2016);
data_16(:,4) = getDataForYear(VBLTX, VBLTX_years, 2016);
data_16(:,5) = getDataForYear(VEIEX, VEIEX_years, 2016);
data_16(:,6) = getDataForYear(MSFT, MSFT_years, 2016);
data_16(:,8) = getDataForYear(WFC, WFC_years, 2016);
data_16(:,9) = getDataForYear(UPS, UPS_years, 2016);

data_17(:,1) = getDataForYear(VFINX, VFINX_years, 2017);
data_17(:,2) = getDataForYear(VBMFX, VBMFX_years, 2017);
data_17(:,3) = getDataForYear(VGSLX, VGSLX_years, 2017);
data_17(:,4) = getDataForYear(VBLTX, VBLTX_years, 2017);
data_17(:,5) = getDataForYear(VEIEX, VEIEX_years, 2017);
data_17(:,6) = getDataForYear(MSFT, MSFT_years, 2017);
data_17(:,8) = getDataForYear(WFC, WFC_years, 2017);
data_17(:,9) = getDataForYear(UPS, UPS_years, 2017);

data_18(:,1) = getDataForYear(VFINX, VFINX_years, 2018);
data_18(:,2) = getDataForYear(VBMFX, VBMFX_years, 2018);
data_18(:,3) = getDataForYear(VGSLX, VGSLX_years, 2018);
data_18(:,4) = getDataForYear(VBLTX, VBLTX_years, 2018);
data_18(:,5) = getDataForYear(VEIEX, VEIEX_years, 2018);
data_18(:,6) = getDataForYear(MSFT, MSFT_years, 2018);
data_18(:,8) = getDataForYear(WFC, WFC_years, 2018);
data_18(:,9) = getDataForYear(UPS, UPS_years, 2018);

data_years = {data_14, data_15, data_16, data_17, data_18};
A ={data_14(:,1:3),data_15(:,1:3),data_16(:,1:3),data_17(:,1:3),data_18(:,1:3)};
B ={data_14(:,4:6),data_15(:,4:6),data_16(:,4:6),data_17(:,4:6),data_18(:,4:6)};
C ={data_14(:,7:9),data_15(:,7:9),data_16(:,7:9),data_17(:,7:9),data_18(:,7:9)};
data_group = {A, B, C};

%clearvars -except data_years data_group
