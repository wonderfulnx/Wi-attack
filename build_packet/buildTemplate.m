
% build the symbol template
bits = [];
root_dir = 'symbol/emu/';
[p, ~] = readComplex([root_dir, '0000']); pd = p(1); bits(1, :) = p - pd;
[p, ~] = readComplex([root_dir, '0001']); pd = p(1); bits(2, :) = p - pd;
[p, ~] = readComplex([root_dir, '0010']); pd = p(1); bits(3, :) = p - pd;
[p, ~] = readComplex([root_dir, '0011']); pd = p(1); bits(4, :) = p - pd;
[p, ~] = readComplex([root_dir, '0100']); pd = p(1); bits(5, :) = p - pd;
[p, ~] = readComplex([root_dir, '0101']); pd = p(1); bits(6, :) = p - pd;
[p, ~] = readComplex([root_dir, '0110']); pd = p(1); bits(7, :) = p - pd;
[p, ~] = readComplex([root_dir, '0111']); pd = p(1); bits(8, :) = p - pd;
[p, ~] = readComplex([root_dir, '1000']); pd = p(1); bits(9, :) = p - pd;
[p, ~] = readComplex([root_dir, '1001']); pd = p(1); bits(10, :) = p - pd;
[p, ~] = readComplex([root_dir, '1010']); pd = p(1); bits(11, :) = p - pd;
[p, ~] = readComplex([root_dir, '1011']); pd = p(1); bits(12, :) = p - pd;
[p, ~] = readComplex([root_dir, '1100']); pd = p(1); bits(13, :) = p - pd;
[p, ~] = readComplex([root_dir, '1101']); pd = p(1); bits(14, :) = p - pd;
[p, ~] = readComplex([root_dir, '1110']); pd = p(1); bits(15, :) = p - pd;
[p, ~] = readComplex([root_dir, '1111']); pd = p(1); bits(16, :) = p - pd;

emuphaseTemplate = bits;
