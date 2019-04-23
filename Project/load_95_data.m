clear all;
VFINX = getDataFromFile('data_1995/VFINX.csv');
disp('VFINX loaded');
VBMFX_years = getDataFromFile('data_1995/VBMFX.csv');
disp('VBMFX loaded');

VBLTX = getDataFromFile('data_1995/VBLTX.csv');
disp('VBLTX loaded');
VEIEX = getDataFromFile('data_1995/VEIEX.csv');
disp('VEIEX loaded');

MSFT = getDataFromFile('data_1995/MSFT.csv');
disp('Microsoft loaded');
WFC = getDataFromFile('data_1995/WFC.csv');
disp('Wells Fargo loaded');

cell_data = {VFINX, VBMFX, VBLTX, VEIEX, MSFT, WFC};
label_data = {"VFINX", "VBMFX", "VBLTX", "VEIEX", "MSFT", "WFC"};

clearvars -except cell_data label_data
