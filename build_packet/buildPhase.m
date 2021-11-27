function phase_seq = buildPhase(tx, tx_template, p_ini, p_diff)
%
% Syntax: phase_seq = buildPhase(tx, tx_template)
%
    phi = p_diff;
    pre = tx_template(tx(1) * 8 + tx(2) * 4 + tx(3) * 2 + tx(4) * 1 + 1,:) + p_ini + (2 * tx(1) - 1) * phi;
    for m = 1:length(tx) / 4 - 1
        line = tx(1 + m * 4) * 8 + tx(2 + m * 4) * 4 + tx(3 + m * 4) * 2 + tx(4 + m * 4) * 1 + 1;
        pre = [pre, tx_template(line,:) + pre(end) + (2 * tx(1 + m * 4) - 1) * phi];
    end
    phase_seq = pre;
end