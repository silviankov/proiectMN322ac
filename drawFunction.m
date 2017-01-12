function drawFunction(matErr, matVec_proprii, tolerance, vec_propriu)
% Create draw window
%Window dimension based on main display dimensions. Multiple display setups
%might encounter out of bounds windows if display resolutions vary.

if (length(matVec_proprii(1,:)) == 3)
    createWindow(matErr, matVec_proprii, tolerance, vec_propriu);
else
    createWindowN(matErr, matVec_proprii, tolerance, vec_propriu);
end

end


