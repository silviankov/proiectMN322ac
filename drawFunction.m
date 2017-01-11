%% Create draw window
%Window dimension based on main display dimensions. Multiple display setups
%might encounter out of bounds windows if display resolutions vary.
dim = 7;
if dim == 3
    createWindow;
else
    createWindowN(dim);
end