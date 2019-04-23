clear all;
VFINX = getDataFromFile('data_2002/VFINX.csv');
disp('VFINX loaded');
VBMFX = getDataFromFile('data_2002/VBMFX.csv');
disp('VBMFX loaded');
VGSLX = getDataFromFile('data_2002/VGSLX.csv');
disp('VGSLX loaded');

VBLTX = getDataFromFile('data_2002/VBLTX.csv');
disp('VBLTX loaded');
VEIEX = getDataFromFile('data_2002/VEIEX.csv');
disp('VEIEX loaded');
VIMSX = getDataFromFile('data_2002/VIMSX.csv');
disp('VIMSX loaded');

MSFT = getDataFromFile('data_2002/MSFT.csv');
disp('Microsoft loaded');
WFC = getDataFromFile('data_2002/WFC.csv');
disp('Wells Fargo loaded');
UPS = getDataFromFile('data_2002/UPS.csv');
disp('UPS loaded');

data = {VFINX, VBMFX, VGSLX, VBLTX, VEIEX, VIMSX, MSFT, WFC, UPS};
labels = {"VFINX", "VBMFX", "VGSLX", "VBLTX", "VEIEX", "VIMSX", "MSFT", "WFC", "UPS"};
clearvars -except data_cell labels