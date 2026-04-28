function x = fourierPositionalEmbedding(x,maxfreq)
    % This function extends an input x with "Fourier features", 
    % cos(f*x) and sin(f*x) 
    % for frequencies f = 1:maxfreq.
    %
    % There's various references to this sort of thing in literature. 
    %
    % Assume x is CxN and in [-1,1]
    f = x*pi;
    F = permute(1:maxfreq,[1,3,2]);
    f = f.*F;
    f = permute(f,[1,3,2]);
    f = reshape(f,[],size(x,2));
    x = cat(1,x,cos(f),sin(f));
end