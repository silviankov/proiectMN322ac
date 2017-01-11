function [vec_propriu, matErr, matVec_propriu] = metoda_puterii_inverse( A, toleranta, iteratiiMax )
% METODA_PUTERII_INVERSE 
% Proiect MN 322AC 2016-2017 Sem1

    n = length(A);
    y = rand(n,1);
    y = y/norm(y);
    
    i = 0;
    err = 1;
    
    matVec_propriu = zeros(iteratiiMax+1,n);
    matErr = zeros(iteratiiMax+1,1);
    
    matVec_propriu(i+1,:) = y';
    matErr(i+1,1) = err;
    
    while (err > toleranta) 
 
       if (i > iteratiiMax) 
%            disp ('S-a atins numarul maxim de iteratii fara sa se obtina nivelul prescris al tolerantei.') 
           msgbox('S-a atins numarul maxim de iteratii fara sa se obtina nivelul prescris al tolerantei.')
           break;
       end
       
       u = y'*A*y;
       z =(u*eye(n)-A)\y;
       z = z/norm(z);
       err = abs(1-abs(z'*y));
       y = z;
       i = i+1;
       if (i <= iteratiiMax)
            vec_propriu = y;
            matVec_propriu(i+1,:) = vec_propriu';
            matErr(i+1,1) = err;
       end
    end
end

