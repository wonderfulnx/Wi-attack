function [signal, wave] = writeComplex( name,phase )
    fid = fopen(name, 'w+');
    wave = cos(phase) + j * sin(phase);
    wavezigbee0 = [real(wave).', imag(wave).'].';
    wavezigbee0 = wavezigbee0(:);
    fwrite(fid, wavezigbee0, 'float32');
    fclose(fid);
    signal = 1;
end