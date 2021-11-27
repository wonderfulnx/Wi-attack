function [phase, wave] = writeComplex( name )
    fid = fopen(name, 'r');
    wave0 = fread(fid, 'float32');
    wave = wave0(1:2:end) + j * wave0(2:2:end);
    wave = wave.';
    phase = angle(wave);
    fclose(fid);
end