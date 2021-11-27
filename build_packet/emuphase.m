
% load templates for original packet and compensate packet
load('emuphaseTemplate'); bits = emuphaseTemplate;
load('symbol_dev/emuphaseTemplate_dev2.mat'); bits_2 = emuphaseTemplate_2;
load('symbol_dev/emuphaseTemplate_4_new.mat'); bits_3 = emuphaseTemplate_3;

% load BLE bits
load('tx_bits_AltBeacon');
tx_bits = tx_bits_AltBeacon;
% load('tx_bits_iBeacon');
% tx_bits = tx_bits_iBeacon;

% build 3 packets' phases
phase = buildPhase(tx_bits, bits, 0, pi/2);
phase2 = buildPhase(tx_bits, bits_2, phase(end), pi/2);
phase3 = buildPhase(tx_bits, bits_3, phase2(end), pi/3);

% output packet
phase_fin = [phase, phase2, phase3];
name='phase_3beacon';
signal = writeComplex(name, phase_fin)
