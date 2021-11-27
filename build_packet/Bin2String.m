function str = Bin2String(bin)
% string2bi - convert binary to string
% tuned for ble packet
%
% Syntax: bits = Bin2String(str)
%
    mapping = '0123456789ABCDEF';
    str = "0x";
    % for i = 1:8:length(bin)
    %     str = [str, mapping(bin(i+4) * 1 + bin(i+5) * 2 + bin(i+6) * 4 + bin(i+7) * 8 + 1), mapping(bin(i) * 1 + bin(i+1) * 2 + bin(i+2) * 4 + bin(i+3) * 8 + 1)];
    % end
    for i = 1:4:length(bin)
        str = [str, mapping(bin(i) * 8 + bin(i+1) * 4 + bin(i+2) * 2 + bin(i+3) + 1)];
    end
    fprintf("%s", str);
    fprintf("\n");
end
        