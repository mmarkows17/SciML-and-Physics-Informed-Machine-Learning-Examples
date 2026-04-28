function W = glorot(nin,nout)
    % Glorot initialization
    scale = sqrt(6/(nin+nout));
    W = 2*rand(nout,nin) - 1;
    W = scale*W;
end